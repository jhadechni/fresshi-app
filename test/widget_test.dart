import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fresshi/main.dart';

void main() {
  testWidgets('App smoke test - renders without crashing', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: FresshiApp()),
    );
    expect(find.byType(FresshiApp), findsOneWidget);
  });
}
