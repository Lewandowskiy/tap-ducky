import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/router.dart';
import '../../state/controllers/app_settings_controller.dart';
import '../../state/controllers/hid_status_controller.dart';
import 'about_screen.dart';
import 'widgets/donation_sheet.dart';
import 'widgets/section_card.dart';
import 'widgets/dynamic_colors_tile.dart';
import 'widgets/support_pill.dart';

import '../../state/controllers/locale_controller.dart';
import '../../extension/context_extensions.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const String _repoUrl = 'https://github.com/iodn/tap-ducky';
  static const String _issuesUrl = 'https://github.com/iodn/tap-ducky/issues';
  static const String _liberapayUrl = 'https://liberapay.com/KaijinLab/donate';

  String _speedLabel(double multiplier, l10n) {
    if (multiplier >= 3.0) return l10n.verySlow;
    if (multiplier >= 1.5) return l10n.slow;
    if (multiplier >= 0.9 && multiplier <= 1.1) return l10n.normal;
    if (multiplier >= 0.5) return l10n.fast;
    return l10n.veryFast;
  }

  String _typingSpeedLabel(double factor, l10n) {
    if (factor <= 0.4) return l10n.veryFast;
    if (factor <= 0.8) return l10n.fast;
    if (factor <= 1.2) return l10n.normal;
    if (factor <= 2.5) return l10n.slow;
    return l10n.verySlow;
  }

  Future<void> _resetExecutionDefaults(WidgetRef ref) async {
    final controller = ref.read(appSettingsControllerProvider.notifier);
    await controller.setEnableLogging(true);
    await controller.setDelayMultiplier(1.0);
    await controller.setTypingSpeedFactor(1.0);
    await controller.setRandomizeTiming(true);
    await controller.setHidGraceWindowMs(1500);
    await controller.setUnicodeFallbackMode('warn');
    await controller.setRiskyFastMode(false);
    await controller.setKeepScreenOn(false);
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      final canLaunch = await canLaunchUrl(uri);
      if (!canLaunch) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.noBrowserAvailable),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.failedToOpenError(e.toString())),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _confirmResetAll(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.resetAllSettingsQuestionMark),
        content: Text(context.l10n.thisWillRestoreAllSettingsToTheirDefaults),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(context.l10n.cancel)),
          FilledButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text(context.l10n.reset)),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(appSettingsControllerProvider.notifier).resetAllToDefaults();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.settingsResetToDefaults)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsControllerProvider);
    final hid = ref.watch(hidStatusControllerProvider);
    final currentLocale = ref.watch(localeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
        actions: [
          IconButton(
            tooltip: context.l10n.device,
            onPressed: () => context.push(const DeviceRoute().location),
            icon: const Icon(Icons.phone_android),
          ),
        ],
      ),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(context.l10n.failedToLoadSettingsError(e.toString()))),
        data: (s) {
          final clampedMultiplier = s.delayMultiplier.clamp(0.1, 4.0);
          return ListView(
            children: [
              const SizedBox(height: 10),
              _buildDonationsSection(context, ref),
              const SizedBox(height: 10),
              _buildLanguageSection(context, ref, currentLocale),
              const SizedBox(height: 10),
              _buildAppearanceSection(context, ref, s.themeMode),
              const SizedBox(height: 10),
              _buildExecutionSection(context, ref, s, clampedMultiplier),
              const SizedBox(height: 10),
              _buildStealthSection(context),
              const SizedBox(height: 10),
              _buildStoreLinkSection(context),
              const SizedBox(height: 10),
              _buildAdvancedLinkSection(context),
              const SizedBox(height: 10),
              _buildHidControlSection(context, ref, hid),
              const SizedBox(height: 10),
              _buildAboutSection(context),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    onPressed: () => _confirmResetAll(context, ref),
                    icon: const Icon(Icons.restart_alt, size: 18),
                    label: Text(context.l10n.resetAllSettings),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, WidgetRef ref, Locale currentLocale) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        leading: const Icon(Icons.language),
        title: Text(context.l10n.language),
        trailing: DropdownButton<Locale>(
          value: currentLocale,
          underline: const SizedBox(),
          items: const [
            DropdownMenuItem(
              value: Locale('en'),
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: Locale('ru'),
              child: Text('Русский'),
            ),
          ],
          onChanged: (Locale? newLocale) async {
            if (newLocale != null && newLocale != currentLocale) {
              await ref.read(localeControllerProvider.notifier).setLocale(newLocale);
              Phoenix.rebirth(context);
            }
          },
        ),
      ),
    );
  }
  Widget _buildDonationsSection(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.supportDevelopment,
        subtitle: context.l10n.keepThisAppFastFreeAndMaintained,
        leading: Icon(Icons.volunteer_activism_rounded, color: cs.primary),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      cs.secondaryContainer.withOpacity(0.7),
                      cs.secondaryContainer.withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: cs.outlineVariant.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  context.l10n.supportDescription,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSecondaryContainer,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _openDonationSheet(context),
                      icon: const Icon(Icons.favorite_rounded),
                      label: Text(context.l10n.donate),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _launchUrl(context, 'https://github.com/iodn/tap-ducky'),
                      onLongPress: () => _copyToClipboard(
                        context,
                        text: 'https://github.com/iodn/tap-ducky',
                        message: context.l10n.repositoryLinkCopied,
                      ),
                      icon: const Icon(Icons.star_border_rounded),
                      label: Text(context.l10n.starRepo),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SupportPill(
                      icon: Icons.lock_outline_rounded, label: context.l10n.localOnly),
                  SupportPill(
                      icon: Icons.shield_outlined, label: context.l10n.noTracking),
                  SupportPill(
                      icon: Icons.speed_rounded, label: context.l10n.lightweight),
                  SupportPill(
                      icon: Icons.code_rounded, label: context.l10n.openSource),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppearanceSection(
      BuildContext context, WidgetRef ref, ThemeMode mode) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.appearance,
        subtitle: context.l10n.customizeYourVisualExperience,
        leading: Icon(Icons.palette_outlined, color: cs.primary),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      cs.primaryContainer.withOpacity(0.6),
                      cs.primaryContainer.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: cs.primary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getThemeIcon(mode),
                        size: 20,
                        color: cs.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getThemeName(mode, context.l10n),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: cs.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _getThemeDescription(mode, context.l10n),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onPrimaryContainer.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ThemeCard(
                      icon: Icons.auto_awesome_rounded,
                      label: context.l10n.auto,
                      isSelected: mode == ThemeMode.system,
                      onTap: () => _changeTheme(ref, ThemeMode.system),
                      theme: theme,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ThemeCard(
                      icon: Icons.light_mode_rounded,
                      label: context.l10n.light,
                      isSelected: mode == ThemeMode.light,
                      onTap: () => _changeTheme(ref, ThemeMode.light),
                      theme: theme,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ThemeCard(
                      icon: Icons.dark_mode_rounded,
                      label: context.l10n.dark,
                      isSelected: mode == ThemeMode.dark,
                      onTap: () => _changeTheme(ref, ThemeMode.dark),
                      theme: theme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
             DynamicColorsTile(),
             const SizedBox(height: 12),
             Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: cs.outlineVariant.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, size: 16, color: cs.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getThemeHint(mode, context.l10n),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExecutionSection(
    BuildContext context,
    WidgetRef ref,
    dynamic s,
    double clampedMultiplier,
  ) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.execution,
        subtitle: context.l10n.controlPayloadBehaviorAndTiming,
        leading: Icon(Icons.play_arrow, color: cs.primary),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.speedAndTiming,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _resetExecutionDefaults(ref),
                    icon: const Icon(Icons.refresh, size: 16),
                    label: Text(context.l10n.resetDefaults),
                  ),
                ],
              ),
              Text(
                context.l10n.adjustScriptDelaysAndRawKeyPressTiming,
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.executionSpeed,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    context.l10n.executionSpeedMultiplier(_speedLabel(s.delayMultiplier, context.l10n), s.delayMultiplier.toStringAsFixed(2)),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Slider(
                value: clampedMultiplier,
                min: 0.1,
                max: 4.0,
                divisions: 39,
                label: '${s.delayMultiplier.toStringAsFixed(2)}×',
                onChanged: (v) => ref
                    .read(appSettingsControllerProvider.notifier)
                    .setDelayMultiplier(v),
              ),
              Row(
                children: [
                  Text(context.l10n.fast,
                      style: TextStyle(
                          fontSize: 12, color: cs.onSurfaceVariant)),
                  const Spacer(),
                  Text(context.l10n.slow,
                      style: TextStyle(
                          fontSize: 12, color: cs.onSurfaceVariant)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.typingSpeed,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    context.l10n.typingSpeedMultiplier(_typingSpeedLabel(s.typingSpeedFactor, context.l10n), s.typingSpeedFactor.toStringAsFixed(2)),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Slider(
                value: s.typingSpeedFactor.clamp(0.1, 10.0),
                min: 0.1,
                max: 10.0,
                divisions: 99,
                label: '${s.typingSpeedFactor.toStringAsFixed(2)}×',
                onChanged: (v) => ref
                    .read(appSettingsControllerProvider.notifier)
                    .setTypingSpeedFactor(v),
              ),
              Row(
                children: [
                  Text(context.l10n.fast,
                      style: TextStyle(
                          fontSize: 12, color: cs.onSurfaceVariant)),
                  const Spacer(),
                  Text(context.l10n.slow,
                      style: TextStyle(
                          fontSize: 12, color: cs.onSurfaceVariant)),
                ],
              ),
              Text(
                context.l10n.lowerIsFaster,
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _SpeedPresetChip(
                    label: context.l10n.ultraFast,
                    multiplier: 0.1,
                    current: s.delayMultiplier,
                    onSelected: () => ref
                        .read(appSettingsControllerProvider.notifier)
                        .setDelayMultiplier(0.1),
                    tooltip: context.l10n.ultraFastDescription,
                  ),
                  _SpeedPresetChip(
                    label: context.l10n.veryFast,
                    multiplier: 0.25,
                    current: s.delayMultiplier,
                    onSelected: () => ref
                        .read(appSettingsControllerProvider.notifier)
                        .setDelayMultiplier(0.25),
                  ),
                  _SpeedPresetChip(
                    label: context.l10n.fast,
                    multiplier: 0.5,
                    current: s.delayMultiplier,
                    onSelected: () => ref
                        .read(appSettingsControllerProvider.notifier)
                        .setDelayMultiplier(0.5),
                  ),
                  _SpeedPresetChip(
                    label: context.l10n.normal,
                    multiplier: 1.0,
                    current: s.delayMultiplier,
                    onSelected: () => ref
                        .read(appSettingsControllerProvider.notifier)
                        .setDelayMultiplier(1.0),
                  ),
                  _SpeedPresetChip(
                    label: context.l10n.slow,
                    multiplier: 2.0,
                    current: s.delayMultiplier,
                    onSelected: () => ref
                        .read(appSettingsControllerProvider.notifier)
                        .setDelayMultiplier(2.0),
                  ),
                  _SpeedPresetChip(
                    label: context.l10n.verySlow,
                    multiplier: 4.0,
                    current: s.delayMultiplier,
                    onSelected: () => ref
                        .read(appSettingsControllerProvider.notifier)
                        .setDelayMultiplier(4.0),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  leading: Icon(Icons.tune, color: cs.primary),
                  title: Text(
                    context.l10n.advancedExecution,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    context.l10n.loggingHIDReliabilityUnicodeFallback,
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                  ),
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: s.enableLogging,
                      onChanged: (v) => ref
                          .read(appSettingsControllerProvider.notifier)
                          .setEnableLogging(v),
                      title: Text(context.l10n.enableLogging),
                      subtitle: Text(context.l10n.recordExecutionEventsAndOutcomes),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: s.randomizeTiming,
                      onChanged: (v) => ref
                          .read(appSettingsControllerProvider.notifier)
                          .setRandomizeTiming(v),
                      title: Text(context.l10n.randomizeTiming),
                      subtitle: Text(context.l10n.addsSmallJitterToMimicRealTyping),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.l10n.hidGraceWindow,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          context.l10n.hidGraceWindowMS(s.hidGraceWindowMs),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Slider(
                      value: s.hidGraceWindowMs.toDouble().clamp(0, 5000),
                      min: 0,
                      max: 5000,
                      divisions: 50,
                      label: context.l10n.hidGraceWindowMS(s.hidGraceWindowMs),
                      onChanged: (v) => ref
                          .read(appSettingsControllerProvider.notifier)
                          .setHidGraceWindowMs(v.round()),
                    ),
                    Text(
                      context.l10n.waitBrieflyForHIDToBecomeActiveBeforeFailingAWrite,
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.l10n.unicodeFallback,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: cs.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: s.unicodeFallbackMode,
                              style: TextStyle(color: cs.onSurface),
                              items: [
                                DropdownMenuItem(value: 'warn', child: Text(context.l10n.warnAndSkip)),
                                DropdownMenuItem(value: 'skip', child: Text(context.l10n.skip)),
                                DropdownMenuItem(value: 'ascii', child: Text(context.l10n.asciiTransliterate)),
                              ],
                              onChanged: (v) {
                                if (v == null) return;
                                ref
                                    .read(appSettingsControllerProvider.notifier)
                                    .setUnicodeFallbackMode(v);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.l10n.controlsHowUnsupportedCharactersAreHandledDuringTyping,
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                    Tooltip(
                      message: context.l10n.riskyFastModeCanCauseMissedOrStuckKeysOnSomeHosts,
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: s.riskyFastMode,
                        onChanged: (v) => ref
                            .read(appSettingsControllerProvider.notifier)
                            .setRiskyFastMode(v),
                        title: Text(context.l10n.riskyFastMode),
                        subtitle:
                            Text(context.l10n.allowsShorterKeyHoldAndInterKeyDelaysMayBeUnreliable),
                      ),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: s.keepScreenOn,
                      onChanged: (v) => ref
                          .read(appSettingsControllerProvider.notifier)
                          .setKeepScreenOn(v),
                      title: Text(context.l10n.keepScreenOn),
                      subtitle: Text(context.l10n.preventsScreenFromSleepingDuringExecution),
                    ),
                    if (s.keepScreenOn)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8),
                        child: Row(
                          children: [
                            Icon(Icons.battery_alert, size: 16, color: cs.tertiary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                context.l10n.mayIncreaseBatteryUsageScreenWillStayOnEvenWhenAppIsInBackground,
                                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStealthSection(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.stealthMode,
        subtitle: context.l10n.covertOperationCapabilities,
        leading: Icon(Icons.visibility_off, color: cs.primary),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility_off, color: cs.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.l10n.hiddenExecution,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                context.l10n.hiddenExecutionDescription,
                style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: cs.primary.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, size: 16, color: cs.primary),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.useCases,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: cs.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.useCasesDescription,
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreLinkSection(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.payloadsStore,
        subtitle: context.l10n.browseGitHubRepositoriesAndImportPayloads,
        leading: Icon(Icons.storefront, color: cs.primary),
        child: ListTile(
          leading: const Icon(Icons.storefront),
          title: Text(context.l10n.openPayloadsStore),
          subtitle: Text(context.l10n.manageAndImportFromMultipleRepos),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(const PayloadsStoreRoute().location),
        ),
      ),
    );
  }

  Widget _buildAdvancedLinkSection(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.advanced,
        subtitle: context.l10n.usbGadgetPresetsAndHotkeys,
        leading: Icon(Icons.tune, color: cs.primary),
        child: ListTile(
          leading: const Icon(Icons.tune),
          title: Text(context.l10n.advancedSettings),
          subtitle: Text(context.l10n.commandPresetsHotkeysDefaultVidPid),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(const AdvancedSettingsRoute().location),
        ),
      ),
    );
  }

  Widget _buildHidControlSection(
      BuildContext context, WidgetRef ref, dynamic hid) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.hidControl,
        subtitle: context.l10n.usbGadgetSessionStatus,
        leading: Icon(Icons.usb, color: cs.primary),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.security),
              title: Text(context.l10n.rootAvailable),
              subtitle: Text(hid.rootAvailable ? context.l10n.available : context.l10n.unavailable),
              trailing: Icon(
                hid.rootAvailable ? Icons.check_circle : Icons.error_outline,
                color: hid.rootAvailable ? cs.primary : cs.error,
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.usb),
              title: Text(context.l10n.hidSupported),
              subtitle: Text(hid.hidSupported ? context.l10n.supported : context.l10n.unsupported),
              trailing: Icon(
                hid.hidSupported ? Icons.check_circle : Icons.error_outline,
                color: hid.hidSupported ? cs.primary : cs.error,
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading:
                  Icon(hid.sessionArmed ? Icons.lock_open : Icons.lock_outline),
              title: Text(context.l10n.hidSession),
              subtitle: Text(hid.sessionArmed ? context.l10n.armed : context.l10n.disarmed),
              trailing: Switch(
                value: hid.sessionArmed,
                onChanged: (hid.rootAvailable && hid.hidSupported)
                    ? (v) => ref
                        .read(hidStatusControllerProvider.notifier)
                        .toggleSessionArmed()
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                context.l10n.hidSessionDescription,
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SectionCard(
        title: context.l10n.about,
        subtitle: context.l10n.appInformationAndLegal,
        leading: Icon(Icons.info_outline, color: cs.primary),
        child: Column(
          children: [
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                final info = snapshot.data;
                final version =
                    info == null ? '—' : '${info.version}+${info.buildNumber}';
                return ListTile(
                  leading: const Icon(Icons.apps),
                  title: const Text('TapDucky - KaijinLab Inc.'),
                  subtitle: Text(context.l10n.version(version)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutScreen(repoUrl: _repoUrl, issuesUrl: _issuesUrl, liberapayUrl: _liberapayUrl),
                      ),
                    );
                  },
                );
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.gavel),
              title: Text(context.l10n.licences),
              subtitle: Text(context.l10n.openSourceLicenses),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showLicensePage(
                  context: context,
                  applicationName: 'TapDucky',
                  applicationVersion: 'by KaijinLab Inc.',
                  applicationIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.security,
                      size: 48,
                      color: cs.primary,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeTheme(WidgetRef ref, ThemeMode mode) async {
    await ref.read(appSettingsControllerProvider.notifier).setThemeMode(mode);
    HapticFeedback.selectionClick();
  }

  String _getThemeName(ThemeMode mode, l10n) {
    switch (mode) {
      case ThemeMode.system:
        return l10n.autoTheme;
      case ThemeMode.light:
        return l10n.lightTheme;
      case ThemeMode.dark:
        return l10n.darkTheme;
    }
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.auto_awesome_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
    }
  }

  String _getThemeDescription(ThemeMode mode, l10n) {
    switch (mode) {
      case ThemeMode.system:
        return l10n.followsYourDeviceSettings;
      case ThemeMode.light:
        return l10n.alwaysBrightAndClear;
      case ThemeMode.dark:
        return l10n.easyOnTheEyes;
    }
  }

  String _getThemeHint(ThemeMode mode, l10n) {
    switch (mode) {
      case ThemeMode.system:
        return l10n.themeModeSystem;
      case ThemeMode.light:
        return l10n.themeModeLight;
      case ThemeMode.dark:
        return l10n.themeModeDark;
    }
  }

  void _openDonationSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return FractionallySizedBox(
          heightFactor: 0.92,
          child: DonationSheet(
            repoUrl: 'https://github.com/iodn/tap-ducky',
            btcAddress: 'bc1qtf79uecssueu4u4u86zct46vcs0vcd2cnmvw6f',
            ethAddress: '0xCaCc52Cd2D534D869a5C61dD3cAac57455f3c2fD',
            liberapayUrl: 'https://liberapay.com/KaijinLab/donate',
            onCopy: (text, message) =>
                _copyToClipboard(ctx, text: text, message: message),
          ),
        );
      },
    );
  }

  Future<void> _copyToClipboard(
    BuildContext context, {
    required String text,
    required String message,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    HapticFeedback.selectionClick();
  }
}

class _SpeedPresetChip extends StatelessWidget {
  const _SpeedPresetChip({
    required this.label,
    required this.multiplier,
    required this.current,
    required this.onSelected,
    this.tooltip,
  });

  final String label;
  final double multiplier;
  final double current;
  final VoidCallback onSelected;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final selected = (current - multiplier).abs() < 0.01;

    final chip = ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      labelStyle: TextStyle(
        fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
        color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
        fontSize: 12,
      ),
      selectedColor: cs.primaryContainer,
      backgroundColor: cs.surfaceContainerHighest,
      side: BorderSide(
        color: selected ? cs.primary : cs.outlineVariant,
        width: selected ? 1.5 : 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return tooltip == null ? chip : Tooltip(message: tooltip!, child: chip);
  }
}

class _ThemeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ThemeData theme;

  const _ThemeCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? cs.primaryContainer.withOpacity(0.7)
              : cs.surfaceContainerHighest.withOpacity(0.4),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? cs.primary.withOpacity(0.5)
                : cs.outlineVariant.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? cs.primary : cs.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color:
                    isSelected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Icon(
                Icons.check_circle,
                size: 16,
                color: cs.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}