import 'package:get/get.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_list_page/pokemon_list_page_controller.dart';

class PokemonListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonListPageController>(() => PokemonListPageController());
  }
}
