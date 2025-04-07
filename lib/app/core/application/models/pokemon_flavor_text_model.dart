class PokemonFlavorTextModel {
  final String evolutionChainUrl;
  final String flavorText;

  PokemonFlavorTextModel({
    required this.evolutionChainUrl,
    required this.flavorText,
  });

  String get flavorTextFormatted {
    return flavorText.replaceAll('\n', ' ').replaceAll('\f', ' ').trim();
  }

  factory PokemonFlavorTextModel.fromJson(Map<String, dynamic> json) {
    return PokemonFlavorTextModel(
      evolutionChainUrl: json['evolution_chain']['url'],
      flavorText: (json['flavor_text_entries'] as List).first['flavor_text'],
    );
  }
}
