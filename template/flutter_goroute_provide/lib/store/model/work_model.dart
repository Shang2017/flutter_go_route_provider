import 'package:flutter/foundation.dart' show ChangeNotifier;
import '../object/UserInfo.dart';
export '../object/UserInfo.dart';


// ignore: file_names
class  WorkInfo {
  WorkInfo({this.name});
  String? name;
}

class WorkModel extends WorkInfo with ChangeNotifier {
  // ignore: prefer_final_fields
  WorkInfo _workInfo = WorkInfo(name: '咕噜猫不吃猫粮不吃鱼');

  WorkModel();

  // ignore: annotate_overrides
  String? get name => _workInfo.name;

  void setName (name) {
    _workInfo.name = name;
    notifyListeners();
  }
}
