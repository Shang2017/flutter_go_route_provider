
import 'package:go_router/go_router.dart';

import '../views/index_page.dart';
import '../views/first_page.dart';
import '../views/second_page.dart';
import '../views/settings_page.dart';

import '../views/three_page.dart';
import '../views/four_page.dart';


class RouteIndex{
  RouteIndex(this.path, this.named,this.builder);
  String path;
  String named;  
  final GoRouterWidgetBuilder? builder;
}

class DetailRoutes {
  // 用于路径路由(声明式路由)的常量, 路径不包含参数
  static const String homePath = '/'; // 根路由
  static const String settingPath = '/settings';
  static const String firstPath = '/first';
  static const String secondPath = '/second';
  static const String thirdPath = '/third';
  static const String fourPath = '/four';

  // 用于 命名路由的常量
  static const String homeNamed = 'home_page';
  static const String settingsNamed = 'setting_page';
  static const String firstNamed = 'first_page';
  static const String secondNamed = 'second_page';
  static const String thirdNamed = 'third_page';
  static const String fourNamed = 'four_page';

   static List<RouteIndex> index = [
    RouteIndex(homePath,homeNamed,(context, state) => const IndexPage()),
    RouteIndex(settingPath,settingsNamed,(context, state) => const SettingPage()),
    RouteIndex('$firstPath/:id',firstNamed, 
        // GoRouter.of(context).pushNamed(AppRoutes.searchNamed, params: {'query': 'abcd'});
        // GoRouter.of(context).push('${AppRoutes.movieDetailPath}/654321');
        // GoRouter.of(context).go('/movie_detail/654321');
        (context, state) {
          final id = state.pathParameters ['id']!;
          return FirsDetailPage(id: id);
        }),
    RouteIndex(secondPath,secondNamed,
        // GoRouter.of(context).pushNamed(AppRoutes.searchNamed, queryParams: {'query': 'abcd'});
        // GoRouter.of(context).push('${AppRoutes.searchPath}?query=flutter');
        // GoRouter.of(context).go('/search?query=flutter');    
      (context, state) {
          // state.queryParams 接收用问号隔开的参数
          final query = state.uri.queryParameters['query'];
          return SecondPage(query: query!);
        }
      ),
    RouteIndex(thirdPath,thirdNamed,(context, state) => ThirdPage()),
    RouteIndex(fourPath,fourNamed,(context, state) => FourPage()),   
  ];
}