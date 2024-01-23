import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/blocs/bloc_provider.dart';
import '../store/index.dart' show Store, SerialDevice;
import '../component/drop_down_select.dart';

import '../blocs/counter_bloc.dart';
import '../store/model/serial_port.dart';

final _userJsonx = [
  {
    "appid": 1234,
    "pages": [
      {
        'page': 0,
        'params': [
          {
            "page": 0,
            "name": "fiedl1",
            "readOnly": false,
            "value": "14",
            "options": null,
            "get": (x) => x[6],
            "set": (x, a) => x[6] = a,
          },
          {
            "page": 0,
            "name": "field2",
            "readOnly": false,
            "value": "14",
            "options": {"t1": 1, "t2": 2},
            "get": (x) => x[7],
            "set": (x, a) => x[6] = a,
          },
          {
            "page": 0,
            "name": "field3",
            "readOnly": false,
            "value": "14",
            "options": null,
            "get": (x) => x[8],
            "set": (x, a) => x[6] = a,
          },
          {
            "page": 0,
            "name": "field4",
            "readOnly": false,
            "value": "14",
            "options": {"t1": 1, "t2": 2,"t3":3},
            "get": (x) => x[8]&0xf,
            "set": (x, a) => x[6] = a,
          }
        ],
      },
      {
        'page': 1,
        'params': [
          {
            'page': 1,
            "name": "field5",
            "readOnly": false,
            "value": "14",
            "options": null,
            "get": (x) => x[6] & 1,
            "set": (x, a) => x[6] = a,
          },
          {
            'page': 1,
            "name": "field6",
            "readOnly": false,
            "value": "14",
            "options": {"t1": 1, "t2": 2},
            "get": (x) => x[6] & 2,
            "set": (x, a) => x[6] = a,
          },
          {
            'page': 1,
            "name": "field7",
            "readOnly": false,
            "value": "14",
            "options": null,
            "get": (x) => x[6] & 4,
            "set": (x, a) => x[6] = a,
          },
          {
            'page': 1,
            "name": "field8",
            "readOnly": false,
            "value": "14",
            "options": {"t1": 1, "t2": 2,"t3":3},
            "get": (x) => x[7] & 0xf,
            "set": (x, a) => x[6] = a,
          }
        ],
      },
    ],
  }, //appid=1234
];

class eightPage extends StatefulWidget {
  @override
  _eightPage createState() => _eightPage();
}

class _eightPage extends State<eightPage> {
  final TextEditingController edController = TextEditingController(
    text: 'abcd',
  );
  final FocusNode focus = FocusNode();
  late SerialDevice mybloc;

  @override
  void initState() {
    super.initState();
  }

  _eightPage();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        SerialDevice(),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('eightPage'),
        ),
        body: _HomeContent(),
      ),
    );
  }
}

Widget eightComSelect(context) {
  return Container(
    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Builder(
            builder: (context) {
              return DropDownSelect(Store.value<SerialDevice>(context).ports[0],
                  Store.value<SerialDevice>(context).ports, (context, str) {
                BlocProvider.of<SerialDevice>(context).first.open(str);
                BlocProvider.of<SerialDevice>(context).first.readData();
              });
            },
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue,
            )),
      ],
    ),
  );
}

class _MyField {
  String name = '';
  bool readOnly = false;
  String value = '';
  Map<String, int>? options = {};
  Function(List)? getfrompackage;
  Function(List, int)? setPackage;
  TextEditingController? controller;
  String? dropDownValue;
 
  void Function(String)? callback;
  int page;

  _MyField(this.page, this.name, this.readOnly, this.value,
      [this.options, this.getfrompackage, this.setPackage]);
  _MyField.fromJson(Map<String, dynamic> srcJson)
      : name = srcJson['name'],
        readOnly = srcJson['readOnly'],
        value = srcJson['value'],
        options = srcJson['options'],
        getfrompackage = srcJson['get'],
        setPackage = srcJson['set'],
        page = srcJson['page'];
}

class _HomeContent extends StatefulWidget {
  // 获取列表的私有方法
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  _HomeContentState();
   List<_MyField> mmLayout = [];
  late List<Widget>  ll = _getData();

   void Function(String)? callback;

