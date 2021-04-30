import 'package:casa_mexicana/api/response.dart';
import 'package:casa_mexicana/ui/widgets/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  Function(User) onRegistration;


  Register({this.onRegistration});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String car,cuat;

  User _u = User();
  TextEditingController c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: c,
              decoration: InputDecoration(
                labelText: "Nombre",
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: DropDownMenu(
                    values: ["Admnistracion", "Derecho"],
                    onSelect: (value) {
                      car = value;
                      print(value);
                    },
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: DropDownMenu(
                    values: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
                    onSelect: (value) {
                      cuat = value;
                      print(value);
                    },
                  ),
                  flex: 5,
                )
              ],
            ),
            ElevatedButton(
              onPressed: (){
                _u.name = c.text;
                _u.career = car;
                _u.quarter = cuat;
                widget.onRegistration(_u);
              },
              child: Text("Continuar"),
            ),
          ],
        ),
      ),
    );
  }
}
