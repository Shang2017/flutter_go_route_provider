import 'package:flutter/material.dart';

class FirsDetailPage extends StatelessWidget {
  const FirsDetailPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: Text('Page ID: $id'),
      ),
    );
  }
}
