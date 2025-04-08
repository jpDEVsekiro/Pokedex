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
  List<String> pokemonAbilities = <String>[];
  RxString selectedAbility = 'Habilidades'.obs;

  @override
  onInit() {
    super.onInit();
    getPokemonList();
    getPokemonAbilities();
  }

  void getPokemonList() async {
    searchController.text = '';
    if (selectedType.value != PokemonTypeEnum.allTypes) {
      pokemonList =
          await pokemonListUseCase.getPokemonListByType(selectedType.value);
    } else if (selectedAbility.value != 'Habilidades') {
      pokemonList = await pokemonListUseCase
          .getPokemonListByAbility(selectedAbility.value);
    } else {
      pokemonList = await pokemonListUseCase.getPokemonList();
    }
    onChangedText(null);
  }

  void onTapPokemonCard(PokemonPreviewModel pokemon) async {
    dynamic result = await Get.toNamed('/pokemon_details', arguments: pokemon);
    if (result is PokemonTypeEnum) {
      onSelectType(result);
    } else if (result is String) {
      onSelectAbility(result);
    }
  }

  void onChangedText(String? value) {
    filterPokemonList.value = pokemonList
        .where((pokemon) => pokemon.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
  }

  void onSelectType(PokemonTypeEnum type) {
    selectedAbility.value = 'Habilidades';
    selectedType.value = type;
    getPokemonList();
  }

  void onSelectAbility(String ability) {
    selectedType.value = PokemonTypeEnum.allTypes;
    selectedAbility.value = ability;
    getPokemonList();
  }

  void getPokemonAbilities() async {
    pokemonAbilities = await pokemonListUseCase.getPokemonAbilities();
    pokemonAbilities.insert(0, 'Habilidades');
    selectedAbility.value = pokemonAbilities[0];
  }
}
