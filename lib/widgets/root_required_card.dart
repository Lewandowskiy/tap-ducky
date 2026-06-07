import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extension/context_extensions.dart';

class RootRequiredCard extends StatelessWidget {
  const RootRequiredCard({super.key});

  void _copyCommand(BuildContext context, String command) {
    Clipboard.setData(ClipboardData(text: command));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.commandCopiedToClipboard),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 0,
      color: cs.errorContainer.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.error.withOpacity(0.3), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.security,
                    color: cs.onError,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.rootAccessRequired,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: cs.onErrorContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.l10n.tapDuckyNeedsElevatedPrivileges,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onErrorContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Explanation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: cs.outline.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 20, color: cs.primary),
                      const SizedBox(width: 8),
                      Text(
                        context.l10n.whyRootAccess,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.whyRootAccessDescription,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _BulletPoint(
                    icon: Icons.keyboard,
                    text: context.l10n.emulateUsbHidKeyboardDevices,
                  ),
                  const SizedBox(height: 8),
                  _BulletPoint(
                    icon: Icons.mouse,
                    text: context.l10n.simulateMouseAndPointerInput,
                  ),
                  const SizedBox(height: 8),
                  _BulletPoint(
                    icon: Icons.usb,
                    text: context.l10n.configureUsbGadgetDrivers,
                  ),
                  const SizedBox(height: 8),
                  _BulletPoint(
                    icon: Icons.code,
                    text: context.l10n.writeHidReportsToDevHidgCharacterDevices,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Requirements
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: cs.primary.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.checklist, size: 20, color: cs.primary),
                      const SizedBox(width: 8),
                      Text(
                        context.l10n.requirements,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _RequirementItem(
                    number: '1',
                    title: context.l10n.rootedAndroidDevice,
                    description: context.l10n.installMagiskKernelSUOrSuperSU,
                    colorScheme: cs,
                  ),
                  const SizedBox(height: 12),
                  _RequirementItem(
                    number: '2',
                    title: context.l10n.usbGadgetSupport,
                    description: context.l10n.kernelMustSupportConfigFSUSBGadgets,
                    colorScheme: cs,
                  ),
                  const SizedBox(height: 12),
                  _RequirementItem(
                    number: '3',
                    title: context.l10n.grantRootPermission,
                    description: context.l10n.allowTapDuckyWhenPromptedByRootManager,
                    colorScheme: cs,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Test Command
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: cs.outline.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.terminal, size: 20, color: cs.primary),
                      const SizedBox(width: 8),
                      Text(
                        context.l10n.testRootAccess,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.openATerminalAppEgTermuxAndRun,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _copyCommand(context, 'su -c "id"'),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: cs.outline.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'su -c "id"',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13,
                                color: cs.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(Icons.copy, size: 18, color: cs.primary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.ifYouSeeUid0RootRootAccessIsWorking,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: cs.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const _RootingGuideDialog(),
                      );
                    },
                    icon: const Icon(Icons.help_outline),
                    label: Text(context.l10n.rootingGuide),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.onErrorContainer,
                      side: BorderSide(color: cs.onErrorContainer.withOpacity(0.5)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      // Trigger root check again
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.restartTheAppToReCheckRootAccess),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(context.l10n.retry),
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.error,
                      foregroundColor: cs.onError,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BulletPoint({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: cs.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.4,
                ),
          ),
        ),
      ],
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final ColorScheme colorScheme;

  const _RequirementItem({
    required this.number,
    required this.title,
    required this.description,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RootingGuideDialog extends StatelessWidget {
  const _RootingGuideDialog();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(context.l10n.howToRootYourDevice),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.popularRootMethods,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            _GuideItem(
              title: context.l10n.magiskRecommended,
              description: context.l10n.universalSystemlessRootSolution,
              url: 'https://github.com/topjohnwu/Magisk',
              colorScheme: cs,
            ),
            const SizedBox(height: 12),
            _GuideItem(
              title: context.l10n.kernelSU,
              description: context.l10n.kernelBasedRootForModernDevices,
              url: 'https://kernelsu.org',
              colorScheme: cs,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.errorContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: cs.error, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.l10n.rootingMayVoidWarranty,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: cs.onErrorContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.close),
        ),
      ],
    );
  }
}

class _GuideItem extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final ColorScheme colorScheme;

  const _GuideItem({
    required this.title,
    required this.description,
    required this.url,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: url));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.urlCopiedToClipboard),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Row(
              children: [
                Icon(Icons.link, size: 14, color: colorScheme.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    url,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Icon(Icons.copy, size: 14, color: colorScheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
