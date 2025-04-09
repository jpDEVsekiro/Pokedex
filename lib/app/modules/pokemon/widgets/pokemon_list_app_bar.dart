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
      floating: true,
      pinned: false,
      elevation: 0,
      excludeHeaderSemantics: true,
      clipBehavior: Clip.hardEdge,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: SizedBox(),
      ),
      flexibleSpace: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Palettes.pokemonCardColor.withValues(alpha: 0.22),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          decoration: BoxDecoration(
            color: Palettes.backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: TextField(
                  key: Key('search_field'),
                  onChanged: onChanged,
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIconColor: Palettes.grayTextColor,
                    hintText: 'Procurar Pokémon',
                    hintStyle: PokemonTextStyle.textStyle.copyWith(
                        color: Palettes.grayTextColor,
                        fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Palettes.pokemonCardColor, width: 1),
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
                          key: Key('select_type_badge_${selectedType.name}'),
                          fontSize: 14,
                          isDropDown: true,
                          widthText: Get.width / 2 -
                              (selectedType == PokemonTypeEnum.allTypes
                                  ? 70
                                  : 107),
                          type: selectedType,
                          center: selectedType == PokemonTypeEnum.allTypes
                              ? true
                              : false,
                          onTap: () {
                            FocusScope.of(context).unfocus();

                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetBody(
                                    key: Key('select_type_bottom_sheet'),
                                    title: 'Selecione o tipo',
                                    child: Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            PokemonTypeEnum.validTypes.length,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 13),
                                        itemBuilder: (context, index) {
                                          final type =
                                              PokemonTypeEnum.validTypes[index];
                                          return Container(
                                            height: 50,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: TypeBadge(
                                              key: Key(
                                                  'type_badge_${type.name}'),
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
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 13),
                    child: SizedBox(
                        height: 40,
                        width: Get.width / 2 - 13 - 5,
                        child: AbilityBadge(
                          key: Key('select_ability_badge_$selectedAbility'),
                          fontSize: 14,
                          text: selectedAbility,
                          isDropDown: true,
                          onTap: () {
                            FocusScope.of(context).unfocus();

                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetBody(
                                    key: Key('select_ability_bottom_sheet'),
                                    title: 'Selecione a habilidade',
                                    child: Expanded(
                                      child: ListView.builder(
                                        itemCount: abilityList.length,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 13),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 50,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: AbilityBadge(
                                              key: Key(
                                                  'ability_badge_${abilityList[index]}'),
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
            ],
          ),
        ),
      ),
    );
  }
}
