import 'package:casa_mexicana/api/api.dart';
import 'package:casa_mexicana/api/response.dart';
import 'package:casa_mexicana/ui/panel.dart';
import 'package:casa_mexicana/ui/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnimexView extends StatefulWidget {
  @override
  _UnimexViewState createState() => _UnimexViewState();
}

class _UnimexViewState extends State<UnimexView> {
  bool _validated = false;

  User luser;

  @override
  Widget build(BuildContext context) {
    return content();
  }

  Map<String, TextEditingController> controllers = {
    "username": TextEditingController(),
    "password": TextEditingController()
  };

  Widget content() {
    if(luser != null && _validated){
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context){
          return Panel();
        })
      );
    }
    if (_validated) {
      return Center(
        child: Register(
          onRegistration: (user){
            setState(() {
              luser = user;
            });
          },
        ),
      );
    }
    return Center(
      child: Card(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          child: Column(
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
                if(_validate()){
                  _doValidation();
                }
              }, child: Text("Verificar")),
              Center(
                child: Text(
                    "*Necesitamos tus credenciales para poder validar que eres estudiante de UNIMEX, esta validacion es por unica vez y la aplicacion no guarda tus datos de acceso. Al hacer click en validar damos por entendido que estas de acurdo y aceptas nuestras terminos y condiciones de servicio"),
              )
            ],
          ),
        ),
      ),
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
    await Api.get("sistema.vialogika.com","validate", {}, {"username":controllers["username"].text,"pass" : controllers["password"].text}, (Response r1) =>{
      if(!r1.error){
        setValidated()
      }
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
}
