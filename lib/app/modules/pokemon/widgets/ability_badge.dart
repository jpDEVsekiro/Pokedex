import 'package:flutter/material.dart';
import 'package:pokedex/app/core/application/theme/palettes.dart';
import 'package:pokedex/app/modules/widgets/text_pokemon.dart';

class AbilityBadge extends StatelessWidget {
  const AbilityBadge(
      {super.key,
      required this.text,
      this.fontSize = 20,
      this.onTap,
      this.isDropDown = false});
  final String text;
  final double fontSize;
  final void Function()? onTap;
  final bool isDropDown;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Palettes.pokemonCardColor, width: 1),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: isDropDown ? 20 : 0),
                child: SizedBox(
                  width: isDropDown ? 90 : null,
                  child: Center(
                    child: TextPokemon(
                      text: text,
                      fontSize: fontSize,
                      color: Palettes.pokemonCardColor,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              if (isDropDown)
                const Icon(
                  Icons.arrow_drop_down,
                  color: Palettes.pokemonCardColor,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
