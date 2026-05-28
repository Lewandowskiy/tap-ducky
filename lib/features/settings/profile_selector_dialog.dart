import 'package:flutter/material.dart';

import '../../extension/context_extensions.dart';

enum GadgetProfileType {
  keyboard,
  mouse,
  composite;

  String displayName(l10n) {
    switch (this) {
      case GadgetProfileType.keyboard:
        return l10n.keyboardOnly;
      case GadgetProfileType.mouse:
        return l10n.mouseOnly;
      case GadgetProfileType.composite:
        return l10n.compositeKeyboardMouse;
    }
  }

  String description(l10n) {
    switch (this) {
      case GadgetProfileType.keyboard:
        return l10n.keyboardProfileDescription;
      case GadgetProfileType.mouse:
        return l10n.mouseProfileDescription;
      case GadgetProfileType.composite:
        return l10n.compositeProfileDescription;
    }
  }

  IconData get icon {
    switch (this) {
      case GadgetProfileType.keyboard:
        return Icons.keyboard;
      case GadgetProfileType.mouse:
        return Icons.mouse;
      case GadgetProfileType.composite:
        return Icons.devices;
    }
  }
}

Future<GadgetProfileType?> showProfileSelectorDialog(
  BuildContext context, {
  GadgetProfileType? initialSelection,
}) async {
  return showDialog<GadgetProfileType>(
    context: context,
    builder: (context) => _ProfileSelectorDialog(initialSelection: initialSelection),
  );
}

class _ProfileSelectorDialog extends StatefulWidget {
  const _ProfileSelectorDialog({this.initialSelection});

  final GadgetProfileType? initialSelection;

  @override
  State<_ProfileSelectorDialog> createState() => _ProfileSelectorDialogState();
}

class _ProfileSelectorDialogState extends State<_ProfileSelectorDialog> {
  late GadgetProfileType _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelection ?? GadgetProfileType.composite;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(context.l10n.selectUSBGadgetProfile),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.chooseTheHIDDeviceTypeToActivate,
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            for (final type in GadgetProfileType.values) ...[
              _ProfileOption(
                type: type,
                selected: _selected == type,
                onTap: () => setState(() => _selected = type),
              ),
              if (type != GadgetProfileType.values.last) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(context.l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_selected),
          child: Text(context.l10n.activate),
        ),
      ],
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final GadgetProfileType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              type.icon,
              color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          type.displayName(context.l10n),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: selected ? cs.onPrimaryContainer : null,
                          ),
                        ),
                      ),
                      if (type == GadgetProfileType.composite)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: cs.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            context.l10n.recommended,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: cs.onPrimary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type.description(context.l10n),
                    style: TextStyle(
                      fontSize: 12,
                      color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Radio<GadgetProfileType>(
              value: type,
              groupValue: selected ? type : null,
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}