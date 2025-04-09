import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_list_page/pokemon_list_page.dart';
import 'package:pokedex/app/modules/pokemon_details/pokemon_details_page/pokemon_details_page.dart';
import 'package:pokedex/main.dart' as app;

import 'app/modules/pokemon/pokemon_list_page/pokemon_list_page_integration_test.dart'
    as pokemon_list_page_integration_test;
import 'app/modules/pokemon_details/pokemon_details_page/pokemon_details_page_integration_test.dart'
    as pokemon_details_page_integration_test;

void main() {
  pokemon_list_page_integration_test.main();
  pokemon_details_page_integration_test.main();
}

Future<void> openPokemonListingPageTest(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  expect(find.byType(PokemonListPage), findsOneWidget);
  await Future.delayed(Duration(seconds: 2));
  expect(find.byKey(Key('pokemon_1')), findsOneWidget);
  expect(find.byKey(Key('pokemon_2')), findsOneWidget);
  expect(find.byKey(Key('pokemon_3')), findsOneWidget);
  expect(find.byKey(Key('select_type_badge_allTypes')), findsOneWidget);
  expect(find.byKey(Key('select_ability_badge_Habilidades')), findsOneWidget);
  await tester.pumpAndSettle();
}

Future<void> openPokemonDetailsPageTest(WidgetTester tester) async {
  await openPokemonListingPageTest(tester);
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key('pokemon_6')));
  await tester.pumpAndSettle();
  expect(find.byType(PokemonDetailsPage), findsOneWidget);
  await Future.delayed(Duration(seconds: 2));
  expect(find.byKey(Key('background_type_fire')), findsOneWidget);
  expect(find.byKey(Key('pokemon_gif_6')), findsOneWidget);
  expect(find.byKey(Key('type_badge_fire')), findsOneWidget);
  expect(find.byKey(Key('description')), findsOneWidget);
  expect(find.byKey(Key('weight')), findsOneWidget);
  expect(find.byKey(Key('height')), findsOneWidget);
  expect(find.text('Charizard'), findsOneWidget);
}
