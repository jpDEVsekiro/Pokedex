import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/models/pokemon_model.dart';
import 'package:pokedex/app/core/application/models/pokemon_preview_model.dart';
import 'package:pokedex/app/core/application/use_cases/pokemon_details_use_case.dart';

class PokemonDetailsPageController extends GetxController {
  PokemonPreviewModel pokemonPreviewModel =
      Get.arguments as PokemonPreviewModel;
  final PokemonDetailsUseCase _pokemonDetailsUseCase = PokemonDetailsUseCase();
  Rx<PokemonModel?> pokemonModel = Rx<PokemonModel?>(null);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() async {
    pokemonModel.value =
        await _pokemonDetailsUseCase.getPokemon(pokemonPreviewModel.id);
    final flavorTextModel =
        await _pokemonDetailsUseCase.getFlavorText(pokemonPreviewModel.id);
    if (pokemonModel.value == null) {
      Get.snackbar(
        'Error',
        'Failed to load Pokemon details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      pokemonModel.value!.flavorTextModel = flavorTextModel;
      pokemonModel.refresh();
    }
  }

  void onTapType(PokemonTypeEnum type) {
    Get.back(result: type);
  }

  void onTapAbility(String ability) {
    Get.back(result: ability);
  }

  void goBack() {
    Get.back();
  }
}
