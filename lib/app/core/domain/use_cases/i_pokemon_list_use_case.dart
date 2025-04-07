import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';

abstract class IPokemonListUseCase {
  Future<List<PokemonPreviewModel>> getPokemonList();
  Future<List<PokemonPreviewModel>> getPokemonListByType(PokemonTypeEnum type);
}
