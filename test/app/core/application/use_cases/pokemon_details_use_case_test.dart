import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/app/core/application/models/pokemon_model.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';
import 'package:pokedex/app/core/application/use_cases/pokemon_details_use_case.dart';
import 'package:pokedex/app/core/domain/http_adapters/http_response.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/infrastructure/endpoints/endpoints.dart';

import '../../domain/http_adapters/mock_i_http_client_adapter.dart';

PokemonModel pokemonModel = PokemonModel(
  baseExperience: 100,
  abilities: ['overgrow', 'chlorophyll'],
  weight: 69,
  height: 7,
  gifUrl: 'https://example.com/gif',
  criesUrl: 'https://example.com/cries',
  types: [],
  pokemonPreviewModel: PokemonPreviewModel(
    name: 'Pikachu',
    id: 1,
    imageUrl: 'https://example.com/image',
  ),
);

Map<String, dynamic> pokemonMap = {
  'id': 1,
  'name': 'Pikachu',
  'base_experience': pokemonModel.baseExperience,
  'weight': pokemonModel.weight,
  'height': pokemonModel.height,
  'sprites': {
    'front_default': pokemonModel.gifUrl,
    'other': {
      'showdown': {
        'front_default': pokemonModel.gifUrl,
      }
    }
  },
  'abilities': [
    {
      'ability': {'name': pokemonModel.abilities[0]}
    },
    {
      'ability': {'name': pokemonModel.abilities[1]}
    },
  ],
  'types': [],
};

Map<String, dynamic> pokemonSpeciesMap = {
  'evolution_chain': {'url': 'https://pokeapi.co/api/v2/pokemon-species/25/'},
  'flavor_text_entries': [
    {
      'flavor_text': 'Flavor text',
      'language': {'name': 'en'}
    }
  ]
};

void main() {
  group('MoTelsListingRepository test', () {
    final mockIHttp = MockIHttpClientAdapter();
    Get.put<IHttpClientAdapter>(mockIHttp);

    final useCase = PokemonDetailsUseCase();

    test(
        'PokemonDetailsUseCase should return PokemonModel when given a valid id',
        () async {
      final pokemonId = 1;

      when(() => mockIHttp.get('${Endpoints.pokemon}/$pokemonId'))
          .thenAnswer((_) async => HttpResponse(
                statusCode: StatusCodeEnum.ok,
                data: pokemonMap,
              ));

      final result = await useCase.getPokemon(pokemonId);
      expect(result.pokemonPreviewModel.name,
          pokemonModel.pokemonPreviewModel.name);
      expect(
          result.pokemonPreviewModel.id, pokemonModel.pokemonPreviewModel.id);
      expect(result.baseExperience, pokemonModel.baseExperience);
      expect(result.weight, pokemonModel.weight);
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
                data: pokemonSpeciesMap,
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
