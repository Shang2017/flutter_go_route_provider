import 'package:flutter/material.dart';
import '../store/index.dart' show Store,SerialDevice;
import '../component/drop_down_select.dart';


class FivePage extends StatelessWidget {
   TextEditingController edController = TextEditingController(text:'abcd',);
   FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    print('five page rebuild');
   
    return Scaffold(
      appBar: AppBar(title: Text('FivePage'),),
      body: Container(
        child: Column(
          children: <Widget>[
            comSelect(context),
            //multiTextDisplay(context),
            //multTextField(context,edController,focus),
            listViewDisplay(context),
      
      
          ],
        ),
      ),
    );
  }

  Widget comSelect(context) {
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
                         edController.text = "hhhhhh";
                     });},
                ),
             
                ),
                Expanded(flex:2,child:Container(color:Colors.blue,)),
              ],
            ),
    );
  }

  Widget multiTextDisplay(context) {
    return Container( 
      alignment: Alignment.topLeft,
      width: 800,
      height:400,
      
      decoration: BoxDecoration( 
        
            border: Border.all( 
             
                color: Colors.red,
                width: 1,
              ),
            
            ),
            
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
      
        child:Text( 
         Store.value1<SerialDevice>(context).data,
        
         maxLines: 100,
         softWrap: true,

         style: TextStyle(
             color:Colors.red,
             
         ),
      ),
      ),
    );
  }


   Widget listViewDisplay(context) {
    return Container( 
      alignment: Alignment.topLeft,
      width: 800,
      height:400,
      
      decoration: BoxDecoration( 
        
            border: Border.all( 
             
                color: Colors.red,
                width: 1,
              ),
            
            ),
            
      child: Builder(

            builder:(BuildContext context) {
              int count = Store.value1<SerialDevice>(context).data1.length-1;
              return ListView.builder(
               
                 itemCount: Store.value1<SerialDevice>(context).data1.length,
                 itemBuilder: (context, index) => Text(Store.value1<SerialDevice>(context).data1[count-index].toString()),
        
              );
            },
      ),
          
      );
   
  }

  Widget multTextField(context,contr,foc) {
 

     String _curInput = "";
     return Container(   
      width:800,
      height:400, 
       decoration: BoxDecoration(    
        border: Border.all(
        color:Colors.red,        
        width:1.0,
        ),
       ),
      
      child: TextField( 
      
      controller: contr,
      focusNode: foc,
      maxLines: 3,
      minLines: 1,
      readOnly: true,
      decoration: InputDecoration( 

      ),
     ),
     );
  }
}








