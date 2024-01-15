import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../route/app_routes.dart';
import '../route/detail_routes.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go Router')),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Three'),
            onTap: () {
              GoRouter.of(context).push(DetailRoutes.thirdPath);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Four'),
            onTap: () {
              GoRouter.of(context).push(DetailRoutes.fourPath);
            },
          ),                    
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Setting'),
            onTap: () {
              GoRouter.of(context).push(DetailRoutes.settingPath);
            },
          ),
          ListTile(
            leading: const Icon(Icons.find_in_page_outlined),
            title: const Text('second_path'),
            onTap: () {
              GoRouter.of(context).push(
                // 实际路径：/search?query=flutter
                '${DetailRoutes.secondPath}?query=flutter',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.find_in_page_outlined),
            title: const Text('second_named'),
            onTap: () {
              GoRouter.of(context).pushNamed(
                DetailRoutes.secondNamed,
                // queryParams 传递问号隔开的参数
                queryParameters: {'query': 'abcd'},
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.details_outlined),
            title: const Text('first_path'),
            onTap: () {
              // 路径传递参数
              GoRouter.of(context).push(
                // 实际路径： /movie_detail/654321
                '${DetailRoutes.firstPath}/654321',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.details_outlined),
            title: const Text('first_named'),
            onTap: () {
              // 命令路由传递参数
              GoRouter.of(context).pushNamed(
                DetailRoutes.firstNamed,
                // params 传递 `/` 隔开的参数
                pathParameters : {'id': '123456'},
              );
            },
          ),
        ],
      ),
    );
  }
}

