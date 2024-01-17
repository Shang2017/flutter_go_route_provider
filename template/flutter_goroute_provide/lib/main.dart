import 'package:flutter/material.dart';

import 'store/index.dart' show Store;


import 'route/app_routes.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('root build: $context');
    return Store.init(
      context: context,
      child: MaterialApp(
      title: 'Provider',
      theme: ThemeData( 
          brightness:Brightness.light,
          primarySwatch: Colors.red,
          primaryColor:Colors.red,
          
          
        ),
      themeMode: ThemeMode.light,
      darkTheme:ThemeData( 
          brightness:Brightness.dark,
          
        ),   
        home: Builder(
          builder: (context) {
            Store.widgetCtx = context;
            print('widgetCtx: $context');
            return MyRoute();
          },
        ),
      )
    );
  }
}


class MyRoute extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter GoRoute Provider',
          theme: ThemeData( 
          brightness:Brightness.light,
          primarySwatch: Colors.red,
          primaryColor:Colors.red,
          
        ),
        themeMode: ThemeMode.light,
        darkTheme:ThemeData( 
          brightness:Brightness.dark,
          
        ),
   //   routeInformationParser: AppRoutes.router.routeInformationParser,
    // routerDelegate: AppRoutes.router.routerDelegate,
    routerConfig: AppRoutes.router,
    );
  }
}

