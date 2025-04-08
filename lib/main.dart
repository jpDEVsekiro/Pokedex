import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/domain/repositories/i_repository.dart';
import 'package:pokedex/app/core/infrastructure/adapters/dio/dio_adapter.dart';
import 'package:pokedex/app/core/infrastructure/repositories/hive_repository.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_list_page/pokemon_list_page.dart';
import 'package:pokedex/app/modules/pokemon/pokemon_list_page/pokemon_list_page_binding.dart';
import 'package:pokedex/app/modules/pokemon_details/pokemon_details_page/pokemon_details_page.dart';
import 'package:pokedex/app/modules/pokemon_details/pokemon_details_page/pokemon_details_page_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await init();
  runApp(GetMaterialApp(
      title: 'Pokedéx',
      theme: ThemeData(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      initialBinding: PokemonListPageBinding(),
      getPages: [
        GetPage(
          name: '/',
          binding: PokemonListPageBinding(),
          page: () => PokemonListPage(),
        ),
        GetPage(
          name: '/pokemon_details',
          binding: PokemonDetailsPageBinding(),
          page: () => PokemonDetailsPage(),
        ),
      ]));
}

init() async {
  Get.put<IRepository>(HiveRepository());
  await Get.find<IRepository>().init();
  await Get.find<IRepository>().deleteAll();
  Get.put<IHttpClientAdapter>(DioAdapter());
}
