import 'package:get/get.dart';
import 'package:pokedex/app/core/application/models/pokemon_flavor_text_model.dart';
import 'package:pokedex/app/core/application/models/pokemon_model.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/domain/repositories/i_repository.dart';
import 'package:pokedex/app/core/domain/use_cases/i_pokemon_details_use_case.dart';
import 'package:pokedex/app/core/infrastructure/endpoints/endpoints.dart';

class PokemonDetailsUseCase implements IPokemonDetailsUseCase {
  final IHttpClientAdapter _httpClientAdapter = Get.find<IHttpClientAdapter>();
  final IRepository _iRepository = Get.find<IRepository>();

  @override
  Future<PokemonModel> getPokemon(int id) async {
    String endpoint = '${Endpoints.pokemon}/$id';
    Map? data;
    Map? cache = await _iRepository.getById(endpoint);
    if (cache != null) {
      data = cache;
    } else {
      final response = await _httpClientAdapter.get(
        endpoint,
      );
      if (response.statusCode.isSuccess) {
        data = response.data;
        if (data != null) {
          await _iRepository.add(endpoint, data);
        }
      } else {
        throw Exception('Failed to load pokemon');
      }
    }
    return PokemonModel.fromJson(data!);
  }

  @override
  Future<PokemonFlavorTextModel> getFlavorText(int id) async {
    String endpoint = '${Endpoints.pokemonSpecies}/$id';
    Map? data;
    Map? cache = await _iRepository.getById(endpoint);

    if (cache != null) {
      data = cache;
    } else {
      final response = await _httpClientAdapter.get(
        endpoint,
      );
      if (response.statusCode.isSuccess) {
        data = response.data;
        if (data != null) {
          await _iRepository.add(endpoint, data);
        }
      } else {
        throw Exception('Failed to load flavor text');
      }
    }

    if (data == null) {
      throw Exception('Failed to load flavor text');
    }
    if (data['flavor_text_entries'] != null) {
      data['flavor_text_entries'].removeWhere(
        (entry) => (entry['language']['name'] != 'en'),
      );
      return PokemonFlavorTextModel.fromJson(data);
    } else {
      throw Exception('Failed to load flavor text');
    }
  }
}
