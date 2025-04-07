import 'package:flutter/material.dart';
import 'package:pokedex/app/core/application/theme/pokemon_text_style.dart';

class TextPokemon extends StatelessWidget {
  const TextPokemon(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.maxLines = 1,
      this.fontWeight})
      : onlyStyle = false;

  const TextPokemon.style(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.maxLines = 1,
      this.fontWeight})
      : onlyStyle = true;
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int maxLines;
  final bool onlyStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: PokemonTextStyle.textStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
