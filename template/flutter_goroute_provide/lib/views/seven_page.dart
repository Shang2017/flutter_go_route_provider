import 'dart:convert';

import 'package:flutter/material.dart';
import '../store/index.dart' show Store,SerialDevice;
import '../component/drop_down_select.dart';

import '../blocs/counter_bloc.dart';




final _userJsonx = [
  {
    "appid":1234,
    
    "pages":
    [
        { 'page':    0,

          
          'params':  
           [
              {
                "page":0,
                "name": "fiedl1",
                "readOnly":false,
                "value":"14",
                "options":null,
                "get": (x)=>x[6],
                "set": (x,a)=>x[6]=a,
              },
              {
                "page":0,
                "name": "field2",
                "readOnly":false,
                "value":"14",
                "options":{"t1":1,"t2":2},
                "get":(x)=>x[7],
                "set": (x,a)=>x[6]=a,
              },
              {
                "page":0,
                "name": "field3",
                "readOnly":false,
                "value":"14",
                "options":null,
                "get":(x)=>x[8],
                "set": (x,a)=>x[6]=a,
              },
              {
                "page":0,
                "name": "field4",
                "readOnly":false,
                "value":"14",
                "options":{"t1":1,"t2":2},
                "get":(x)=>x[6]+x[7],
                "set": (x,a)=>x[6]=a,
              }            

           ],

        },
        { 'page':    1,
          'params':  
           [
              {
                'page':    1,
                "name": "field5",
                "readOnly":false,
                "value":"14",
                "options":null,
                "get": (x)=>x[6]&1,
                "set": (x,a)=>x[6]=a,
              },
              {
                'page':    1,
                "name": "field6",
                "readOnly":false,
                "value":"14",
                "options":{"t1":1,"t2":2},
                "get":(x)=>x[6]&2,
                "set": (x,a)=>x[6]=a,
              },
              {
                'page':    1,
                "name": "field7",
                "readOnly":false,
                "value":"14",
                "options":null,
                "get":(x)=>x[6]&4,
                "set": (x,a)=>x[6]=a,
              },
              {
                'page':    1,
                "name": "field8",
                "readOnly":false,
                "value":"14",
                "options":{"t1":1,"t2":2},
                "get":(x)=>x[7]&0xf,
                "set": (x,a)=>x[6]=a,
              }            

           ],

        },      
  
    ],
  },//appid=1234

];

 Widget sevenComSelect(context) {
    return  Container(            
            padding: EdgeInsets.all(20),
            child:  Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Builder(
                    builder: (context){
                    print('dropdownButton');
                    return DropDownSelect(Store.value<SerialDevice>(context).ports[0],Store.value<SerialDevice>(context).ports,
                     (context,str){
                         Store.value<SerialDevice>(context).open(str);
                         Store.value<SerialDevice>(context).readData();
                         
                     });},
                ),
             
                ),
                Expanded(flex:2,child:Container(color:Colors.blue,)),
              ],
            ),
    );
  }


class SevenPage extends StatelessWidget {
   final TextEditingController edController = TextEditingController(text:'abcd',);
   final FocusNode focus = FocusNode();

  SevenPage({super.key});
  @override
  Widget build(BuildContext context) {
    print('five page rebuild');
   
    return MyCounter();
    /* Scaffold(
      appBar: AppBar(title: Text('SevenPage'),),
      body: _HomeContent(),
    
      );
    */
  }
}


class _MyField {
  String name ='';
  bool readOnly = false;
  String value = '';
  Map<String,int>?  options = {};
  Function(List)? getfrompackage;
  Function(List,int)? setPackage;
  int page;

  _MyField(this.page,this.name,this.readOnly,this.value,[this.options,this.getfrompackage,this.setPackage]);
  _MyField.fromJson(Map<String,dynamic> srcJson):
    name = srcJson['name'],
    readOnly = srcJson['readOnly'],
    value = srcJson['value'],
    options = srcJson['options'],
    getfrompackage = srcJson['get'],
    setPackage = srcJson['set'],
    page = srcJson['page'];
}

 
class _HomeContent extends StatelessWidget{
    // 获取列表的私有方法
    List<Widget> _getData(){
         List<_MyField> mmLayout=[];

         for(Map<String,dynamic> t1 in _userJsonx) {
          for(Map<String,dynamic> t2 in t1['pages']) {
            for(Map<String,dynamic> t3 in t2['params']){
                 mmLayout.add(_MyField.fromJson(t3));
            }
          }
         }        
         Widget l;
        var list = mmLayout.map((obj){    
          
          if(obj.options == null) {
            TextEditingController _edController = TextEditingController();
            FocusNode _focusNode = FocusNode();
            _focusNode.addListener((){
              if(!_focusNode.hasFocus) {
                 obj.value = _edController.text;
                 print("lose focus");
              }
            });
            _edController.text = obj.value;
            l = Container( 
              padding: EdgeInsets.all(20),
              height:100,
              width:400,
              child:Row(
              children: [
              Text(obj.name+':'),
                
                Expanded(
                    flex:2,
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
          }
          else  {
            print(obj.options!.keys.toList());
            l = Container( 
              padding: EdgeInsets.all(20),
              height:100,
              width:400,
              child:Row( 
              children: [ 
                 
              Text(obj.name+':'),
                
               
              //  
               Expanded(
                       child:Container(
                       padding: EdgeInsets.only(left:20,right:20),
                       child:DropDownSelect(obj.options!.keys.toList()[0],obj.options!.keys.toList(),(context,str)=>{}),
                       )
                
              
                  ),
                  
                
                        
              
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
        sevenComSelect(context),
        Padding(padding: EdgeInsets.all(1)),
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          direction:Axis.horizontal,
          children:this._getData(),
          ),
        Row(
           children:[
            ElevatedButton(onPressed: ()=>{}, child: Text("Read")),  
            Padding(padding: EdgeInsets.all(40)),
            ElevatedButton(onPressed: ()=>{}, child: Text("Write")),      
            ]
        ),
          ],
        );

    }
}

class MyCounter extends StatefulWidget{
  @override
  MyCounterState createState() => MyCounterState();
}

class MyCounterState extends State<MyCounter> {
  int _counter = 0;
  final CounterBloc bloc = CounterBloc();

  MyCounterState();

  void _inCrement() {
    bloc.increament(_counter);
  }

  @override
  void initState() {
    
    bloc.counterStream.listen((_count) {
      setState(() {
        _counter = _count;
      });

    });
    bloc.readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text("Bloc example"),
      ),
      body:Center( 
        child: Text( 
          '$_counter',
          style:Theme.of(context).textTheme.displayLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton( 
        onPressed: _inCrement,
        child:Icon(Icons.add),
      ),
    );
  }

}