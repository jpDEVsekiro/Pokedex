import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/core/application/theme/palettes.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_list_page/pokemon_list_page_controller.dart';
import 'package:pokedex/app/modules/pokemon/widgets/pokemon_card.dart';
import 'package:pokedex/app/modules/pokemon/widgets/pokemon_list_app_bar.dart';

class PokemonListPage extends GetView<PokemonListPageController> {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palettes.backgroundColor,
      body: CustomScrollView(
        slivers: [
          Obx(() => PokemonListAppBar(
                onChanged: controller.onChangedText,
                onSelectType: controller.onSelectType,
                selectedType: controller.selectedType.value,
                searchController: controller.searchController,
                selectedAbility: controller.selectedAbility.value,
                abilityList: controller.pokemonAbilities,
                onSelectAbility: controller.onSelectAbility,
              )),
          Obx(
            () => SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              sliver: SliverGrid.builder(
                itemCount: controller.filterPokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = controller.filterPokemonList[index];
                  return PokemonCard(
                    pokemonPreviewModel: pokemon,
                    onTap: () => controller.onTapPokemonCard(pokemon),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisExtent: 170.0,
                    mainAxisSpacing: 5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
