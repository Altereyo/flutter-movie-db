import 'package:flutter/material.dart';
import 'package:flutter_movie_db/ui/theme/theme_data.dart';
import 'package:flutter_movie_db/data/services/connection_service.dart';
import 'package:flutter_movie_db/data/services/imdb_service.dart';
import 'package:flutter_movie_db/ui/screens/home.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(
    GetMaterialApp(
        title: 'Flutter App',
        theme: themeData,
        home: const HomeScreen(),
        onReady: () => Get.find<ConnectionService>().initConnectionListener(),
    ),
  );
}

Future<void> initServices() async {
  Get.lazyPut(() => ConnectionService());
  Get.lazyPut(() => ImdbService());
}
