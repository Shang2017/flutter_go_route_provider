import 'package:flutter/material.dart';

import 'route/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter GoRoute Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
   //   routeInformationParser: AppRoutes.router.routeInformationParser,
    // routerDelegate: AppRoutes.router.routerDelegate,
    routerConfig: AppRoutes.router,
    );
  }
}
