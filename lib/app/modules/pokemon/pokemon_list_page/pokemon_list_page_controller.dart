import 'package:get/get.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';
import 'package:pokedex/app/core/application/use_cases/pokemon_list_use_case.dart';

class PokemonListPageController extends GetxController {
  PokemonListUseCase pokemonListUseCase = PokemonListUseCase();

  List<PokemonPreviewModel> pokemonList = <PokemonPreviewModel>[];
  RxList<PokemonPreviewModel> filterPokemonList = <PokemonPreviewModel>[].obs;

  @override
  onInit() {
    super.onInit();
    getPokemonList();
  }

  void getPokemonList() async {
    pokemonList = await pokemonListUseCase.getPokemonList();
    filterPokemonList.value = pokemonList;
  }

  void onTapPokemonCard(PokemonPreviewModel pokemon) {
    Get.toNamed('/pokemon_details', arguments: pokemon);
  }

  void onChanged(String value) {
    filterPokemonList.value = pokemonList
        .where((pokemon) =>
            pokemon.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }
}
