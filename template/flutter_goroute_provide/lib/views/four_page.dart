import 'package:flutter/material.dart';
import '../store/index.dart' show Store, Counter, UserModel;


class FourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('second page rebuild');
    return Scaffold(
      appBar: AppBar(title: Text('FourPage'),),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                child: Text('+'),
                onPressed: () {
                    Store.value<Counter>(context).increment();
                },
            ),
          
            Builder(
              builder: (context) {
                print('four page counter widget rebuild');
                return Text(
                  'four page: ${Store.value1<Counter>(context).count}'
                );
              },
            ),
            ElevatedButton(
              child: Text('-'),
              onPressed: () {
                 Store.value<Counter>(context).decrement();
              },
            ),
          ],
        ),
      ),
    );
  }
}