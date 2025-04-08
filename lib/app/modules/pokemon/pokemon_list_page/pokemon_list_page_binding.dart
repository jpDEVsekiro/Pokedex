import 'package:get/get.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/domain/repositories/i_repository.dart';
import 'package:pokedex/app/core/infrastructure/adapters/dio/dio_adapter.dart';
import 'package:pokedex/app/core/infrastructure/repositories/hive_repository.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_list_page/pokemon_list_page_controller.dart';

class PokemonListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IHttpClientAdapter>(DioAdapter());
    Get.put<IRepository>(HiveRepository());
    Get.lazyPut<PokemonListPageController>(() => PokemonListPageController());
  }
}
