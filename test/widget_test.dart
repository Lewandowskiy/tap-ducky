import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_ducky/app/app.dart';

void main() {
  testWidgets('TapDucky app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: TapDuckyApp()));

    expect(find.byType(TapDuckyApp), findsOneWidget);
  });
}
