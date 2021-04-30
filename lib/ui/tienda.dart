import 'package:casa_mexicana/api/api.dart';
import 'package:casa_mexicana/api/response.dart';
import 'package:casa_mexicana/ui/booklist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tienda extends StatefulWidget {
  @override
  _TiendaState createState() => _TiendaState();
}

class _TiendaState extends State<Tienda> {
  List<Product> products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Expanded(
          child: Center(
              child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BookList();
              }));
            },
            child: Text("Material UNIMEX"),
          )),
          flex: 1,
        ),
        Expanded(
          flex: 9,
          child: GridView.count(
            crossAxisCount: 2,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(products.length, (index) {
              Product p = products[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(p.description),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  _getData() {
    Api.get("sistema.vialogika.com", "products", <String, String>{}, {},
        (Response response) {
      setState(() {
        products = response.payload.user.products;
      });
    });
  }
}
