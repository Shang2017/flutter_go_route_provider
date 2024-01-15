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
        children: List.generate(DetailRoutes.index.length-1, (idx) =>  ListTile(
            leading: DetailRoutes.index[idx+1].leading,
            title: DetailRoutes.index[idx+1].title,
            onTap: () {
              DetailRoutes.index[idx+1].onTap(context);
            },
          )),
    ),
    );
  }
}

 