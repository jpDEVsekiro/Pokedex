import 'package:pokedex/app/core/application/models/pokemon_model.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';

class MockPokemonModel {
  final PokemonModel pokemonModel = PokemonModel(
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
    'base_experience': 100,
    'cries': {
      'latest': 'https://example.com/cries',
    },
    'weight': 69,
    'height': 7,
    'sprites': {
      'front_default': 'https://example.com/image',
      'other': {
        'showdown': {
          'front_default': 'https://example.com/git',
        }
      }
    },
    'abilities': [
      {
        'ability': {'name': 'overgrow'}
      },
      {
        'ability': {'name': 'chlorophyll'}
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
}
