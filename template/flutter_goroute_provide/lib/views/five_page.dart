import 'package:flutter/material.dart';
import '../store/index.dart' show Store, Counter,WorkModel;


class FivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('five page rebuild');
    return Scaffold(
      appBar: AppBar(title: Text('FivePage'),),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                child: Text('+'),
                onPressed: () {
                    Store.value<WorkModel>(context).increment();
                },
            ),
          
            Builder(
              builder: (context) {
                print('five page counter widget rebuild');
                return Text(
                  'five page: ${Store.value1<WorkModel>(context).count}'
                );
              },
            ),
            ElevatedButton(
              child: Text('-'),
              onPressed: () {
                 Store.value<WorkModel>(context).decrement();
              },
            ),
          ],
        ),
      ),
    );
  }
}