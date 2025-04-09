import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/modules/pokemon_details/pokemon_details_page/pokemon_details_page.dart';

import '../../../../all_integration_test.dart';

main() {
  group('Pokemon List Page Integration Test', () {
    testWidgets('Open Pokemon Listing Page', (WidgetTester tester) async {
      await openPokemonListingPageTest(tester);
    });

    testWidgets('Drag list and select Pokemon', (WidgetTester tester) async {
      await openPokemonListingPageTest(tester);
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(Key('pokemon_1')),
        Offset(0, -155.toDouble()),
      );
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 1000));
      await tester.drag(
        find.byKey(Key('pokemon_1')),
        Offset(0, -(282 * 86).toDouble()),
      );
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.tap(find.byKey(Key('pokemon_282')));
      await Future.delayed(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();
      expect(find.byType(PokemonDetailsPage), findsOneWidget);
      await Future.delayed(const Duration(milliseconds: 2000));
    });
    testWidgets('Select Type in filter', (WidgetTester tester) async {
      await openPokemonListingPageTest(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('select_type_badge_allTypes')));
      await Future.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('select_type_bottom_sheet')), findsOneWidget);
      expect(find.byKey(Key('type_badge_allTypes')), findsOneWidget);
      await tester.drag(
        find.byKey(Key('type_badge_allTypes')),
        Offset(0, -1000),
      );
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 1000));
      await tester.tap(find.byKey(Key('type_badge_psychic')));
      await Future.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('pokemon_1')), findsNothing);
      expect(find.byKey(Key('select_type_badge_psychic')), findsOneWidget);
      expect(find.byKey(Key('pokemon_63')), findsOneWidget);
    });

    testWidgets('Select Ability in filter', (WidgetTester tester) async {
      await openPokemonListingPageTest(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('select_ability_badge_Habilidades')));
      await Future.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('select_ability_bottom_sheet')), findsOneWidget);
      expect(find.byKey(Key('ability_badge_Habilidades')), findsOneWidget);
      await tester.drag(
        find.byKey(Key('ability_badge_Habilidades')),
        Offset(0, -1000),
      );
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 1000));
      await tester.tap(find.byKey(Key('ability_badge_immunity')));
      await Future.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('pokemon_1')), findsNothing);
      expect(find.byKey(Key('select_ability_badge_immunity')), findsOneWidget);
      expect(find.byKey(Key('pokemon_143')), findsOneWidget);
    });
  });
}
