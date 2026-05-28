import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/controllers/dynamic_color_controller.dart';

import '../../../extension/context_extensions.dart';

class DynamicColorsTile extends ConsumerWidget {
  const DynamicColorsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(dynamicColorsControllerProvider);
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(Icons.wallpaper_rounded, color: cs.primary),
      title: Text(context.l10n.useDynamicColors),
      subtitle: Text(
        Platform.isAndroid
            ? context.l10n.matchYourSystemMaterialYouPaletteOnSupportedDevices
            : context.l10n.dynamicColorsAreOnlyAvailableOnAndroid12,
      ),
      trailing: Switch.adaptive(
        value: enabled,
        onChanged: (v) async {
          await ref.read(dynamicColorsControllerProvider.notifier).setEnabled(v);
          HapticFeedback.selectionClick();
        },
      ),
    );
  }
}
