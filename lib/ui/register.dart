import 'package:casa_mexicana/ui/widgets/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Nombre",
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: DropDownMenu(
                      values: ["Admnistracion","Derecho"],
                      onSelect: (value){
                        print(value);
                      },
                    ),
                  flex: 5,
                ),
                Expanded(
                    child: Text("Row 2"),
                  flex: 5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
