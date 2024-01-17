import 'package:flutter/material.dart';

class DropDownSelect extends StatefulWidget {
   String dropdownValue = 'one';
   List<String> items;
   final Function(BuildContext,String) onOptionSelected;

   DropDownSelect(this.dropdownValue,this.items,this.onOptionSelected);

   @override
   DropDownSelectState createState() => DropDownSelectState(dropdownValue,items);
}

class DropDownSelectState extends State<DropDownSelect> {

    DropDownSelectState(this.dropdownValue,this.items);

    String dropdownValue = 'One';
    List<String> items;
  


    Widget build(BuildContext context) {
    return Container(
       
    child: Center(
      child: DropdownButton<String>(
    //    isExpanded: true,
        value: dropdownValue,
        onChanged: (newValue) {
          setState(() {
           dropdownValue = newValue!;
           widget.onOptionSelected(context,dropdownValue);
          });
         print(newValue);
        },
        items: items
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ),
    );
  }
}