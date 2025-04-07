import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/core/application/theme/palettes.dart';
import 'package:pokedex/app/core/application/theme/pokemon_text_style.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_list_page/pokemon_list_page_controller.dart';
import 'package:pokedex/app/modules/pokemon/widgets/pokemon_card.dart';

class PokemonListPage extends GetView<PokemonListPageController> {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palettes.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).viewPadding.top + 97,
            floating: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 300,
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: false,
              background: Container(
                color: Palettes.backgroundColor,
              ),
            ),
            titleSpacing: 0,
            title: Container(
              decoration: BoxDecoration(
                color: Palettes.backgroundColor,
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: TextField(
                      onChanged: controller.onChanged,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        fillColor: Colors.white,
                        prefixIconColor: Palettes.grayTextColor,
                        hintText: 'Procurar Pokémon',
                        hintStyle: PokemonTextStyle.textStyle.copyWith(
                            color: Palettes.grayTextColor,
                            fontWeight: FontWeight.w400),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Palettes.grayTextColor, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Palettes.pokemonCardColor, width: 1.8),
                        ),
                        focusColor: Palettes.pokemonCardColor,
                      ),
                      cursorColor: Palettes.pokemonCardColor,
                      style: PokemonTextStyle.textStyle.copyWith(),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, left: 13),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.menu_rounded,
                          ),
                          const SizedBox(width: 5),
                          Text('Sets',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal)),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Palettes.pokemonCardColor,
                  )
                ],
              ),
            ),
          ),
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
