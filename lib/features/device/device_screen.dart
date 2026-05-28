import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../data/models/device_snapshot.dart';
import '../../state/controllers/hid_status_controller.dart';
import '../../state/providers.dart';

import '../../extension/context_extensions.dart';

final deviceSnapshotProvider = FutureProvider<DeviceSnapshot>((ref) async {
  final svc = ref.read(deviceInfoServiceProvider);
  return svc.getSnapshot();
});

final deviceDiagnosticsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final svc = ref.read(platformGadgetServiceProvider);
  return svc.getDiagnostics();
});

class DeviceScreen extends ConsumerWidget {
  const DeviceScreen({super.key});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.labelCopiedToClipboard(label)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hid = ref.watch(hidStatusControllerProvider);
    final snapshotAsync = ref.watch(deviceSnapshotProvider);
    final diagnosticsAsync = ref.watch(deviceDiagnosticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.deviceInformation),
        actions: [
          IconButton(
            tooltip: context.l10n.refreshDiagnostics,
            onPressed: () => ref.invalidate(deviceDiagnosticsProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: snapshotAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => _ErrorView(error: e.toString()),
        data: (snap) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(deviceSnapshotProvider);
              ref.invalidate(deviceDiagnosticsProvider);
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // System Status Hero Card
                _SystemStatusHeroCard(hid: hid, snapshot: snap),
                const SizedBox(height: 16),

                // HID Readiness
                _SectionTitle(
                  icon: Icons.security,
                  title: context.l10n.hidReadiness,
                  subtitle: context.l10n.usbGadgetSystemStatus,
                ),
                const SizedBox(height: 12),
                _HidReadinessCard(hid: hid),
                const SizedBox(height: 24),

                // UDC State (if available)
                if (hid.udcState != null) ...[
                  _SectionTitle(
                    icon: Icons.usb,
                    title: context.l10n.usbDeviceController,
                    subtitle: context.l10n.realTimeConnectionState,
                  ),
                  const SizedBox(height: 12),
                  _UdcStateCard(hid: hid),
                  const SizedBox(height: 24),
                ],

                // Device Information
                _SectionTitle(
                  icon: Icons.phone_android,
                  title: context.l10n.deviceInformation,
                  subtitle: context.l10n.hardwareAndSoftwareDetails,
                ),
                const SizedBox(height: 12),
                _DeviceInfoCard(
                  snapshot: snap,
                  onCopy: (text, label) => _copyToClipboard(context, text, label),
                ),
                const SizedBox(height: 24),

                // Backend Diagnostics
                _SectionTitle(
                  icon: Icons.bug_report,
                  title: context.l10n.backendDiagnostics,
                  subtitle: context.l10n.kernelAndSysytemConfiguration,
                ),
                const SizedBox(height: 12),
                diagnosticsAsync.when(
                  loading: () => const Card(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (e, st) => _ErrorCard(error: e.toString()),
                  data: (diag) => _DiagnosticsCard(diagnostics: diag),
                ),
                const SizedBox(height: 24),

                // Compatibility Notes
                _SectionTitle(
                  icon: Icons.info_outline,
                  title: context.l10n.compatibilityNotes,
                  subtitle: context.l10n.requirementsAndRecommendations,
                ),
                const SizedBox(height: 12),
                _CompatibilityCard(isPhysical: snap.isPhysicalDevice),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SystemStatusHeroCard extends StatelessWidget {
  final HidStatus hid;
  final DeviceSnapshot snapshot;

  const _SystemStatusHeroCard({
    required this.hid,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isReady = hid.rootAvailable && hid.hidSupported;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isReady
                        ? cs.success.withOpacity(0.1)
                        : cs.error.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isReady ? Icons.check_circle : Icons.error_outline,
                    size: 40,
                    color: isReady ? cs.success : cs.error,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isReady ? context.l10n.systemReady : context.l10n.systemNotReady,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isReady
                            ? context.l10n.allRequirementsMetForHIDOperations
                            : context.l10n.missingRequiredComponents,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _QuickStat(
                    icon: Icons.phone_android,
                    label: context.l10n.device,
                    value: snapshot.model,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickStat(
                    icon: Icons.android,
                    label: 'Android',
                    value: 'API ${snapshot.sdkInt}',
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

class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _QuickStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: cs.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HidReadinessCard extends StatelessWidget {
  final HidStatus hid;

  const _HidReadinessCard({required this.hid});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Column(
        children: [
          _StatusRow(
            icon: Icons.security,
            label: context.l10n.rootAccess,
            status: hid.rootAvailable ? context.l10n.available : context.l10n.unavailable,
            isOk: hid.rootAvailable,
            description: hid.rootAvailable
                ? context.l10n.superUserPermissionsGranted
                : context.l10n.rootAccessRequiredForUSBGadgetControl,
          ),
          const Divider(height: 1),
          _StatusRow(
            icon: Icons.usb,
            label: context.l10n.usbGadgetSupport,
            status: hid.hidSupported ? context.l10n.supported : context.l10n.unsupported,
            isOk: hid.hidSupported,
            description: hid.hidSupported
                ? context.l10n.kernelSupportsConfigFSUSBGadgets
                : context.l10n.kernelMissingUSBGadgetConfigFSSupport,
          ),
          const Divider(height: 1),
          _StatusRow(
            icon: hid.sessionArmed ? Icons.lock_open : Icons.lock_outline,
            label: context.l10n.sessionState,
            status: hid.sessionArmed ? context.l10n.armed : context.l10n.disarmed,
            isOk: hid.sessionArmed,
            description: hid.sessionArmed
                ? context.l10n.usbGadgetIsActiveAndReady
                : context.l10n.activateSessionToEnableHIDOperations,
          ),
          const Divider(height: 1),
          _StatusRow(
            icon: hid.deviceConnected ? Icons.usb : Icons.usb_off,
            label: context.l10n.targetConnection,
            status: hid.deviceConnected ? context.l10n.connected : context.l10n.disconnected,
            isOk: hid.deviceConnected,
            description: hid.deviceConnected
                ? context.l10n.usbCableConnectedToTargetHost
                : context.l10n.connectUSBCableToTargetDevice,
          ),
          if (hid.udcList.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.developer_board, size: 18, color: cs.primary),
                      const SizedBox(width: 8),
                      Text(
                        context.l10n.availableUDCControllers,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...hid.udcList.map((udc) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: cs.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                udc,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;
  final bool isOk;
  final String description;

  const _StatusRow({
    required this.icon,
    required this.label,
    required this.status,
    required this.isOk,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final statusColor = isOk ? cs.success : cs.error;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: statusColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: statusColor.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UdcStateCard extends StatelessWidget {
  final HidStatus hid;

  const _UdcStateCard({required this.hid});

  IconData _getStateIcon(String state) {
    switch (state.toLowerCase()) {
      case 'configured':
        return Icons.check_circle;
      case 'not attached':
        return Icons.usb_off;
      case 'attached':
      case 'powered':
      case 'default':
      case 'addressed':
        return Icons.sync;
      default:
        return Icons.help_outline;
    }
  }

  Color _getStateColor(BuildContext context, String state) {
    final cs = Theme.of(context).colorScheme;
    switch (state.toLowerCase()) {
      case 'configured':
        return cs.success;
      case 'not attached':
        return cs.error;
      case 'attached':
      case 'powered':
      case 'default':
      case 'addressed':
        return cs.warning;
      default:
        return cs.onSurfaceVariant;
    }
  }

  String _getStateDescription(String state, l10n) {
    switch (state.toLowerCase()) {
      case 'configured':
        return l10n.hostHasEnumeratedTheDeviceReadyForHIDCommunication;
      case 'not attached':
        return l10n.noUSBCableConnectedOrHostIsPoweredOff;
      case 'attached':
        return l10n.usbCableConnectedWaitingForPowerNegotiation;
      case 'powered':
        return l10n.deviceIsPoweredWaitingForEnumeration;
      case 'default':
        return l10n.enumerationStartedDeviceIsBeingConfigured;
      case 'addressed':
        return l10n.deviceHasBeenAddressedByHostConfigurationInProgress;
      default:
        return l10n.unknownUDCState(state);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final state = hid.udcState!;
    final stateColor = _getStateColor(context, state);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: stateColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: stateColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStateIcon(state),
                    size: 32,
                    color: stateColor,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: stateColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _getStateDescription(state, context.l10n),
                          style: TextStyle(
                            fontSize: 13,
                            color: cs.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: cs.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      context.l10n.udcStateIsPolledEvery2SecondsWhenSessionIsActive,
                      style: TextStyle(
                        fontSize: 11,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceInfoCard extends StatelessWidget {
  final DeviceSnapshot snapshot;
  final Function(String, String) onCopy;

  const _DeviceInfoCard({
    required this.snapshot,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final info = snapshot.asMap();
    final entries = info.entries.toList();

    return Card(
      child: Column(
        children: [
          for (int i = 0; i < entries.length; i++) ...[
            _InfoRow(
              label: entries[i].key,
              value: entries[i].value ?? 'N/A',
              onCopy: () => onCopy(entries[i].value ?? '', entries[i].key),
            ),
            if (i != entries.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onCopy;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onCopy,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.onSurfaceVariant,
                        fontFamily: value.length > 20 ? 'monospace' : null,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.copy, size: 14, color: cs.onSurfaceVariant),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiagnosticsCard extends StatefulWidget {
  final Map<String, dynamic> diagnostics;

  const _DiagnosticsCard({required this.diagnostics});

  @override
  State<_DiagnosticsCard> createState() => _DiagnosticsCardState();
}

class _DiagnosticsCardState extends State<_DiagnosticsCard> {
  bool _kernelExpanded = false;
  bool _pathsExpanded = false;
  bool _rawExpanded = false;

  Map<String, dynamic>? _castMap(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), v));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final kernelConfig = _castMap(widget.diagnostics['kernelConfig']);
    final paths = _castMap(widget.diagnostics['paths']);
    final rootId = widget.diagnostics['rootId']?.toString();
    final udcList =
        (widget.diagnostics['udcList'] as List<dynamic>?)?.cast<String>() ?? [];
    final configfsBases =
        (widget.diagnostics['configfsBases'] as List<dynamic>?)?.cast<String>() ??
            [];
    final existingGadgets =
        (widget.diagnostics['existingGadgetsInConfig'] as List<dynamic>?)
                ?.cast<String>() ??
            [];
    final rawLines =
        (widget.diagnostics['kernelConfigRawFirstLines'] as List<dynamic>?)
                ?.cast<String>() ??
            [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (rootId != null) ...[
              _DiagnosticItem(
                icon: Icons.admin_panel_settings,
                label: context.l10n.rootShellID,
                value: rootId,
                isMonospace: true,
              ),
              const SizedBox(height: 16),
            ],
            if (udcList.isNotEmpty) ...[
              _DiagnosticList(
                icon: Icons.developer_board,
                label: context.l10n.udcControllers,
                items: udcList,
              ),
              const SizedBox(height: 16),
            ],
            if (configfsBases.isNotEmpty) ...[
              _DiagnosticList(
                icon: Icons.folder_open,
                label: context.l10n.configfsMountPoints,
                items: configfsBases,
              ),
              const SizedBox(height: 16),
            ],
            if (existingGadgets.isNotEmpty) ...[
              _DiagnosticList(
                icon: Icons.usb,
                label: context.l10n.activeGadgetDirectories,
                items: existingGadgets,
              ),
              const SizedBox(height: 16),
            ],
            if (kernelConfig != null && kernelConfig.isNotEmpty) ...[
              _ExpandableSection(
                title: context.l10n.kernelConfigFlags(kernelConfig.length),
                icon: Icons.settings_system_daydream,
                isExpanded: _kernelExpanded,
                onToggle: () => setState(() => _kernelExpanded = !_kernelExpanded),
                child: Column(
                  children: kernelConfig.entries.map((entry) {
                    return _KernelConfigRow(
                      configKey: entry.key,
                      value: entry.value.toString(),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (paths != null && paths.isNotEmpty) ...[
              _ExpandableSection(
                title: context.l10n.systemPaths,
                icon: Icons.folder_special,
                isExpanded: _pathsExpanded,
                onToggle: () => setState(() => _pathsExpanded = !_pathsExpanded),
                child: Column(
                  children: paths.entries.map((entry) {
                    return _PathRow(
                      label: entry.key,
                      path: entry.value.toString(),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (rawLines.isNotEmpty) ...[
              _ExpandableSection(
                title: context.l10n.rawKernelConfig(rawLines.length),
                icon: Icons.code,
                isExpanded: _rawExpanded,
                onToggle: () => setState(() => _rawExpanded = !_rawExpanded),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rawLines.map((line) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          line,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DiagnosticItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isMonospace;

  const _DiagnosticItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isMonospace = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: cs.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontFamily: isMonospace ? 'monospace' : null,
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DiagnosticList extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> items;

  const _DiagnosticList({
    required this.icon,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: cs.primary),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class _ExpandableSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;

  const _ExpandableSection({
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(icon, size: 18, color: cs.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: cs.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 12),
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ],
      ],
    );
  }
}

class _KernelConfigRow extends StatelessWidget {
  final String configKey;
  final String value;

  const _KernelConfigRow({
    required this.configKey,
    required this.value,
  });

  Color _getValueColor(BuildContext context, String value) {
    final cs = Theme.of(context).colorScheme;
    final lower = value.toLowerCase();
    if (lower == 'yes' || lower == 'y' || lower == 'module' || lower == 'm') {
      return cs.success;
    }
    if (lower == 'not set' || lower == 'no' || lower == 'n') {
      return cs.error;
    }
    return cs.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final valueColor = _getValueColor(context, value);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                configKey,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: valueColor,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PathRow extends StatelessWidget {
  final String label;
  final String path;

  const _PathRow({
    required this.label,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.folder, size: 14, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    path,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompatibilityCard extends StatelessWidget {
  final bool isPhysical;

  const _CompatibilityCard({required this.isPhysical});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      color: isPhysical
          ? cs.primaryContainer.withOpacity(0.3)
          : cs.errorContainer.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isPhysical ? Icons.check_circle : Icons.warning_amber_rounded,
                  color: isPhysical ? cs.primary : cs.error,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isPhysical ? context.l10n.physicalDeviceDetected : context.l10n.emulatorDetected,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: isPhysical ? cs.onPrimaryContainer : cs.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              isPhysical
                  ? context.l10n.thisIsAPhysicalDevice
                  : context.l10n.thisIsAnEmulator,
              style: TextStyle(
                fontSize: 13,
                color: isPhysical
                    ? cs.onPrimaryContainer.withOpacity(0.9)
                    : cs.onErrorContainer.withOpacity(0.9),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.checklist, size: 16, color: cs.primary),
                      const SizedBox(width: 8),
                      Text(
                        context.l10n.requirementsForRealHID,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _RequirementBullet(
                    icon: Icons.security,
                    text: context.l10n.rootAccessMagiskKernelSUOrSuperSU,
                  ),
                  const SizedBox(height: 6),
                  _RequirementBullet(
                    icon: Icons.usb,
                    text: context.l10n.usbGadgetConfigFSKernelSupport,
                  ),
                  const SizedBox(height: 6),
                  _RequirementBullet(
                    icon: Icons.cable,
                    text: context.l10n.usbOTGCableOrUSBCDataCable,
                  ),
                  const SizedBox(height: 6),
                  _RequirementBullet(
                    icon: Icons.computer,
                    text: context.l10n.targetHostWithUSBHIDSupport,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequirementBullet extends StatelessWidget {
  final IconData icon;
  final String text;

  const _RequirementBullet({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: cs.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: cs.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: cs.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;

  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 64, color: cs.error),
            const SizedBox(height: 16),
            Text(
              context.l10n.failedToLoadDeviceInfo,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String error;

  const _ErrorCard({required this.error});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      color: cs.errorContainer.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: cs.error),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.failedToLoadDiagnostics,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cs.onErrorContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    error,
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onErrorContainer.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