   void processPkt(List<int> pkt) {
       int len = mmLayout.length;
       for(int i=0;i<len;i++) {
           if(mmLayout[i].page == pkt[5]) {
             int r = mmLayout[i].getfrompackage!(pkt);
             if(mmLayout[i].options == null) {
                mmLayout[i].controller?.text  = r.toRadixString(16);
             }
             else{
                 
                 mmLayout[i].options!.forEach((key, value) { 
                     if(r == value) mmLayout[i].callback?.call(key);
                 });
             }
             
           }
       }

   }

  @override
  void initState() {
   
    BlocProvider.of<SerialDevice>(context)
        .first
        .sportPacketStream
        .stream
        .listen((pkt) {
          processPkt(pkt);
//        mmLayout[0].controller?.text  = "hhh";
//        mmLayout[1].callback?.call('t2');
    });
    super.initState();
  }

  List<Widget> _getData() {
   
    for (Map<String, dynamic> t1 in _userJsonx) {
      for (Map<String, dynamic> t2 in t1['pages']) {
        for (Map<String, dynamic> t3 in t2['params']) {
          mmLayout.add(_MyField.fromJson(t3));
        }
      }
    }
    Widget l;
    var list = mmLayout.map((obj) {
      if (obj.options == null) {
        TextEditingController _edController = TextEditingController();
        obj.controller = _edController;
        FocusNode _focusNode = FocusNode();
        _focusNode.addListener(() {
          if (!_focusNode.hasFocus) {
            obj.value = _edController.text;
          }
        });
        _edController.text = obj.value;
        l = Container(
          padding: EdgeInsets.all(20),
          height: 100,
          width: 400,
          child: Row(
            children: [
              Text(obj.name + ':'),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _edController,
                  focusNode: _focusNode,
                  readOnly: obj.readOnly,
                  onEditingComplete: () => obj.value = _edController.text,
                ),
              ),
            ],
          ),
        );
      } else {
        print(obj.options!.keys.toList());
        var dropDownValue = obj.dropDownValue??"t1";
        var dpselect = DropDownSelect(dropDownValue,
                    obj.options!.keys.toList(), (context, str) {
                      obj.value = str;
                      obj.dropDownValue = str;
                      print(str);

                    },
                    onUpdate: (onInvoke) => obj.callback = onInvoke);
       
    
        l = Container(
          padding: EdgeInsets.all(20),
          height: 100,
          width: 400,
          child: Row(
            children: [
              Text(obj.name + ':'),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: dpselect,
              )),
            ],
          ),
        );
      }
      return l;
    });

    List<Widget> list1 = list.toList();
    return list1;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        eightComSelect(context),
        Padding(padding: EdgeInsets.all(1)),
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          direction: Axis.horizontal,
          children: ll,
        ),
        Row(children: [
          ElevatedButton(onPressed: ()=>{}, child: Text("Read")),
          Padding(padding: EdgeInsets.all(40)),
          ElevatedButton(onPressed: () => {}, child: Text("Write")),
        ]),
      ],
    );
  }
}

class MyCounter extends StatefulWidget {
  @override
  MyCounterState createState() => MyCounterState();
}

class MyCounterState extends State<MyCounter> {
  int _counter = 0;

  MyCounterState();

  void _inCrement() {
    BlocProvider.of<CounterBloc>(context).first.increament(_counter);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc example"),
      ),
      body: Center(
        child: Text(
          '$_counter',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inCrement,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyCounter1 extends StatefulWidget {
  MyCounter1();
  @override
  MyCounterState1 createState() => MyCounterState1();
}

class MyCounterState1 extends State<MyCounter1> {
  int _counter = 0;

  MyCounterState1();

  void _inCrement() {
    BlocProvider.of<SerialDevice>(context).first.readData();
  }



  @override
  void initState() {
    BlocProvider.of<SerialDevice>(context)
        .first
        .sportPacketStream
        .stream
        .listen((_count) {
      print("receive callback2");
    });

    //   BlocProvider.of<SerialDevice>(context).first.setCallback(myCallback);
    //Store.value<SerialDevice>(context).setCallback(myCallback);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    /*  BlocProvider.of<SerialDevice>(context).first.sportPacketStream.listen((pkt) {  
      print("receive pkt");
    }); */
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc example"),
      ),
      body: Column(
        children: [
          eightComSelect(context),
          Center(
            child: Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inCrement,
        child: Icon(Icons.add),
      ),
    );
  }
}
