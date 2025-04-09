import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/use_cases/pokemon_list_use_case.dart';
import 'package:pokedex/app/core/domain/http_adapters/http_response.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/infrastructure/endpoints/endpoints.dart';

import '../../domain/http_adapters/mock_i_http_client_adapter.dart';
import '../models/mock_pokemon_preview_model.dart';

void main() {
  group('PokemonListUseCase test', () {
    final mockIHttp = MockIHttpClientAdapter();
    Get.put<IHttpClientAdapter>(mockIHttp);
    final mockPokemon = MockPokemonPreviewModel();

    final useCase = PokemonListUseCase();

    test(
        'PokemonListUseCase should return a list of PokemonPreviewModel when given a valid offset and limit',
        () async {
      when(() => mockIHttp.get(Endpoints.pokemon, queryParameters: {
            'limit': 1000000,
            'offset': 0,
          })).thenAnswer((_) async => HttpResponse(
            statusCode: StatusCodeEnum.ok,
            data: mockPokemon.pokemonPreviewMap,
          ));

      final result = await useCase.getPokemonList();
      expect(result.length, 20);
      expect(result[0].name, 'bulbasaur');
      expect(result[0].id, 1);
      expect(result[5].name, 'charizard');
      expect(result[5].id, 6);
    });

    test(
        'PokemonListUseCase should throw an exception when occurs an error while fetching the pokemons',
        () async {
      when(() => mockIHttp.get(Endpoints.pokemon, queryParameters: {
            'limit': 1000000,
            'offset': 0,
          })).thenAnswer((_) async => HttpResponse(
            statusCode: StatusCodeEnum.notFound,
            data: {},
          ));

      expect(() async => await useCase.getPokemonList(),
          throwsA(isA<Exception>()));
    });

    test(
        'PokemonListUseCase should return a list of PokemonPreviewModel when given a valid type',
        () async {
      final type = PokemonTypeEnum.fire;
      when(() => mockIHttp.get('${Endpoints.type}/${type.name}'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.ok,
                data: mockPokemon.firePokemonPreviewMap,
              ));

      final result = await useCase.getPokemonListByType(type);
      expect(result.length, 4);
      expect(result[0].name, 'charizard');
      expect(result[0].id, 6);
    });

    test(
        'PokemonListUseCase should throw an exception when occurs an error while fetching the pokemons by type',
        () async {
      final type = PokemonTypeEnum.fire;
      when(() => mockIHttp.get('${Endpoints.type}/${type.name}'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.notFound,
                data: {},
              ));

      expect(() async => await useCase.getPokemonListByType(type),
          throwsA(isA<Exception>()));
    });

    test(
        'PokemonListUseCase should return a list of PokemonPreviewModel when given a valid ability',
        () async {
      final ability = 'overgrow';
      when(() => mockIHttp.get('${Endpoints.ability}/$ability'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.ok,
                data: mockPokemon.overgrowPokemonPreviewMap,
              ));

      final result = await useCase.getPokemonListByAbility(ability);
      expect(result.length, 3);
      expect(result[0].name, 'bulbasaur');
      expect(result[0].id, 1);
    });

    test(
        'PokemonListUseCase should throw an exception when occurs an error while fetching the pokemons by ability',
        () async {
      final ability = 'overgrow';
      when(() => mockIHttp.get('${Endpoints.ability}/$ability'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.notFound,
                data: {},
              ));

      expect(() async => await useCase.getPokemonListByAbility(ability),
          throwsA(isA<Exception>()));
    });

    test('PokemonListUseCase should return a list of abilities', () async {
      when(() => mockIHttp.get(Endpoints.ability, queryParameters: {
            'limit': 1000000,
            'offset': 0,
          })).thenAnswer((_) async => HttpResponse(
            statusCode: StatusCodeEnum.ok,
            data: mockPokemon.pokemonAbilityMap,
          ));

      final result = await useCase.getPokemonAbilities();
      expect(result.length, 20);
      expect(result[0], 'stench');
      expect(result[1], 'drizzle');
    });

    test(
        'PokemonListUseCase should throw an exception when occurs an error while fetching the abilities',
        () async {
      when(() => mockIHttp.get(Endpoints.ability, queryParameters: {
            'limit': 1000000,
            'offset': 0,
          })).thenAnswer((_) async => HttpResponse(
            statusCode: StatusCodeEnum.notFound,
            data: {},
          ));

      expect(() async => await useCase.getPokemonAbilities(),
          throwsA(isA<Exception>()));
    });
  });
}
