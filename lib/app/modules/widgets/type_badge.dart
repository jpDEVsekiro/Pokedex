import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/core/application/theme/palettes.dart';
import 'package:pokedex/app/modules/widgets/text_pokemon.dart';

class TypeBadge extends StatelessWidget {
  const TypeBadge(
      {super.key,
      required this.type,
      this.onTap,
      this.fontSize = 20,
      this.widthText,
      this.isDropDown = false,
      this.center = false});
  final PokemonTypeEnum type;
  final void Function()? onTap;
  final double fontSize;
  final double? widthText;
  final bool isDropDown;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        decoration: BoxDecoration(
          color: type.color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: type == PokemonTypeEnum.allTypes
                ? Palettes.pokemonCardColor
                : type.color,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (type.iconPath != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                margin: const EdgeInsets.only(right: 10),
                height: 27,
                width: 27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300000),
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  type.iconPath ?? '',
                  colorFilter: ColorFilter.mode(type.color, BlendMode.srcIn),
                ),
              ),
            if (center) Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  right: (center && type != PokemonTypeEnum.allTypes) ? 27 : 0),
              child: SizedBox(
                width: widthText,
                child: TextPokemon(
                  text: type.typeName,
                  fontSize: fontSize,
                  color: type == PokemonTypeEnum.allTypes
                      ? Palettes.pokemonCardColor
                      : Colors.white,
                ),
              ),
            ),
            if (center) Spacer(),
            if (isDropDown)
              Icon(
                Icons.arrow_drop_down,
                color: type == PokemonTypeEnum.allTypes
                    ? Palettes.pokemonCardColor
                    : Colors.white,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
