// ignore: file_names
import 'package:flutter/foundation.dart' show ChangeNotifier;
import '../object/CounterInfo.dart';
export '../object/CounterInfo.dart';

class Counter extends CounterInfo with ChangeNotifier {
  // ignore: prefer_final_fields
  CounterInfo _counterInfo = CounterInfo(count: 0, totalInfo: TotalInfo(total: 2));

  Counter();

  

  // ignore: annotate_overrides
  int? get count => _counterInfo.count;
  // ignore: annotate_overrides
  TotalInfo? get totalInfo => _counterInfo.totalInfo;

  void increment () {
    _counterInfo.count = _counterInfo.count! + 1;
    notifyListeners();
  }

  void decrement () {
   _counterInfo.count = _counterInfo.count! - 1;
    notifyListeners();
  }
}