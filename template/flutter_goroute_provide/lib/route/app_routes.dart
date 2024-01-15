

import 'package:go_router/go_router.dart';

import 'detail_routes.dart';

class RouteIndex{
  RouteIndex(this.path, this.named,this.builder);
  String path;
  String named;
  
  final GoRouterWidgetBuilder? builder;
}

class AppRoutes {
  
 
  static GoRouter router = GoRouter( 
    initialLocation: DetailRoutes.index[0].path,
    routes: List.generate(DetailRoutes.index.length,
        (idx) =>
          GoRoute( 
          name: DetailRoutes.index[idx].named,
          path:DetailRoutes.index[idx].path,
          builder:DetailRoutes.index[idx].builder,
        )),
  );
}



