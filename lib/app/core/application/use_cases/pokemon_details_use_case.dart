import 'package:get/get.dart';
import 'package:pokedex/app/core/application/models/pokemon_flavor_text_model.dart';
import 'package:pokedex/app/core/application/models/pokemon_model.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/domain/use_cases/i_pokemon_details_use_case.dart';
import 'package:pokedex/app/core/infrastructure/endpoints/endpoints.dart';

class PokemonDetailsUseCase implements IPokemonDetailsUseCase {
  final IHttpClientAdapter _httpClientAdapter = Get.find<IHttpClientAdapter>();

  @override
  Future<PokemonModel> getPokemon(int id) async {
    final response = await _httpClientAdapter.get(
      '${Endpoints.pokemon}/$id',
    );

    if (response.statusCode.isSuccess) {
      return PokemonModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Future<PokemonFlavorTextModel> getFlavorText(int id) async {
    final response = await _httpClientAdapter.get(
      '${Endpoints.pokemonSpecies}/$id',
    );
    if (response.statusCode.isSuccess) {
      if (response.data['flavor_text_entries'] != null) {
        response.data['flavor_text_entries'].removeWhere(
          (entry) => (entry['language']['name'] != 'en'),
        );
        return PokemonFlavorTextModel.fromJson(response.data);
      }
      throw Exception('Failed to load flavor text');
    } else {
      throw Exception('Failed to load flavor text');
    }
  }
}
