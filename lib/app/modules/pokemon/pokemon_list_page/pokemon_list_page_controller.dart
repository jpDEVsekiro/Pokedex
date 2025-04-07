import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';
import 'package:pokedex/app/core/application/use_cases/pokemon_list_use_case.dart';

class PokemonListPageController extends GetxController {
  PokemonListUseCase pokemonListUseCase = PokemonListUseCase();

  List<PokemonPreviewModel> pokemonList = <PokemonPreviewModel>[];
  RxList<PokemonPreviewModel> filterPokemonList = <PokemonPreviewModel>[].obs;
  Rx<PokemonTypeEnum> selectedType = PokemonTypeEnum.allTypes.obs;
  TextEditingController searchController = TextEditingController();

  @override
  onInit() {
    super.onInit();
    getPokemonList();
  }

  void getPokemonList() async {
    searchController.text = '';
    if (selectedType.value != PokemonTypeEnum.allTypes) {
      pokemonList =
          await pokemonListUseCase.getPokemonListByType(selectedType.value);
    } else {
      pokemonList = await pokemonListUseCase.getPokemonList();
    }
    onChangedText(null);
  }

  void onTapPokemonCard(PokemonPreviewModel pokemon) {
    Get.toNamed('/pokemon_details', arguments: pokemon);
  }

  void onChangedText(String? value) {
    filterPokemonList.value = pokemonList
        .where((pokemon) => pokemon.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
  }

  void onSelectType(PokemonTypeEnum type) {
    selectedType.value = type;
    getPokemonList();
  }
}
