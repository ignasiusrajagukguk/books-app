import 'package:books_app/src/common/constants/routes.dart';
import 'package:books_app/src/common/injection/injector.dart';
import 'package:books_app/src/common/router/jobbox_router.dart';
import 'package:books_app/src/presentation/effects/scrolls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  getIt.registerSingleton<http.Client>(http.Client());
  configureInjections();
  runApp(const BooksApp());
}

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      initialRoute: Routes.homeScreen,
      onGenerateRoute: (settings) => JobBoxRouter.generateRoute(
        settings,
        const BouncingScrollBehavior(),
      ),
    );
  }
}
