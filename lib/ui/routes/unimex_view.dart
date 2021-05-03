import 'dart:convert';

import 'package:casa_mexicana/api/api.dart';
import 'package:casa_mexicana/api/response.dart';
import 'package:casa_mexicana/ui/booklist.dart';
import 'package:casa_mexicana/ui/panel.dart';
import 'package:casa_mexicana/ui/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UnimexView extends StatefulWidget {
  @override
  _UnimexViewState createState() => _UnimexViewState();
}

class _UnimexViewState extends State<UnimexView> {
  bool _validated = false;

  User luser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Map<String, TextEditingController> controllers = {
    "username": TextEditingController(),
    "password": TextEditingController()
  };

  Widget content() {
    if (luser != null && _validated) {
      return Center(
        child: Register(
          onRegistration: (user) {
            setState(() async {
              if (luser != null) {
                user.id = luser.id;
              }
              luser = user;
              final storage = FlutterSecureStorage();
              await storage.write(
                  key: "user", value: jsonEncode(luser.toJson()));
              _saveUser();
              Navigator.pop(context);
            });
          },
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Image(
            width: 150,
            image: AssetImage("assets/OIP.jpg"),
          ),
        ),
        TextField(
          controller: controllers["username"],
          decoration: InputDecoration(
            hintText: "Matricula UNIMEX",
          ),
        ),
        TextField(
          controller: controllers["password"],
          obscureText: true,
          decoration: InputDecoration(hintText: "Contraseña"),
        ),
        ElevatedButton(
            onPressed: () {
              if (_validate()) {
                _doValidation();
              }
            },
            child: Text("Verificar")),
        Center(
          child: Text(
              "*Necesitamos tus credenciales para poder validar que eres estudiante de UNIMEX, esta validacion es por unica vez y la aplicacion no guarda tus datos de acceso. Al hacer click en validar damos por entendido que estas de acurdo y aceptas nuestras terminos y condiciones de servicio"),
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllers.forEach((key, value) {
      value.dispose();
    });
  }

  Future<void> _doValidation() async {
    //String url = "https://sistema.vialogika.com/validate?username=${}&pass=${}";
    await Api.get(
        "sistema.vialogika.com",
        "validate",
        {},
        {
          "username": controllers["username"].text,
          "pass": controllers["password"].text
        },
        (Response r1) => {
              if (!r1.error) {setValidated(), luser = r1.payload.user}
            });
  }

  setValidated() {
    setState(() {
      _validated = true;
    });
  }

  bool _validate() {
    return true;
  }

  void _saveUser() async {
    Api.post("sistema.vialogika.com", "user",
        headers: {
          "Content-Type": "application/json",
        },
        requestBody: jsonEncode(luser), callback: (Response r) {
      if (!r.error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Usuario guardado correctamente")));
      }
    });
  }
}
