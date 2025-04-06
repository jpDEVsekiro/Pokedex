import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/app/core/application/theme/palettes.dart';
import 'package:pokedex/app/modules/widgets/text_pokemon.dart';

class CharacteristicBox extends StatelessWidget {
  const CharacteristicBox(
      {super.key,
      required this.boxTitle,
      required this.boxValue,
      required IconData this.boxIcon,
      this.boxWidth = 150})
      : boxSvgIcon = null;

  const CharacteristicBox.svg(
      {super.key,
      required this.boxTitle,
      required String this.boxSvgIcon,
      required this.boxValue,
      this.boxWidth = 150})
      : boxIcon = null;
  final String boxTitle;
  final String boxValue;
  final IconData? boxIcon;
  final double boxWidth;
  final String? boxSvgIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (boxSvgIcon != null)
                SvgPicture.asset(
                  boxSvgIcon!,
                  colorFilter:
                      ColorFilter.mode(Palettes.grayTextColor, BlendMode.srcIn),
                  height: 16,
                  width: 16,
                )
              else
                Icon(
                  boxIcon,
                  size: 16,
                  color: Palettes.grayTextColor,
                ),
              const SizedBox(width: 4),
              TextPokemon(
                text: boxTitle,
                fontSize: 16,
                color: Palettes.grayTextColor,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Palettes.grayTextColor,
                width: 1,
              ),
            ),
            child: Center(
              child: TextPokemon(
                  text: boxValue, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
