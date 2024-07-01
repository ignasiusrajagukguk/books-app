import 'package:books_app/src/common/constants/routes.dart';
import 'package:books_app/src/common/injection/injector.dart';
import 'package:books_app/src/common/router/jobbox_router.dart';
import 'package:books_app/src/presentation/effects/scrolls.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  configureInjections();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
