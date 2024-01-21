
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/index_page.dart';
import '../views/first_page.dart';
import '../views/second_page.dart';
import '../views/settings_page.dart';

import '../views/three_page.dart';
import '../views/four_page.dart';
import '../views/five_page.dart';
import '../views/six_page.dart';
import '../views/seven_page.dart';



typedef TapFunc = void  Function(BuildContext c);

class RouteIndex{
  RouteIndex(this.path, this.named,this.builder,this.leading,this.title,this.onTap);
  String path;
  String named;  
  final GoRouterWidgetBuilder? builder;
  Widget  leading;
  Widget  title;
  final TapFunc onTap;
}

class DetailRoutes {
  // 用于路径路由(声明式路由)的常量, 路径不包含参数
  static const String homePath = '/'; // 根路由
  static const String settingPath = '/settings';
  static const String firstPath = '/first';
  static const String secondPath = '/second';
  static const String thirdPath = '/third';
  static const String fourPath = '/four';
  static const String fivePath = '/five';
  static const String sixPath = '/six';
  static const String sevenPath = '/seven';

  // 用于 命名路由的常量
  static const String homeNamed = 'home_page';
  static const String settingsNamed = 'setting_page';
  static const String firstNamed = 'first_page';
  static const String secondNamed = 'second_page';
  static const String thirdNamed = 'third_page';
  static const String fourNamed = 'four_page';
  static const String fiveNamed = 'five_page';
  static const String sixNamed = 'six_page';
  static const String sevenNamed = 'seven_page';

   static List<RouteIndex> index = [
    RouteIndex(homePath,homeNamed,
              (context, state) => const IndexPage(),
              Icon(Icons.settings_outlined),Text('Setting'), 
              (context) {
                 GoRouter.of(context).push(DetailRoutes.settingPath);
              },),
    RouteIndex(settingPath,settingsNamed,
              (context, state) => const SettingPage(),
              Icon(Icons.settings_outlined),Text('Setting'), 
              (context) {
                GoRouter.of(context).push(DetailRoutes.settingPath);
              },),
    RouteIndex('$firstPath/:id',firstNamed, 
        // GoRouter.of(context).pushNamed(AppRoutes.searchNamed, params: {'query': 'abcd'});
        // GoRouter.of(context).push('${AppRoutes.movieDetailPath}/654321');
        // GoRouter.of(context).go('/movie_detail/654321');
              (context, state) {
                 final id = state.pathParameters ['id']!;
                return FirsDetailPage(id: id);
              },
              Icon(Icons.settings_outlined),Text('First'), 
              (context)  {
              // 命令路由传递参数
              GoRouter.of(context).pushNamed(
                DetailRoutes.firstNamed,
                // params 传递 `/` 隔开的参数
                pathParameters : {'id': '123456'},
              );
              },),
    RouteIndex(secondPath,secondNamed,
        // GoRouter.of(context).pushNamed(AppRoutes.searchNamed, queryParams: {'query': 'abcd'});
        // GoRouter.of(context).push('${AppRoutes.searchPath}?query=flutter');
        // GoRouter.of(context).go('/search?query=flutter');    
            (context, state) {
          // state.queryParams 接收用问号隔开的参数
               final query = state.uri.queryParameters['query'];
               return SecondPage(query: query!);
            },
            Icon(Icons.settings_outlined),Text('Second'), 
            (context) {
              GoRouter.of(context).pushNamed(
                DetailRoutes.secondNamed,
                // queryParams 传递问号隔开的参数
                queryParameters: {'query': 'abcd'},
              );
            },),
      
    RouteIndex(thirdPath,thirdNamed,
            (context, state) => ThirdPage(),
            Icon(Icons.settings_outlined),Text('Three'), 
            (context) {
              GoRouter.of(context).push(DetailRoutes.thirdPath);
            },),
    RouteIndex(fourPath,fourNamed,
            (context, state) => FourPage(),
            Icon(Icons.settings_outlined),Text('Four'), 
            (context){
              GoRouter.of(context).push(DetailRoutes.fourPath);
            },),   


    RouteIndex(fivePath,fiveNamed,
            (context, state) => FivePage(),
            Icon(Icons.settings_outlined),Text('Five'), 
            (context){
              GoRouter.of(context).push(DetailRoutes.fivePath);
            },),   

    RouteIndex(sixPath,sixNamed,
            (context, state) => SixPage(),
            Icon(Icons.settings_outlined),Text('Six'), 
            (context){
              GoRouter.of(context).push(DetailRoutes.sixPath);
            },),               
    RouteIndex(sevenPath,sevenNamed,
            (context, state) => SevenPage(),
            Icon(Icons.settings_outlined),Text('Seven'), 
            (context){
              GoRouter.of(context).push(DetailRoutes.sevenPath);
            },),               
  ];
}