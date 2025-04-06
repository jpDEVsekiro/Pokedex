import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/app/core/application/enums/pokemon_type_enum.dart';
import 'package:pokedex/app/modules/widgets/text_pokemon.dart';

class TypeBadge extends StatelessWidget {
  const TypeBadge({super.key, required this.type, this.onTap});
  final PokemonTypeEnum type;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        decoration: BoxDecoration(
          color: type.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
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
            const SizedBox(width: 10),
            TextPokemon(
              text: type.typeName,
              fontSize: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
