
import 'package:go_router/go_router.dart';

import '../views/index_page.dart';
import '../views/first_page.dart';
import '../views/second_page.dart';
import '../views/settings_page.dart';

import '../views/three_page.dart';
import '../views/four_page.dart';


class RouteIndex{
  RouteIndex(this.path, this.named,this.title);
  String path;
  String named;
  String title;

}

class AppRoutes {
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
    RouteIndex(homePath,homeNamed,'home'),
    RouteIndex(settingPath,settingsNamed,'setting'),
    RouteIndex(firstPath,firstNamed,'setting'),
    RouteIndex(secondPath,secondNamed,'search'),
    
  ];

  static GoRouter router = GoRouter(
    initialLocation: homePath, // 默认路由, 不指定这一荐时，默认路由为 '/'
    routes: [
      GoRoute(
        // 不传递参数的路由项
        name: thirdNamed, // 命名路由
        path: thirdPath, // 路径路由
        builder: (context, state) => ThirdPage(),
      ),
      GoRoute(
        // 不传递参数的路由项
        name: fourNamed, // 命名路由
        path: fourPath, // 路径路由
        builder: (context, state) => FourPage(),
      ),
      GoRoute(
        // 不传递参数的路由项
        name: homeNamed, // 命名路由
        path: homePath, // 路径路由
        builder: (context, state) => const IndexPage(),
      ),
      GoRoute(
        name: settingsNamed,
        path: settingPath,
        builder: (context, state) => const SettingPage(),
      ),
      GoRoute(
        // 传递参数方式1, 参数格式类似URL：/search?query=flutter
        name: secondNamed,
        path: secondPath, // 问号格式的参数，在路径中不需要包含参数信息

        // GoRouter.of(context).pushNamed(AppRoutes.searchNamed, queryParams: {'query': 'abcd'});
        // GoRouter.of(context).push('${AppRoutes.searchPath}?query=flutter');
        // GoRouter.of(context).go('/search?query=flutter');
        builder: (context, state) {
          // state.queryParams 接收用问号隔开的参数
          final query = state.uri.queryParameters['query'];
          return SecondPage(query: query!);
        },
      ),
      GoRoute(
        // 传递参数方式2, 参数格式：/movie_detail/123
        name: firstNamed,
        path: '$firstPath/:id', // 位置格式的参数，参数要包含在路径中

        // GoRouter.of(context).pushNamed(AppRoutes.searchNamed, params: {'query': 'abcd'});
        // GoRouter.of(context).push('${AppRoutes.movieDetailPath}/654321');
        // GoRouter.of(context).go('/movie_detail/654321');
        builder: (context, state) {
          // state.params 接收 `/` 隔开的参数(按位置)
          final id = state.pathParameters ['id']!;
          return FirsDetailPage(id: id);
        },
      ),
    ],
  );
}

