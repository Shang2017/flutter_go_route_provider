import 'package:flutter/foundation.dart' show ChangeNotifier;



// ignore: file_names
class  WorkInfo {
  WorkInfo({this.name});
  String? name;
  int count = 0;
}


class WorkModel extends WorkInfo with ChangeNotifier {
  // ignore: prefer_final_fields
  WorkInfo _workInfo = WorkInfo(name: 'work');

  WorkModel();

  // ignore: annotate_overrides
  String? get name => _workInfo.name;

  int get count => _workInfo.count;

  void setName (name) {
    _workInfo.name = name;
    notifyListeners();
  }

  void increment () {
    _workInfo.count = _workInfo.count + 1;
    notifyListeners();
  }

   void decrement () {
    _workInfo.count = _workInfo.count - 1;
    notifyListeners();
  }
}
