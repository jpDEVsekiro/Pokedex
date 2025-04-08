import 'package:get/get.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';
import 'package:pokedex/app/core/domain/http_adapters/http_response.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/domain/repositories/i_repository.dart';
import 'package:pokedex/app/core/domain/use_cases/i_pokemon_list_use_case.dart';
import 'package:pokedex/app/core/infrastructure/endpoints/endpoints.dart';

class PokemonListUseCase implements IPokemonListUseCase {
  final IHttpClientAdapter _httpClientAdapter = Get.find<IHttpClientAdapter>();
  final IRepository _iRepository = Get.find<IRepository>();
  @override
  Future<List<PokemonPreviewModel>> getPokemonList() async {
    await _iRepository.init();
    Map? data;
    Map? cache = await _iRepository.getById(Endpoints.pokemon);
    if (cache != null) {
      data = cache;
    } else {
      HttpResponse httpResponse =
          await _httpClientAdapter.get(Endpoints.pokemon, queryParameters: {
        'limit': 1000000,
        'offset': 0,
      });
      data = httpResponse.data;
      if (data != null) {
        await _iRepository.add(Endpoints.pokemon, data);
      }
    }
    List<PokemonPreviewModel> pokemonList = [];
    for (var pokemon in data!['results']) {
      pokemonList.add(PokemonPreviewModel.fromJson(pokemon));
    }
    return pokemonList;
  }

  @override
  Future<List<PokemonPreviewModel>> getPokemonListByType(
      PokemonTypeEnum type) async {
    String endpoint = '${Endpoints.type}/${type.name}';
    Map? data;
    Map? cache = await _iRepository.getById(endpoint);
    if (cache != null) {
      data = cache;
    } else {
      HttpResponse httpResponse = await _httpClientAdapter.get(endpoint);
      data = httpResponse.data;
      if (data != null) {
        await _iRepository.add(endpoint, data);
      }
    }
    List<PokemonPreviewModel> pokemonList = [];
    for (var pokemon in data!['pokemon']) {
      pokemonList.add(PokemonPreviewModel.fromJson(pokemon['pokemon']));
    }
    return pokemonList;
  }

  @override
  Future<List<PokemonPreviewModel>> getPokemonListByAbility(
      String ability) async {
    String endpoint = '${Endpoints.ability}/$ability';
    Map? data;
    Map? cache = await _iRepository.getById(endpoint);
    if (cache != null) {
      data = cache;
    } else {
      HttpResponse httpResponse = await _httpClientAdapter.get(endpoint);
      data = httpResponse.data;
      if (data != null) {
        await _iRepository.add(endpoint, data);
      }
    }
    List<PokemonPreviewModel> pokemonList = [];
    for (var pokemon in data!['pokemon']) {
      pokemonList.add(PokemonPreviewModel.fromJson(pokemon['pokemon']));
    }
    return pokemonList;
  }

  @override
  Future<List<String>> getPokemonAbilities() async {
    await _iRepository.init();
    Map? data;
    Map? cache = await _iRepository.getById(Endpoints.ability);
    if (cache != null) {
      data = cache;
    } else {
      HttpResponse httpResponse =
          await _httpClientAdapter.get(Endpoints.ability);
      data = httpResponse.data;
      if (data != null) {
        await _iRepository.add(Endpoints.ability, data);
      }
    }
    List<String> abilityList = [];
    for (var ability in data!['results']) {
      abilityList.add(ability['name']);
    }
    return abilityList;
  }
}
