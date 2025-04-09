import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/app/core/application/use_cases/pokemon_details_use_case.dart';
import 'package:pokedex/app/core/domain/http_adapters/http_response.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/infrastructure/endpoints/endpoints.dart';

import '../../domain/http_adapters/mock_i_http_client_adapter.dart';
import '../models/mock_pokemon_model.dart';

void main() {
  group('MoTelsListingRepository test', () {
    final mockIHttp = MockIHttpClientAdapter();
    Get.put<IHttpClientAdapter>(mockIHttp);
    final mockPokemon = MockPokemonModel();

    final useCase = PokemonDetailsUseCase();

    test(
        'PokemonDetailsUseCase should return PokemonModel when given a valid id',
        () async {
      final pokemonId = 1;

      when(() => mockIHttp.get('${Endpoints.pokemon}/$pokemonId'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.ok,
                data: mockPokemon.pokemonMap,
              ));

      final result = await useCase.getPokemon(pokemonId);
      expect(result.pokemonPreviewModel.name,
          mockPokemon.pokemonModel.pokemonPreviewModel.name);
      expect(result.pokemonPreviewModel.id,
          mockPokemon.pokemonModel.pokemonPreviewModel.id);
      expect(result.baseExperience, mockPokemon.pokemonModel.baseExperience);
      expect(result.weight, mockPokemon.pokemonModel.weight);
    });

    test(
        'PokemonDetailsUseCase should throw an exception when occurs an error while fetching the pokemon',
        () async {
      final pokemonId = 2;

      when(() => mockIHttp.get('${Endpoints.pokemon}/$pokemonId'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.notFound,
                data: {},
              ));

      expect(() async => await useCase.getPokemon(pokemonId),
          throwsA(isA<Exception>()));
    });

    test(
        'PokemonDetailsUseCase should return PokemonFlavorTextModel when given a valid id',
        () async {
      final pokemonId = 1;

      when(() => mockIHttp.get('${Endpoints.pokemonSpecies}/$pokemonId'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.ok,
                data: mockPokemon.pokemonSpeciesMap,
              ));

      final result = await useCase.getFlavorText(pokemonId);
      expect(result.flavorText, 'Flavor text');
      expect(result.evolutionChainUrl,
          'https://pokeapi.co/api/v2/pokemon-species/25/');
    });

    test(
        'PokemonDetailsUseCase should throw an exception when occurs an error while fetching the flavor text',
        () async {
      final pokemonId = 2;

      when(() => mockIHttp.get('${Endpoints.pokemonSpecies}/$pokemonId'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.notFound,
                data: {},
              ));

      expect(() async => await useCase.getFlavorText(pokemonId),
          throwsA(isA<Exception>()));
    });
  });
}
