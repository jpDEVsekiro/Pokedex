import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_list_page/pokemon_list_page.dart';

import '../../../../all_integration_test.dart';

void main() {
  group('Pokemon Details Page Integration Test', () {
    testWidgets('Open Pokemon Details Page', (WidgetTester tester) async {
      await openPokemonDetailsPageTest(tester);
    });

    testWidgets('Tap type badge fire', (WidgetTester tester) async {
      await openPokemonDetailsPageTest(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('type_badge_fire')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 2000));
      expect(find.byType(PokemonListPage), findsOneWidget);
      expect(find.byKey(Key('select_type_badge_fire')), findsOneWidget);
      expect(find.byKey(Key('pokemon_6')), findsOneWidget);
    });

    testWidgets('Tap type badge flying', (WidgetTester tester) async {
      await openPokemonDetailsPageTest(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('type_badge_flying')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 2000));
      expect(find.byType(PokemonListPage), findsOneWidget);
      expect(find.byKey(Key('select_type_badge_flying')), findsOneWidget);
      expect(find.byKey(Key('pokemon_6')), findsOneWidget);
    });

    testWidgets('Tap ability badge blaze', (WidgetTester tester) async {
      await openPokemonDetailsPageTest(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('ability_box_blaze')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 2000));
      expect(find.byType(PokemonListPage), findsOneWidget);
      expect(find.byKey(Key('select_ability_badge_blaze')), findsOneWidget);
      expect(find.byKey(Key('pokemon_6')), findsOneWidget);
    });

    testWidgets('Tap ability badge solar-power', (WidgetTester tester) async {
      await openPokemonDetailsPageTest(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('ability_box_solar-power')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 2000));
      expect(find.byType(PokemonListPage), findsOneWidget);
      expect(
          find.byKey(Key('select_ability_badge_solar-power')), findsOneWidget);
      expect(find.byKey(Key('pokemon_6')), findsOneWidget);
    });
  });
}
