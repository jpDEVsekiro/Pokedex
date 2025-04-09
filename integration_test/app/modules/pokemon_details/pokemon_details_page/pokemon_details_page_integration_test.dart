import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pokemon Details Page Integration Test', () {
    testWidgets('Open Pokemon Details Page', (WidgetTester tester) async {
      await openPokemonDetailsPageTest(tester);
    });
  });
}
