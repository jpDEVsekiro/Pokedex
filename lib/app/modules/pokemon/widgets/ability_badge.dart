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
            color: Palettes.pokemonCardColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: isDropDown ? 20 : 0),
                child: TextPokemon(
                  text: text,
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              if (isDropDown)
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
