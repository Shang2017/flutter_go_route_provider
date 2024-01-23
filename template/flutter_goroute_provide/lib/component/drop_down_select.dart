import 'package:flutter/material.dart';

class DropDownSelect extends StatefulWidget {
  String dropdownValue = 'one';
  List<String> items;
  final Function(BuildContext, String) onOptionSelected;

  final Function(void Function(String) onInvoke)? onUpdate;

  DropDownSelect(this.dropdownValue, this.items, this.onOptionSelected,
      {Key? key, this.onUpdate})
      : super(key: key);

  @override
  DropDownSelectState createState() =>
      DropDownSelectState(dropdownValue, items);
}

class DropDownSelectState extends State<DropDownSelect> {
  DropDownSelectState(this.dropdownValue, this.items);

  String dropdownValue = 'One';
  List<String> items;

  @override
  void initState() {
    print("init dropdown");
    widget.onUpdate?.call((str) {
      print('onUpdate');

      setState(() {
        dropdownValue = str;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            maxWidth: double.infinity,
          ),
          child: DropdownButton<String>(
            //    isExpanded: true,
            value: dropdownValue,
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue!;
                widget.onOptionSelected(context, dropdownValue);
              });
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
