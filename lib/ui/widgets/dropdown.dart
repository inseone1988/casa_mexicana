import 'dart:math';

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
  List<DropdownMenuItem<String>> items;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _generateItemList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.values.length > 0) selectedValue = widget.values[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    _generateItemList();
    return DropdownButton<String>(
      items: items,
      value: selectedValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      //disabledHint: Text("Cargando ..."),
      hint: Text(selectedValue != null ? selectedValue : "Selecciona carrera"),
      onChanged: (String value) {
        setState(() {
          selectedValue = value;
        });
        widget.onSelect(value);
      },
    );
  }

  void _generateItemList() {
    items = List.generate(widget.values.length, (index) {
      return DropdownMenuItem<String>(
        child: Text(widget.values[index]),
        value: widget.values[index],
      );
    });
    if(items.length > 0 && selectedValue == null) selectedValue = items[0].value;
  }
}
