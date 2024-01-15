
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../store/index.dart' show Store, Counter, UserModel;
import 'four_page.dart' show FourPage;

// ignore: must_be_immutable
class ThirdPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('first page rebuild');
    return Scaffold(
      appBar: AppBar(title: Text('Third'),),
      body: Center(
        child: Column(
          children: <Widget>[
            Store.connect<Counter>(
              builder: (context, snapshot, child) {
                print('third page counter button+ rebuild');
                return ElevatedButton(
                  child: Text('+'),
                  onPressed: () {
                    snapshot.increment();
                  },
                );
              }
            ),
            Store.connect<Counter>(
              builder: (context, snapshot, child) {
                print('third page counter widget rebuild');
                return Text(
                  '${snapshot.count}'
                );
              }
            ),
            Store.connect<Counter>(
              builder: (context, snapshot, child) {
                print('third page counter button- rebuild');
                return ElevatedButton(
                  child: Text('-'),
                  onPressed: () {
                    snapshot.decrement();
                  },
                );
              }
            ),
            Store.connect<UserModel>(
              builder: (context, snapshot, child) {
                print('third page name Widget rebuild');
                return Text(
                  '${Store.value<UserModel>(context).name}'
                );
              }
            ),
            TextField(
              controller: controller,
            ),
            Store.connect<UserModel>(
              builder: (context, snapshot, child) {
                print('third page name button rebuild');
                return ElevatedButton(
                  child: Text('change name'),
                  onPressed: () {
                    snapshot.setName(controller.text);
                  },
                );
              }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Center(
          child: Icon(Icons.group_work)
        ),
        onPressed: () {
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
              return FourPage();
          }));
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          //   return SecondPage();
          // }));
        },
      ),
    );
  }
}
