import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_db/ui/screens/connection_error.dart';
import 'package:flutter_movie_db/ui/screens/movie.dart';
import 'package:flutter_movie_db/ui/theme/theme_data.dart';
import 'package:flutter_movie_db/data/services/connection_service.dart';
import 'package:flutter_movie_db/data/services/imdb_service.dart';
import 'package:flutter_movie_db/ui/screens/home.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  String initialRoute = '/home';

  final bool isConnected = await Get.find<ConnectionService>().isConnected();

  if (!isConnected) {
    initialRoute = '/connection_error';
  }

  runApp(
    GetMaterialApp(
        title: 'Flutter App',
        theme: themeData,
        initialRoute: initialRoute,
        getPages: [
          GetPage(
            name: '/home',
            page: () => const HomeScreen(),
          ),
          GetPage(
            name: '/movie',
            page: () => MovieScreen(),
          ),
          GetPage(
            name: '/connection_error',
            page: () => const ConnectionErrorScreen(),
          ),
        ],
    ),
  );
}

Future<void> initServices() async {
  Get.lazyPut(() => ConnectionService());
  Get.lazyPut(() => ImdbService());
}
