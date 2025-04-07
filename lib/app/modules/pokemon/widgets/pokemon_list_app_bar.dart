import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/theme/palettes.dart';
import 'package:pokedex/app/core/application/theme/pokemon_text_style.dart';
import 'package:pokedex/app/modules/pokemon/widgets/ability_badge.dart';
import 'package:pokedex/app/modules/pokemon/widgets/bottom_sheet_body.dart';
import 'package:pokedex/app/modules/widgets/type_badge.dart';

class PokemonListAppBar extends StatelessWidget {
  const PokemonListAppBar(
      {super.key,
      this.onChanged,
      this.onSelectType,
      required this.searchController,
      required this.selectedType,
      required this.selectedAbility,
      required this.abilityList,
      this.onSelectAbility});

  final void Function(String)? onChanged;
  final void Function(PokemonTypeEnum)? onSelectType;
  final void Function(String)? onSelectAbility;
  final TextEditingController searchController;
  final PokemonTypeEnum selectedType;
  final String selectedAbility;
  final List<String> abilityList;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: MediaQuery.of(context).viewPadding.top + 150,
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
                onChanged: onChanged,
                controller: searchController,
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
                    borderSide:
                        BorderSide(color: Palettes.grayTextColor, width: 1.5),
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 10),
                  child: SizedBox(
                      height: 40,
                      width: Get.width / 2 - 13 - 5,
                      child: TypeBadge(
                        fontSize: 14,
                        isDropDown: true,
                        widthText: Get.width / 2 -
                            (selectedType == PokemonTypeEnum.allTypes
                                ? 76
                                : 105),
                        type: selectedType,
                        center: selectedType == PokemonTypeEnum.allTypes
                            ? true
                            : false,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return BottomSheetBody(
                                  title: 'Selecione o tipo',
                                  child: Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          PokemonTypeEnum.validTypes.length,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 13),
                                      itemBuilder: (context, index) {
                                        final type =
                                            PokemonTypeEnum.validTypes[index];
                                        return Container(
                                          height: 50,
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: TypeBadge(
                                            type: type,
                                            center: true,
                                            onTap: () {
                                              Get.back();
                                              onSelectType?.call(type);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 13),
                  child: SizedBox(
                      height: 40,
                      width: Get.width / 2 - 13 - 5,
                      child: AbilityBadge(
                        fontSize: 14,
                        text: selectedAbility,
                        isDropDown: true,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return BottomSheetBody(
                                  title: 'Selecione a habilidade',
                                  child: Expanded(
                                    child: ListView.builder(
                                      itemCount: abilityList.length,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 13),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 50,
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: AbilityBadge(
                                            text: abilityList[index],
                                            onTap: () {
                                              Get.back();
                                              onSelectAbility
                                                  ?.call(abilityList[index]);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                      )),
                ),
              ],
            ),
            Divider(
              color: Palettes.pokemonCardColor,
            )
          ],
        ),
      ),
    );
  }
}
