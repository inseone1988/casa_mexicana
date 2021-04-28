import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  List<String> values;
  Function(String) onSelect;

  DropDownMenu({this.values, this.onSelect});

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String selectedValue;
  List<DropdownMenuItem> items;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.values.length > 0) selectedValue = widget.values[0];
      _generateItemList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: items,
      value: selectedValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      onChanged: (String value) {
        print(value);
        selectedValue = value;
        widget.onSelect(value);
      },
    );
  }

  void _generateItemList() {
    items = List.generate(widget.values.length, (index) {
      return DropdownMenuItem(
        child: Text(widget.values[index]),
      );
    });
  }
}
