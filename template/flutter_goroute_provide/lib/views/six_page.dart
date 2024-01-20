import 'dart:convert';

import 'package:flutter/material.dart';
import '../store/index.dart' show Store,SerialDevice;
import '../component/drop_down_select.dart';


class SixPage extends StatelessWidget {
   final TextEditingController edController = TextEditingController(text:'abcd',);
   final FocusNode focus = FocusNode();

  SixPage({super.key});
  @override
  Widget build(BuildContext context) {
    print('five page rebuild');
   
    return Scaffold(
      appBar: AppBar(title: Text('SixPage'),),
      body: HomeContent0x(),
    
      );
   
  }
}


class MyField {
  String name ='';
  bool readOnly = false;
  String value = '';
  List<String>?  options = [];
  Function()? pp;

  MyField(this.name,this.readOnly,this.value,[this.options,this.pp]);
  MyField.fromJson(Map<String,dynamic> srcJson):
    name = srcJson['name'],
    readOnly = srcJson['readOnly'],
    value = srcJson['value'],
    options = srcJson['options']?.toString().split(','),
    pp = srcJson['get'];
   
}



List myLayout = [
  MyField("TextField",false,"14"),
  MyField("SelectDropList",false,"14",['14','15']),

  MyField("SelectDropList",false,"24",['24','25']),
     MyField("TextField",true,"24"),
   MyField("TextField",true,"34"),
  MyField("SelectDropList",false,"34",['34','35']),

];

//can not add , after last line
const String userJson = """[
  {
    "name": "TextField",
    "readOnly":false,
    "value":"14",
    "options":null  
    
  },
  {
    "name": "SelectDropList",
    "readOnly":false,
    "value":"14",
    "options":"14,156"
 
  },
 {
    "name": "TextField",
    "readOnly":false,
    "value":"14",
    "options":null
  
  },
  {
    "name": "SelectDropList",
    "readOnly":false,
    "value":"14",
    "options":"14,156"
  
  }

]""";


 final userJson0x = [
  {
    "name": "TextField",
    "readOnly":false,
    "value":"14",
    "options":null,
    "get": ()=>print("lll"),
  },
  {
    "name": "SelectDropList",
    "readOnly":false,
    "value":"14",
    "options":"14,156",
    "get":()=>print("eee"),
  },
 {
    "name": "TextField",
    "readOnly":false,
    "value":"14",
    "options":null,
    "get":()=>print("mm"),
  },
  {
    "name": "SelectDropList",
    "readOnly":false,
    "value":"14",
    "options":"14,156",
    "get":()=>print("bbb"),
  }

];

class HomeContent0x extends StatelessWidget{
    // 获取列表的私有方法
    List<Widget> _getData(){
         List<MyField> mmLayout=[];
      
        
      
        for(var tt in userJson0x) {
          mmLayout.add(MyField.fromJson(tt));
        }

         if(mmLayout[1].pp != null) mmLayout[0].pp!();
         
     
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
                       child:DropDownSelect(obj.value,obj.options!,(context,str)=>{}),
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
        return Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          direction:Axis.horizontal,
          children:this._getData(),
          );
    }
}


class HomeContent0 extends StatelessWidget{
    // 获取列表的私有方法
    List<Widget> _getData(){
         List<MyField> mmLayout=[];
        
         final ll=json.decode(userJson);
         print(ll);
         print(ll[0]);
         print(ll[0]["options"] == null);
         
        
      
        for(var tt in ll) {
          mmLayout.add(MyField.fromJson(tt));
        }

        print(mmLayout);
         
     
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
                       child:DropDownSelect(obj.value,obj.options!,(context,str)=>{}),
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
        return Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          direction:Axis.horizontal,
          children:this._getData(),
          );
    }
}




class HomeContent1 extends StatelessWidget{
    // 获取列表的私有方法
    List<Widget> _getData(){
         Widget l;
        var list = myLayout.map((obj){         
          if(obj.name == 'TextField') {
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
                       child:DropDownSelect(obj.value,obj.options,(context,str)=>{}),
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
        return Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          direction:Axis.horizontal,
          children:this._getData(),
          );
    }
}


class HomeContent2 extends StatelessWidget{
    // 获取列表的私有方法
    List<Widget> _getData(){
        Widget l;
        var list = myLayout.map((obj){

         
          if(obj.name == 'TextField') {
            l = Row(
              children: [
              Text(obj.name+':'),
                
                Expanded(
                    flex:2,
                  child: TextField(
                    readOnly: obj.readOnly,
                  ),
                

                ),
              ],
            );
          }
          else  {
            l = Row( 
              children: [ 
                 
              Text(obj.name+':'),
                
               
              //  
               Expanded(
                       child:Container(
                       padding: EdgeInsets.only(left:20,right:20),
                       child:DropDownSelect(obj.value,obj.options,(context,str)=>{}),
                       )
                
              
                  ),
                  
                
                        
              
              ],
            );
          }

          return l;
        });
        print(list);
        List list1 = list.toList();
        List<Widget> m = [];
        int len = list1.length;
        for(int i=0;i<len/2;i++)
        {
          l = Row( 
            children: [ 
              SizedBox(
                 width:100,
              ),
              Expanded( 
                child: list1[i*2],
              ),
              SizedBox(
                 width:100,
              ),
              Expanded( 
                child: list1[i*2+1],
              ),
            ],
          );
          m.add(l);


          
        }
        return m;
    }
    @override
    Widget build(BuildContext context) {
        return ListView(
            children:this._getData()
        ); 
    }
}



List listData = [
    {
        "title": 'Candy Shop',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/1.png',
    },
    {
        "title": 'Childhood in a picture',
        "author": 'Google',
        "imageUrl": 'https://www.itying.com/images/flutter/2.png',
    },
    {
        "title": 'Alibaba Shop',
        "author": 'Alibaba',
        "imageUrl": 'https://www.itying.com/images/flutter/3.png',
    },
    {
        "title": 'Candy Shop',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/4.png',
    },
    {
        "title": 'Tornado',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/5.png',
    },
    {
        "title": 'Undo',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/6.png',
    },
    {
        "title": 'white-dragon',
        "author": 'Mohamed Chahin',
        "imageUrl": 'https://www.itying.com/images/flutter/7.png',
    }
];

class HomeContent extends StatelessWidget{
    // 获取列表的私有方法
    List<Widget> _getData(){
        var list = listData.map((obj){
            return ListTile(
                leading: Image.network(obj["imageUrl"]),
                title:Text(obj["title"]),
                subtitle: Text(obj["author"])
            );
        });
        return list.toList();
    }
    @override
    Widget build(BuildContext context) {
        return ListView(
            children:this._getData()
        ); 
    }
}







