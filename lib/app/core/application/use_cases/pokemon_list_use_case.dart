import 'package:get/get.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';
import 'package:pokedex/app/core/domain/http_adapters/http_response.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/domain/use_cases/i_pokemon_list_use_case.dart';
import 'package:pokedex/app/core/infrastructure/endpoints/endpoints.dart';

class PokemonListUseCase implements IPokemonListUseCase {
  final IHttpClientAdapter _httpClientAdapter = Get.find<IHttpClientAdapter>();
  @override
  Future<List<PokemonPreviewModel>> getPokemonList() async {
    try {
      HttpResponse httpResponse =
          await _httpClientAdapter.get(Endpoints.pokemon, queryParameters: {
        'limit': 1000000,
        'offset': 0,
      });
      List<PokemonPreviewModel> pokemonList = [];
      if (httpResponse.statusCode.isError ||
          httpResponse.data['results'] == null) {
        throw Exception('Failed to load pokemon list');
      }
      for (var pokemon in httpResponse.data['results']) {
        pokemonList.add(PokemonPreviewModel.fromJson(pokemon));
      }
      return pokemonList;
    } catch (e) {
      throw Exception('Failed to load pokemon list');
    }
  }

  @override
  Future<List<PokemonPreviewModel>> getPokemonListByType(
      PokemonTypeEnum type) async {
    try {
      HttpResponse httpResponse =
          await _httpClientAdapter.get('${Endpoints.type}/${type.name}');
      List<PokemonPreviewModel> pokemonList = [];
      if (httpResponse.statusCode.isError ||
          httpResponse.data['pokemon'] == null) {
        throw Exception('Failed to load pokemon list by type');
      }
      for (var pokemon in httpResponse.data['pokemon']) {
        pokemonList.add(PokemonPreviewModel.fromJson(pokemon['pokemon']));
      }
      return pokemonList;
    } catch (e) {
      throw Exception('Failed to load pokemon list by type');
    }
  }

  @override
  Future<List<PokemonPreviewModel>> getPokemonListByAbility(
      String ability) async {
    try {
      HttpResponse httpResponse =
          await _httpClientAdapter.get('${Endpoints.ability}/$ability');
      List<PokemonPreviewModel> pokemonList = [];
      if (httpResponse.statusCode.isError ||
          httpResponse.data['pokemon'] == null) {
        throw Exception('Failed to load pokemon list by ability');
      }
      for (var pokemon in httpResponse.data['pokemon']) {
        pokemonList.add(PokemonPreviewModel.fromJson(pokemon['pokemon']));
      }
      return pokemonList;
    } catch (e) {
      throw Exception('Failed to load pokemon list by ability');
    }
  }

  @override
  Future<List<String>> getPokemonAbilities() async {
    try {
      HttpResponse httpResponse =
          await _httpClientAdapter.get(Endpoints.ability, queryParameters: {
        'limit': 1000000,
        'offset': 0,
      });
      List<String> abilityList = [];
      if (httpResponse.statusCode.isError ||
          httpResponse.data['results'] == null) {
        throw Exception('Failed to load pokemon abilities');
      }
      for (var ability in httpResponse.data['results']) {
        abilityList.add(ability['name']);
      }
      return abilityList;
    } catch (e) {
      throw Exception('Failed to load pokemon abilities');
    }
  }
}
