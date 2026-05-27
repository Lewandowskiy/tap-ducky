import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/router.dart';
import '../../data/models/execution_group.dart';
import '../../data/models/payload.dart';
import '../../data/services/ducky_script_validator.dart';
import '../../state/controllers/advanced_settings_controller.dart';
import '../../state/controllers/app_settings_controller.dart';
import '../../state/controllers/execution_controller.dart';
import '../../state/controllers/hid_status_controller.dart';
import '../../state/controllers/logs_controller.dart';
import '../../state/controllers/payloads_controller.dart';
import '../../state/controllers/selection_controller.dart';
import '../../state/providers.dart';
import '../../widgets/empty_state.dart';

import '../../extension/context_extensions.dart';

class ExecuteScreen extends ConsumerStatefulWidget {
  const ExecuteScreen({super.key});

  @override
  ConsumerState<ExecuteScreen> createState() => _ExecuteScreenState();
}

class _ExecuteScreenState extends ConsumerState<ExecuteScreen> with SingleTickerProviderStateMixin {
  final _rawCtrl = TextEditingController();
  final Map<String, TextEditingController> _paramCtrls = {};
  late TabController _tabController;
  final _validator = DuckyScriptValidator();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _rawCtrl.dispose();
    _tabController.dispose();
    for (final c in _paramCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final payloadsAsync = ref.watch(payloadsControllerProvider);
    final selectedId = ref.watch(selectedPayloadIdProvider);
    final hid = ref.watch(hidStatusControllerProvider);
    final exec = ref.watch(executionControllerProvider);
    final logsAsync = ref.watch(logsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.execute),
        actions: [
          if (exec.isRunning)
            IconButton(
              tooltip: context.l10n.panicStop,
              onPressed: () => ref.read(executionControllerProvider.notifier).panicStop(),
              icon: const Icon(Icons.warning_amber_rounded),
              color: Theme.of(context).colorScheme.error,
            ),
          logsAsync.when(
            data: (logs) {
              final groups = ExecutionGroup.fromLogs(logs);
              final recent24h = ExecutionGroup.countRecent(groups, const Duration(hours: 24));
              return Badge(
                label: Text('$recent24h'),
                isLabelVisible: recent24h > 0,
                child: IconButton(
                  tooltip: context.l10n.executionHistory,
                  onPressed: () => context.push(const ExecutionHistoryRoute().location),
                  icon: const Icon(Icons.history),
                ),
              );
            },
            loading: () => IconButton(
              tooltip: context.l10n.executionHistory,
              onPressed: () => context.push(const ExecutionHistoryRoute().location),
              icon: const Icon(Icons.history),
            ),
            error: (_, __) => IconButton(
              tooltip: context.l10n.executionHistory,
              onPressed: () => context.push(const ExecutionHistoryRoute().location),
              icon: const Icon(Icons.history),
            ),
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
      body: payloadsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
                const SizedBox(height: 16),
                Text(context.l10n.failedToLoadPayloads, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('$e', textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        data: (payloads) {
          if (payloads.isEmpty) {
            return EmptyState(
              title: context.l10n.noPayloadsAvailable,
              subtitle: context.l10n.createOrImportAPayloadFirst,
              icon: Icons.inventory_2_outlined,
              action: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => context.go('${const PayloadsRoute().location}/new'),
                      icon: const Icon(Icons.add),
                      label: Text(context.l10n.createPayload),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.go(const PayloadsStoreRoute().location),
                      icon: const Icon(Icons.cloud_download),
                      label: Text(context.l10n.importFromGitHubStore),
                    ),
                  ),
                ],
              ),
            );
          }

          final selected = _resolveSelected(payloads, selectedId);
          if (selected == null) {
            ref.read(selectedPayloadIdProvider.notifier).state = payloads.first.id;
          } else {
            _syncParamControllers(selected);
          }

          final payload = selected ?? payloads.first;

          return Column(
            children: [
              _StatusBanner(hid: hid, exec: exec),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _PayloadSelectionCard(
                      payloads: payloads,
                      selectedPayload: payload,
                      onChanged: (id) => ref.read(selectedPayloadIdProvider.notifier).state = id,
                      onEdit: () => context.go('${const PayloadsRoute().location}/${payload.id}/edit'),
                    ),
                    const SizedBox(height: 16),
                    if (payload.parameters.isNotEmpty) ...[
                      _ParametersCard(payload: payload, controllers: _paramCtrls),
                      const SizedBox(height: 16),
                    ],
                    _PreExecutionChecklist(
                      hid: hid,
                      payload: payload,
                      paramControllers: _paramCtrls,
                    ),
                    const SizedBox(height: 16),
                    _ExecutionSpeedCard(
                      payload: payload,
                      validator: _validator,
                    ),
                    const SizedBox(height: 16),
                    _ExecutionControlCard(
                      exec: exec,
                      hid: hid,
                      onRun: () async {
                        final params = _collectParams(payload);
                        await ref.read(executionControllerProvider.notifier).runPayload(payload, params);
                      },
                      onStop: () => ref.read(executionControllerProvider.notifier).stop(),
                      onPanicStop: () => ref.read(executionControllerProvider.notifier).panicStop(),
                    ),
                    const SizedBox(height: 16),
                    _ConsoleTabs(
                      tabController: _tabController,
                      rawController: _rawCtrl,
                      exec: exec,
                      onSendCommand: (cmd) async {
                        await ref.read(executionControllerProvider.notifier).sendRawCommand(cmd);
                        _rawCtrl.clear();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Payload? _resolveSelected(List<Payload> payloads, String? selectedId) {
    final id = selectedId ?? payloads.first.id;
    for (final p in payloads) {
      if (p.id == id) return p;
    }
    return null;
  }

  void _syncParamControllers(Payload payload) {
    final keys = payload.parameters.map((e) => e.key).toSet();
    final toRemove = _paramCtrls.keys.where((k) => !keys.contains(k)).toList();
    for (final k in toRemove) {
      _paramCtrls.remove(k)?.dispose();
    }
    for (final p in payload.parameters) {
      _paramCtrls.putIfAbsent(p.key, () => TextEditingController(text: p.defaultValue));
    }
  }

  Map<String, String> _collectParams(Payload payload) {
    final out = <String, String>{};
    for (final p in payload.parameters) {
      final v = _paramCtrls[p.key]?.text ?? p.defaultValue;
      out[p.key] = v;
    }
    return out;
  }
}

class _ExecutionSpeedCard extends ConsumerStatefulWidget {
  const _ExecutionSpeedCard({
    required this.payload,
    required this.validator,
  });

  final Payload payload;
  final DuckyScriptValidator validator;

  @override
  ConsumerState<_ExecutionSpeedCard> createState() => _ExecutionSpeedCardState();
}

class _ExecutionSpeedCardState extends ConsumerState<_ExecutionSpeedCard> {
  Timer? _estimateDebounce;
  int? _engineEstimateMs;
  int? _engineBaseEstimateMs;
  String _estimateKey = '';
  int _estimateToken = 0;

  @override
  void dispose() {
    _estimateDebounce?.cancel();
    super.dispose();
  }

  void _refreshEngineEstimate(String script, double multiplier) {
    final key = '${script.hashCode}::$multiplier';
    if (key == _estimateKey) return;
    _estimateKey = key;
    _estimateDebounce?.cancel();
    _estimateDebounce = Timer(const Duration(milliseconds: 400), () async {
      final token = ++_estimateToken;
      final service = ref.read(platformGadgetServiceProvider);
      try {
        final results = await Future.wait<int>([
          service.estimateDuckyScriptDurationMs(script: script, delayMultiplier: 1.0),
          service.estimateDuckyScriptDurationMs(script: script, delayMultiplier: multiplier),
        ]);
        if (!mounted || token != _estimateToken) return;
        setState(() {
          _engineBaseEstimateMs = results[0];
          _engineEstimateMs = results[1];
        });
      } catch (_) {
        if (!mounted || token != _estimateToken) return;
        setState(() {
          _engineBaseEstimateMs = null;
          _engineEstimateMs = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final settingsAsync = ref.watch(appSettingsControllerProvider);

    return settingsAsync.when(
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (settings) {
        final currentMultiplier = settings.delayMultiplier;
        final validationResult = widget.validator.validate(widget.payload.script);
        _refreshEngineEstimate(widget.payload.script, currentMultiplier);

        final baseDurationMs = _engineBaseEstimateMs ?? validationResult.estimatedDurationMs;
        final adjustedDurationMs = _engineEstimateMs ?? (baseDurationMs * currentMultiplier).round();

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.speed, color: cs.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      context.l10n.executionSpeed,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _SpeedPresetChip(
                      label: context.l10n.ultra,
                      multiplier: 0.1,
                      icon: Icons.bolt,
                      currentMultiplier: currentMultiplier,
                      onTap: () => ref.read(appSettingsControllerProvider.notifier).setDelayMultiplier(0.1),
                      tooltip: 'Ultra fast may be unreliable on some hosts.',
                    ),
                    _SpeedPresetChip(
                      label: context.l10n.fast,
                      multiplier: 0.5,
                      icon: Icons.fast_forward,
                      currentMultiplier: currentMultiplier,
                      onTap: () => ref.read(appSettingsControllerProvider.notifier).setDelayMultiplier(0.5),
                    ),
                    _SpeedPresetChip(
                      label: context.l10n.normal,
                      multiplier: 1.0,
                      icon: Icons.play_arrow,
                      currentMultiplier: currentMultiplier,
                      onTap: () => ref.read(appSettingsControllerProvider.notifier).setDelayMultiplier(1.0),
                    ),
                    _SpeedPresetChip(
                      label: context.l10n.slow,
                      multiplier: 2.0,
                      icon: Icons.speed,
                      currentMultiplier: currentMultiplier,
                      onTap: () => ref.read(appSettingsControllerProvider.notifier).setDelayMultiplier(2.0),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.speedMultiplier,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${currentMultiplier.toStringAsFixed(2)}×',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: cs.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _getSpeedLabel(currentMultiplier),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Slider(
                  value: currentMultiplier.clamp(0.1, 4.0),
                  min: 0.1,
                  max: 4.0,
                  divisions: 39,
                  label: '${currentMultiplier.toStringAsFixed(2)}×',
                  onChanged: (v) {
                    ref.read(appSettingsControllerProvider.notifier).setDelayMultiplier(v);
                  },
                ),
                Text(
                  context.l10n.executionSpeedScalesScriptDelaysTypingSpeedIsSetInSettings,
                  style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, size: 16, color: cs.onSurfaceVariant),
                          const SizedBox(width: 8),
                          Text(
                            context.l10n.estimatedDuration,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (currentMultiplier == 1.0) ...[
                        Text(
                          '~${_formatDuration(baseDurationMs)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                          ),
                        ),
                      ] else ...[
                        Row(
                          children: [
                            Text(
                              context.l10n.original,
                              style: TextStyle(
                                fontSize: 13,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              '~${_formatDuration(baseDurationMs)}',
                              style: TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.lineThrough,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              context.l10n.adjusted,
                              style: TextStyle(
                                fontSize: 13,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              '~${_formatDuration(adjustedDurationMs)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: cs.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(${currentMultiplier.toStringAsFixed(2)}×)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: cs.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        context.l10n.basedOnCountCommandsAndSecOfDelays(
                          validationResult.commandCount,
                          (validationResult.totalDelayMs / 1000).toStringAsFixed(1),
                        ),
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.tertiaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: cs.primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 14, color: cs.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          context.l10n.slowerSpeedsFasterSpeeds,
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
      },
    );
  }

  String _formatDuration(int ms) {
    final seconds = ms / 1000;
    if (seconds < 1) return context.l10n.milisec(ms);
    if (seconds < 60) return context.l10n.sec(seconds.toStringAsFixed(1));
    final minutes = seconds ~/ 60;
    final remainingSeconds = (seconds % 60).round();
    return context.l10n.minAndSec(minutes, remainingSeconds);
  }

  String _getSpeedLabel(double multiplier) {
    if (multiplier >= 3.0) return context.l10n.verySlow;
    if (multiplier >= 1.5) return context.l10n.slow;
    if (multiplier >= 0.9 && multiplier <= 1.1) return context.l10n.normal;
    if (multiplier >= 0.5) return context.l10n.fast;
    return context.l10n.veryFast;
  }
}

class _SpeedPresetChip extends StatelessWidget {
  const _SpeedPresetChip({
    required this.label,
    required this.multiplier,
    required this.icon,
    required this.currentMultiplier,
    required this.onTap,
    this.tooltip,
  });

  final String label;
  final double multiplier;
  final IconData icon;
  final double currentMultiplier;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isSelected = (currentMultiplier - multiplier).abs() < 0.01;

    final chip = ChoiceChip(
      selected: isSelected,
      onSelected: (_) => onTap(),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: isSelected ? cs.onPrimaryContainer : cs.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            '$label ${multiplier.toStringAsFixed(1)}×',
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
      selectedColor: cs.primaryContainer,
      backgroundColor: cs.surfaceContainerHighest,
      side: BorderSide(color: isSelected ? cs.primary : cs.outlineVariant),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    return tooltip == null ? chip : Tooltip(message: tooltip!, child: chip);
  }
}

class _PreExecutionChecklist extends StatefulWidget {
  const _PreExecutionChecklist({
    required this.hid,
    required this.payload,
    required this.paramControllers,
  });

  final HidStatus hid;
  final Payload payload;
  final Map<String, TextEditingController> paramControllers;

  @override
  State<_PreExecutionChecklist> createState() => _PreExecutionChecklistState();
}

class _PreExecutionChecklistState extends State<_PreExecutionChecklist> {
  bool _expanded = false;

  @override
  void didUpdateWidget(_PreExecutionChecklist oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_hasCriticalFailures() && !_expanded) {
      setState(() => _expanded = true);
    }
  }

  bool _hasCriticalFailures() {
    return !widget.hid.rootAvailable ||
        !widget.hid.hidSupported ||
        !widget.hid.sessionArmed ||
        _hasInvalidRequiredParams();
  }

  bool _hasInvalidRequiredParams() {
    for (final param in widget.payload.parameters) {
      if (param.required) {
        final value = widget.paramControllers[param.key]?.text ?? '';
        if (value.trim().isEmpty) return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasCriticalFailures = _hasCriticalFailures();

    final checks = [
      _CheckItem(
        label: context.l10n.rootAccess,
        passed: widget.hid.rootAvailable,
        critical: true,
        message: widget.hid.rootAvailable
            ? context.l10n.rootShellAvailable
            : context.l10n.rootAccessRequiredForUSBGadgetControl,
      ),
      _CheckItem(
        label: context.l10n.usbHIDSupport,
        passed: widget.hid.hidSupported,
        critical: true,
        message: widget.hid.hidSupported
            ? context.l10n.usbGadgetConfigfsDetected
            : context.l10n.deviceDoesNotSupportUSBGadgetMode,
      ),
      _CheckItem(
        label: context.l10n.hidSessionArmed,
        passed: widget.hid.sessionArmed,
        critical: true,
        message: widget.hid.sessionArmed
            ? context.l10n.usbGadgetIsActive
            : context.l10n.armSessionFromDashboardToActivateUSBGadget,
      ),
      _CheckItem(
        label: context.l10n.targetDeviceConnected,
        passed: widget.hid.deviceConnected,
        critical: false,
        message: widget.hid.deviceConnected
            ? context.l10n.usbCableConnectedToTarget
            : context.l10n.connectUSBCableToTargetDeviceOptionalForTesting,
      ),
      _CheckItem(
        label: context.l10n.payloadSelected,
        passed: true,
        critical: true,
        message: context.l10n.payloadName(widget.payload.name),
      ),
      if (widget.payload.parameters.isNotEmpty)
        _CheckItem(
          label: context.l10n.requiredParameters,
          passed: !_hasInvalidRequiredParams(),
          critical: true,
          message: _hasInvalidRequiredParams()
              ? context.l10n.fillInAllRequiredParametersAbove
              : context.l10n.allRequiredParametersProvided,
        ),
    ];

    final passedCount = checks.where((c) => c.passed).length;
    final totalCount = checks.length;
    final allPassed = passedCount == totalCount;

    return Card(
      color: hasCriticalFailures
          ? cs.errorContainer.withOpacity(0.3)
          : allPassed
              ? cs.primaryContainer.withOpacity(0.3)
              : cs.surfaceContainerHighest,
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: hasCriticalFailures
                          ? cs.errorContainer
                          : allPassed
                              ? cs.primaryContainer
                              : cs.tertiaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      hasCriticalFailures
                          ? Icons.error
                          : allPassed
                              ? Icons.check_circle
                              : Icons.warning_amber,
                      color: hasCriticalFailures
                          ? cs.onErrorContainer
                          : allPassed
                              ? cs.onPrimaryContainer
                              : cs.onTertiaryContainer,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.preExecutionChecklist,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: hasCriticalFailures ? cs.error : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.checksPassed(passedCount, totalCount),
                          style: TextStyle(
                            fontSize: 13,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: cs.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < checks.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    _CheckRow(check: checks[i]),
                  ],
                  if (hasCriticalFailures) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.errorContainer.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: cs.error.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.block, size: 18, color: cs.error),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              context.l10n.fixCriticalIssuesAboveBeforeExecuting,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: cs.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CheckItem {
  const _CheckItem({
    required this.label,
    required this.passed,
    required this.critical,
    required this.message,
  });

  final String label;
  final bool passed;
  final bool critical;
  final String message;
}

class _CheckRow extends StatelessWidget {
  const _CheckRow({required this.check});

  final _CheckItem check;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    IconData icon;
    Color color;

    if (check.passed) {
      icon = Icons.check_circle;
      color = cs.primary;
    } else if (check.critical) {
      icon = Icons.cancel;
      color = cs.error;
    } else {
      icon = Icons.warning_amber;
      color = cs.tertiary;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      check.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: check.passed
                            ? null
                            : (check.critical ? cs.error : cs.tertiary),
                      ),
                    ),
                  ),
                  if (check.critical && !check.passed)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: cs.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        context.l10n.required,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: cs.onError,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                check.message,
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

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.hid, required this.exec});

  final HidStatus hid;
  final ExecutionState exec;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    IconData icon;
    Color color;
    String message;

    if (!hid.rootAvailable || !hid.hidSupported) {
      icon = Icons.error_outline;
      color = cs.error;
      message = context.l10n.rootHIDUnavailable;
    } else if (!hid.sessionArmed) {
      icon = Icons.lock_outline;
      color = cs.tertiary;
      message = context.l10n.sessionDisarmed;
    } else if (!hid.deviceConnected) {
      icon = Icons.usb_off;
      color = cs.tertiary;
      message = context.l10n.noDeviceConnected;
    } else if (exec.isRunning) {
      icon = Icons.play_circle;
      color = cs.primary;
      message = context.l10n.executingThreePoints;
    } else {
      icon = Icons.check_circle;
      color = cs.primary;
      message = context.l10n.readyToExecute;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border(bottom: BorderSide(color: color.withOpacity(0.3))),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          if (exec.isRunning)
            Text(
              '${(exec.progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
        ],
      ),
    );
  }
}

class _PayloadSelectionCard extends StatelessWidget {
  const _PayloadSelectionCard({
    required this.payloads,
    required this.selectedPayload,
    required this.onChanged,
    required this.onEdit,
  });

  final List<Payload> payloads;
  final Payload selectedPayload;
  final ValueChanged<String> onChanged;
  final VoidCallback onEdit;

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
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.inventory_2, color: cs.onPrimaryContainer, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  context.l10n.selectedPayload,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedPayload.id,
              decoration: InputDecoration(
                labelText: context.l10n.payload,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: payloads
                  .map((p) => DropdownMenuItem<String>(
                        value: p.id,
                        child: Text(p.name, overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
            if (selectedPayload.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                selectedPayload.description,
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
            if (selectedPayload.tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: selectedPayload.tags.map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: cs.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: cs.onSecondaryContainer,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 18),
                label: Text(context.l10n.editPayload),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParametersCard extends StatelessWidget {
  const _ParametersCard({
    required this.payload,
    required this.controllers,
  });

  final Payload payload;
  final Map<String, TextEditingController> controllers;

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
                Icon(Icons.tune, color: cs.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  context.l10n.parameters,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < payload.parameters.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              _ParameterField(
                parameter: payload.parameters[i],
                controller: controllers[payload.parameters[i].key]!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ParameterField extends StatelessWidget {
  const _ParameterField({
    required this.parameter,
    required this.controller,
  });

  final parameter;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: parameter.label,
        hintText: parameter.defaultValue,
        helperText: parameter.description.isNotEmpty ? parameter.description : null,
        border: const OutlineInputBorder(),
        suffixIcon: parameter.required ? const Icon(Icons.star, size: 16, color: Colors.red) : null,
      ),
    );
  }
}

class _ExecutionControlCard extends StatelessWidget {
  const _ExecutionControlCard({
    required this.exec,
    required this.hid,
    required this.onRun,
    required this.onStop,
    required this.onPanicStop,
  });

  final ExecutionState exec;
  final HidStatus hid;
  final VoidCallback onRun;
  final VoidCallback onStop;
  final VoidCallback onPanicStop;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final canRun = hid.rootAvailable && hid.hidSupported && hid.sessionArmed && !exec.isRunning;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  exec.isRunning ? Icons.play_circle : Icons.rocket_launch,
                  color: cs.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  context.l10n.execution,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (exec.isRunning) ...[
              LinearProgressIndicator(value: exec.progress),
              const SizedBox(height: 12),
              Text(
                exec.status,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 16),
            ],
            if (!canRun && !exec.isRunning) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cs.errorContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: cs.error.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: cs.error),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _getBlockReason(hid, context),
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: canRun ? onRun : null,
                    icon: const Icon(Icons.play_arrow),
                    label: Text(context.l10n.runPayload),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      disabledBackgroundColor: cs.surfaceContainerHighest,
                      disabledForegroundColor: cs.onSurfaceVariant,
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

  String _getBlockReason(HidStatus hid, BuildContext context) {
    if (!hid.rootAvailable) return context.l10n.rootAccesNotAvailable;
    if (!hid.hidSupported) return context.l10n.usbHIDNotSupported;
    if (!hid.sessionArmed) return context.l10n.sessionIsDisarmedArmItFromDashboardFirst;
    return context.l10n.cannotExecute;
  }
}

class _ConsoleTabs extends StatelessWidget {
  const _ConsoleTabs({
    required this.tabController,
    required this.rawController,
    required this.exec,
    required this.onSendCommand,
  });

  final TabController tabController;
  final TextEditingController rawController;
  final ExecutionState exec;
  final ValueChanged<String> onSendCommand;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(text: context.l10n.console, icon: Icon(Icons.terminal, size: 18)),
              Tab(text: context.l10n.events, icon: Icon(Icons.list, size: 18)),
            ],
          ),
          SizedBox(
            height: 350,
            child: TabBarView(
              controller: tabController,
              children: [
                _ConsoleTab(
                  controller: rawController,
                  onSend: onSendCommand,
                ),
                _EventsTab(exec: exec),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsoleTab extends ConsumerStatefulWidget {
  const _ConsoleTab({
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSend;

  @override
  ConsumerState<_ConsoleTab> createState() => _ConsoleTabState();
}

class _ConsoleTabState extends ConsumerState<_ConsoleTab> {
  String? _selectedPreset;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final advSettingsAsync = ref.watch(advancedSettingsControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.sendRawHIDCommands,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton.icon(
                onPressed: () => _showSavePresetDialog(context),
                icon: const Icon(Icons.bookmark_add, size: 16),
                label: Text(context.l10n.saveAsPreset),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          advSettingsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (settings) {
              if (settings.commandPresets.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.quickCommands,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: cs.outlineVariant),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedPreset,
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Icon(Icons.code, size: 16, color: cs.onSurfaceVariant),
                              const SizedBox(width: 8),
                              Text(
                                context.l10n.selectAPreset,
                                style: TextStyle(color: cs.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        items: [
                          for (int i = 0; i < settings.commandPresets.length; i++)
                            DropdownMenuItem<String>(
                              value: i.toString(),
                              child: Tooltip(
                                message: settings.commandPresets[i],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      Icon(Icons.code, size: 16, color: cs.primary),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _truncatePreset(settings.commandPresets[i], 40),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontFamily: 'monospace',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            final index = int.parse(value);
                            widget.controller.text = settings.commandPresets[index];
                            setState(() => _selectedPreset = null);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: 'STRING hello | ENTER | DELAY 200',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  final cmd = widget.controller.text.trim();
                  if (cmd.isNotEmpty) {
                    widget.onSend(cmd);
                  }
                },
                icon: const Icon(Icons.send),
                tooltip: 'Send command',
              ),
            ),
            maxLines: 3,
            onSubmitted: (v) {
              if (v.trim().isNotEmpty) {
                widget.onSend(v.trim());
              }
            },
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.examples + ': STRING text, ENTER, DELAY 500, GUI r',
            style: TextStyle(
              fontSize: 11,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _truncatePreset(String preset, int maxLength) {
    final singleLine = preset.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
    if (singleLine.length <= maxLength) return singleLine;
    return '${singleLine.substring(0, maxLength - 1)}…';
  }

  Future<void> _showSavePresetDialog(BuildContext context) async {
    final currentText = widget.controller.text.trim();
    if (currentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.enterACommandFirstBeforeSavingAsPreset),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final nameCtrl = TextEditingController();
    final presetCtrl = TextEditingController(text: currentText);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.saveAsPreset),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: context.l10n.presetNameOptional,
                  hintText: context.l10n.egOpenNotepad,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.command,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: presetCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                ),
                maxLines: 6,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.save),
          ),
        ],
      ),
    );

    if (result == true && context.mounted) {
      final presetText = presetCtrl.text.trim();
      if (presetText.isNotEmpty) {
        await ref.read(advancedSettingsControllerProvider.notifier).addCommandPreset(presetText);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.presetSavedSuccessfully),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }
}

class _EventsTab extends StatelessWidget {
  const _EventsTab({required this.exec});

  final ExecutionState exec;

  @override
  Widget build(BuildContext context) {
    if (exec.tail.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.article_outlined, size: 48, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(context.l10n.noEventsYet),
            const SizedBox(height: 4),
            Text(
              context.l10n.runAPayloadToSeeExecutionEvents,
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: exec.tail.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final e = exec.tail[i];
        return ListTile(
          dense: true,
          leading: Icon(_iconFor(e.level, e.success), size: 20),
          title: Text(e.message, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            _formatTime(e.timestamp, context),
            style: const TextStyle(fontSize: 11),
          ),
        );
      },
    );
  }

  IconData _iconFor(String level, bool success) {
    if (!success) return Icons.error_outline;
    switch (level) {
      case 'debug':
        return Icons.bug_report_outlined;
      case 'warn':
        return Icons.warning_amber_outlined;
      case 'error':
        return Icons.error_outline;
      default:
        return Icons.info_outline;
    }
  }

  String _formatTime(DateTime dt, BuildContext context) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inSeconds < 60) return context.l10n.secAgo(diff.inSeconds);
    if (diff.inMinutes < 60) return context.l10n.minAgo(diff.inMinutes);
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
