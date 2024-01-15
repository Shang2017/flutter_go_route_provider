import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


import 'CounterModel.dart' ;
export 'CounterModel.dart' ;

import 'UserModel.dart';
export 'UserModel.dart';

import "work_model.dart";
export "work_model.dart";




class ModelProviders {
  ModelProviders(this.context);
  BuildContext context;
  List<SingleChildWidget> rn(){
  List<SingleChildWidget> providers = [
        ChangeNotifierProvider(create: (context) => Counter()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => WorkModel()),
  ];
  return providers;

  }
}



