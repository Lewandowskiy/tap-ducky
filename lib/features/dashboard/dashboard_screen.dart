import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import '../../data/models/payload.dart';
import '../../state/controllers/app_settings_controller.dart';
import '../../state/controllers/execution_controller.dart';
import '../../state/controllers/hid_status_controller.dart';
import '../../state/controllers/payloads_controller.dart';
import '../../state/controllers/scheduler_controller.dart';
import '../../widgets/section_header.dart';
import '../settings/profile_selector_dialog.dart';
import '../../widgets/root_required_card.dart';

import '../../extension/context_extensions.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  Future<void> _armIfNeeded(WidgetRef ref) async {
    final hid = ref.read(hidStatusControllerProvider);
    if (hid.sessionArmed) return;

    final s = ref.read(appSettingsControllerProvider).value;
    final lastType = (s?.lastProfileType ?? 'composite').toLowerCase();

    final controller = ref.read(hidStatusControllerProvider.notifier);
    switch (lastType) {
      case 'keyboard':
        await controller.activateKeyboard();
        break;
      case 'mouse':
        await controller.activateMouse();
        break;
      case 'composite':
      default:
        await controller.activateComposite();
        break;
    }
  }

  Future<void> _runRecentPayload(WidgetRef ref, Payload payload) async {
    final exec = ref.read(executionControllerProvider);
    if (exec.isRunning) return;

    await _armIfNeeded(ref);

    final hidNow = ref.read(hidStatusControllerProvider);
    if (!hidNow.sessionArmed) return;

    await ref.read(executionControllerProvider.notifier).runPayload(
          payload,
          const <String, String>{},
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hid = ref.watch(hidStatusControllerProvider);
    final settings = ref.watch(appSettingsControllerProvider).value;
    final payloadsAsync = ref.watch(payloadsControllerProvider);
    final schedulesAsync = ref.watch(schedulerControllerProvider);
    final exec = ref.watch(executionControllerProvider);

    if (hid.isInitializing) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('TapDucky'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.checkingSystemStatus,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.verifyingRootAccessAndUSBGadgetSupport,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
      );
    }

    if (!hid.rootAvailable) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('TapDucky'),
          actions: [
            IconButton(
              tooltip: context.l10n.deviceInfo,
              onPressed: () => context.push(const DeviceRoute().location),
              icon: const Icon(Icons.phone_android),
            ),
          ],
        ),
        body: const SingleChildScrollView(
          child: RootRequiredCard(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('TapDucky'),
        actions: [
          if (exec.isRunning)
            IconButton(
              tooltip: context.l10n.panicStop,
              onPressed: () => ref.read(executionControllerProvider.notifier).panicStop(),
              icon: const Icon(Icons.warning_amber_rounded),
              color: Theme.of(context).colorScheme.error,
            ),
          IconButton(
            tooltip: context.l10n.logs,
            onPressed: () => context.push(const LogsRoute().location),
            icon: const Icon(Icons.list_alt),
          ),
          IconButton(
            tooltip: context.l10n.device,
            onPressed: () => context.push(const DeviceRoute().location),
            icon: const Icon(Icons.phone_android),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(payloadsControllerProvider);
          ref.invalidate(schedulerControllerProvider);
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _HeroStatusCard(
                hid: hid,
                exec: exec,
                onArmToggle: () async {
                  if (hid.sessionArmed) {
                    await ref.read(hidStatusControllerProvider.notifier).deactivate();
                    return;
                  }

                  final s = ref.read(appSettingsControllerProvider).value;
                  final lastType = s?.lastProfileType ?? 'composite';

                  GadgetProfileType initialSelection;
                  switch (lastType.toLowerCase()) {
                    case 'keyboard':
                      initialSelection = GadgetProfileType.keyboard;
                      break;
                    case 'mouse':
                      initialSelection = GadgetProfileType.mouse;
                      break;
                    default:
                      initialSelection = GadgetProfileType.composite;
                  }

                  final selected = await showProfileSelectorDialog(
                    context,
                    initialSelection: initialSelection,
                  );

                  if (selected == null) return;

                  await ref.read(appSettingsControllerProvider.notifier).setLastProfileType(selected.name);

                  final controller = ref.read(hidStatusControllerProvider.notifier);
                  switch (selected) {
                    case GadgetProfileType.keyboard:
                      await controller.activateKeyboard();
                      break;
                    case GadgetProfileType.mouse:
                      await controller.activateMouse();
                      break;
                    case GadgetProfileType.composite:
                      await controller.activateComposite();
                      break;
                  }
                },
                onStop: exec.isRunning ? () => ref.read(executionControllerProvider.notifier).stop() : null,
                onPanicStop:
                    (exec.isRunning && exec.panicAvailable)
                        ? () => ref.read(executionControllerProvider.notifier).panicStop()
                        : null,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _StatusChipsRow(
                hid: hid,
                loggingEnabled: settings?.enableLogging ?? true,
                scheduleCount: schedulesAsync.value?.length ?? 0,
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(
              title: context.l10n.recentPayloads,
              trailing: TextButton.icon(
                onPressed: () => context.go('${const PayloadsRoute().location}/new'),
                icon: const Icon(Icons.add),
                label: Text(context.l10n.createNew),
              ),
            ),
            payloadsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, st) => Padding(
                padding: const EdgeInsets.all(20),
                child: Text(context.l10n.failedToLoadPayloads(e.toString())),
              ),
              data: (payloads) {
                final top = payloads.take(5).toList();
                if (top.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _EmptyPayloadsCard(
                      onCreateTap: () => context.go('${const PayloadsRoute().location}/new'),
                      onOpenStoreTap: () => context.go(const PayloadsStoreRoute().location),
                    ),
                  );
                }

                return Column(
                  children: [
                    for (final p in top)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: _PayloadCard(
                          payload: p,
                          onTap: () => context.go('${const PayloadsRoute().location}/${p.id}/edit'),
                          onRun: exec.isRunning
                              ? null
                              : () {
                                  unawaited(_runRecentPayload(ref, p));
                                },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: TextButton(
                        onPressed: () => context.go(const PayloadsRoute().location),
                        child: Text(context.l10n.viewAllPayloads),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            SectionHeader(
              title: context.l10n.quickAccess,
              trailing: IconButton(
                onPressed: () => _showQuickActionsSheet(context, ref, exec),
                icon: const Icon(Icons.more_horiz),
                tooltip: context.l10n.moreActions,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _QuickAccessGrid(
                onScheduleTap: () => context.go(const ScheduleRoute().location),
                onSettingsTap: () => context.go(const SettingsRoute().location),
                onLogsTap: () => context.push(const LogsRoute().location),
                onDeviceTap: () => context.push(const DeviceRoute().location),
              ),
            ),
            if (settings?.showPowerUserHints ?? true) ...[
              const SizedBox(height: 20),
              SectionHeader(title: context.l10n.systemStatus),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: _SystemStatusCard(isDebug: !kReleaseMode, hid: hid),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(const ExecuteRoute().location),
        icon: const Icon(Icons.play_arrow),
        label: Text(context.l10n.execute),
      ),
    );
  }

  void _showQuickActionsSheet(BuildContext context, WidgetRef ref, ExecutionState exec) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: Text(context.l10n.payloadManager),
              subtitle: Text(context.l10n.createEditImportExport),
              onTap: () {
                Navigator.pop(context);
                context.go(const PayloadsRoute().location);
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: Text(context.l10n.scheduler),
              subtitle: Text(context.l10n.timeWindowsAndTriggers),
              onTap: () {
                Navigator.pop(context);
                context.go(const ScheduleRoute().location);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(context.l10n.settings),
              subtitle: Text(context.l10n.themeLoggingHIDConfig),
              onTap: () {
                Navigator.pop(context);
                context.go(const SettingsRoute().location);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: Text(context.l10n.logs),
              subtitle: Text(context.l10n.executionHistory),
              onTap: () {
                Navigator.pop(context);
                context.push(const LogsRoute().location);
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: Text(context.l10n.deviceInfo),
              subtitle: Text(context.l10n.diagnosticsAndCompatibility),
              onTap: () {
                Navigator.pop(context);
                context.push(const DeviceRoute().location);
              },
            ),
            if (exec.isRunning)
              ListTile(
                leading: Icon(Icons.warning_amber_rounded, color: Theme.of(context).colorScheme.error),
                title: Text(context.l10n.panicStop),
                subtitle: Text(context.l10n.emergencyStopAndGadgetTeardown),
                onTap: () async {
                  Navigator.pop(context);
                  await ref.read(executionControllerProvider.notifier).panicStop();
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _HeroStatusCard extends ConsumerWidget {
  const _HeroStatusCard({
    required this.hid,
    required this.exec,
    required this.onArmToggle,
    required this.onStop,
    required this.onPanicStop,
  });

  final HidStatus hid;
  final ExecutionState exec;
  final VoidCallback onArmToggle;
  final VoidCallback? onStop;
  final VoidCallback? onPanicStop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    String statusText;
    IconData statusIcon;
    Color statusColor;

    if (!hid.rootAvailable || !hid.hidSupported) {
      statusText = context.l10n.systemNotReady;
      statusIcon = Icons.error_outline;
      statusColor = cs.error;
    } else if (!hid.sessionArmed) {
      statusText = context.l10n.sessionDisarmed;
      statusIcon = Icons.lock_outline;
      statusColor = cs.tertiary;
    } else if (!hid.deviceConnected) {
      statusText = context.l10n.waitingForHost;
      statusIcon = Icons.usb_off;
      statusColor = cs.warning;
    } else if (exec.isRunning) {
      statusText = context.l10n.executing;
      statusIcon = Icons.play_arrow;
      statusColor = cs.primary;
    } else {
      statusText = context.l10n.ready;
      statusIcon = Icons.check_circle;
      statusColor = cs.success;
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, size: 32, color: statusColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusText,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getStatusSubtitle(context),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (exec.isRunning) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        exec.payloadName ?? context.l10n.running,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${(exec.progress * 100).clamp(0, 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: exec.progress),
                  const SizedBox(height: 4),
                  Text(
                    exec.status,
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: (hid.rootAvailable && hid.hidSupported) ? onArmToggle : null,
                    icon: Icon(hid.sessionArmed ? Icons.lock_open : Icons.lock_outline),
                    label: Text(hid.sessionArmed ? context.l10n.disarm : context.l10n.armSession),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                if (exec.isRunning) ...[
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: onStop,
                    icon: const Icon(Icons.stop),
                    label: Text(context.l10n.stop),
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.error,
                      foregroundColor: cs.onError,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    ),
                  ),
                ],
              ],
            ),
            if (exec.isRunning && exec.panicAvailable) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onPanicStop,
                  icon: const Icon(Icons.warning_amber_rounded),
                  label: Text(context.l10n.panicStop),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: cs.error,
                    side: BorderSide(color: cs.error),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getStatusSubtitle(BuildContext context) {
    if (!hid.rootAvailable) return context.l10n.rootAccessRequired;
    if (!hid.hidSupported) return context.l10n.hidNotSupported;
    if (!hid.sessionArmed) return context.l10n.tapToActivateUSBGadget;
    if (!hid.deviceConnected) return context.l10n.connectUSBCableToTarget;
    if (exec.isRunning) return context.l10n.payloadInProgress;
    return context.l10n.systemOperational;
  }
}

class _StatusChipsRow extends StatelessWidget {
  const _StatusChipsRow({
    required this.hid,
    required this.loggingEnabled,
    required this.scheduleCount,
  });

  final HidStatus hid;
  final bool loggingEnabled;
  final int scheduleCount;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    String profileDisplay = 'None';
    if (hid.activeProfileType != null) {
      switch (hid.activeProfileType!.toLowerCase()) {
        case 'keyboard':
          profileDisplay = context.l10n.keyboard;
          break;
        case 'mouse':
          profileDisplay = context.l10n.mouse;
          break;
        case 'composite':
          profileDisplay = context.l10n.composite;
          break;
        default:
          profileDisplay = hid.activeProfileType!;
      }
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _StatusChip(
          icon: Icons.security,
          label: 'Root',
          value: hid.rootAvailable ? 'OK' : 'N/A',
          ok: hid.rootAvailable,
        ),
        _StatusChip(
          icon: Icons.usb,
          label: 'HID',
          value: hid.hidSupported ? 'OK' : 'N/A',
          ok: hid.hidSupported,
        ),
        _StatusChip(
          icon: Icons.devices,
          label: context.l10n.profile,
          value: profileDisplay,
          ok: hid.sessionArmed,
        ),
        _StatusChip(
          icon: Icons.schedule,
          label: context.l10n.schedules,
          value: '$scheduleCount',
          ok: scheduleCount > 0,
        ),
        _StatusChip(
          icon: Icons.article_outlined,
          label: context.l10n.logging,
          value: loggingEnabled ? context.l10n.on : context.l10n.off,
          ok: loggingEnabled,
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.ok,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = ok ? cs.primary : cs.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ok ? cs.primaryContainer.withOpacity(0.5) : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ok ? cs.primary.withOpacity(0.3) : cs.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayloadCard extends StatelessWidget {
  const _PayloadCard({
    required this.payload,
    required this.onTap,
    required this.onRun,
  });

  final Payload payload;
  final VoidCallback onTap;
  final VoidCallback? onRun;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  payload.isBuiltin ? Icons.lock : Icons.code,
                  color: cs.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payload.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (payload.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        payload.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (payload.tags.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: payload.tags.take(3).map<Widget>((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: cs.secondaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 11,
                                color: cs.onSecondaryContainer,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filledTonal(
                onPressed: onRun,
                icon: const Icon(Icons.play_arrow),
                tooltip: context.l10n.run,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyPayloadsCard extends StatelessWidget {
  const _EmptyPayloadsCard({required this.onCreateTap, required this.onOpenStoreTap});

  final VoidCallback onCreateTap;
  final VoidCallback onOpenStoreTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.inventory_2_outlined, size: 48, color: cs.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              context.l10n.noPayloadsYet,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.createYourFirstPayloadToGetStarted,
              style: TextStyle(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onCreateTap,
              icon: const Icon(Icons.add),
              label: Text(context.l10n.createPayload),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: onOpenStoreTap,
              icon: const Icon(Icons.cloud_download),
              label: Text(context.l10n.importFromGitHubStore),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessGrid extends StatelessWidget {
  const _QuickAccessGrid({
    required this.onScheduleTap,
    required this.onSettingsTap,
    required this.onLogsTap,
    required this.onDeviceTap,
  });

  final VoidCallback onScheduleTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogsTap;
  final VoidCallback onDeviceTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            _QuickAccessTile(
              icon: Icons.schedule,
              label: context.l10n.schedule,
              onTap: onScheduleTap,
            ),
            _QuickAccessTile(
              icon: Icons.settings,
              label: context.l10n.settings,
              onTap: onSettingsTap,
            ),
            _QuickAccessTile(
              icon: Icons.list_alt,
              label: context.l10n.logs,
              onTap: onLogsTap,
            ),
            _QuickAccessTile(
              icon: Icons.phone_android,
              label: context.l10n.device,
              onTap: onDeviceTap,
            ),
          ],
        );
      },
    );
  }
}

class _QuickAccessTile extends StatelessWidget {
  const _QuickAccessTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: cs.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SystemStatusCard extends StatelessWidget {
  const _SystemStatusCard({required this.isDebug, required this.hid});

  final bool isDebug;
  final HidStatus hid;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: cs.primary),
                const SizedBox(width: 8),
                Text(
                  context.l10n.operationalFlow,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _FlowStep(
              number: '1',
              text: context.l10n.armHIDSessionActivatesUSBGadget,
              completed: hid.sessionArmed,
            ),
            const SizedBox(height: 8),
            _FlowStep(
              number: '2',
              text: context.l10n.connectUSBCableToTargetDevice,
              completed: hid.deviceConnected,
            ),
            const SizedBox(height: 8),
            _FlowStep(
              number: '3',
              text: context.l10n.selectPayloadAndConfigureParameters,
              completed: false,
            ),
            const SizedBox(height: 8),
            _FlowStep(
              number: '4',
              text: context.l10n.executeAndReviewLogs,
              completed: false,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    hid.rootAvailable ? Icons.check_circle : Icons.error_outline,
                    size: 18,
                    color: hid.rootAvailable ? cs.primary : cs.error,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      hid.rootAvailable
                          ? context.l10n.rootAvailableUSBGadgetIsActive
                          : context.l10n.rootNotAvailableCheckDeviceScreenForDiagnostics,
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
            if (hid.udcList.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'UDC: ${hid.udcList.join(", ")}',
                style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FlowStep extends StatelessWidget {
  const _FlowStep({
    required this.number,
    required this.text,
    required this.completed,
  });

  final String number;
  final String text;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: completed ? cs.primary : cs.surfaceContainerHighest,
            shape: BoxShape.circle,
            border: Border.all(
              color: completed ? cs.primary : cs.outlineVariant,
              width: 2,
            ),
          ),
          child: Center(
            child: completed
                ? Icon(Icons.check, size: 14, color: cs.onPrimary)
                : Text(
                    number,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: completed ? cs.onSurface : cs.onSurfaceVariant,
              fontWeight: completed ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
