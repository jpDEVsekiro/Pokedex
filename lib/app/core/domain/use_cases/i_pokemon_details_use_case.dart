import 'package:pokedex/app/core/application/models/pokemon_flavor_text_model.dart';
import 'package:pokedex/app/core/application/models/pokemon_model.dart';

abstract class IPokemonDetailsUseCase {
  Future<PokemonModel> getPokemon(int id);
  Future<PokemonFlavorTextModel> getFlavorText(int id);
}
