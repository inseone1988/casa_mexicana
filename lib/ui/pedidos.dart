import 'dart:convert';

import 'package:casa_mexicana/api/api.dart';
import 'package:casa_mexicana/api/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Pedidos extends StatefulWidget {
  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {

  List<Order> orders;

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  void _getOrders() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    User u = await User.fromJson(jsonDecode(await storage.read(key: "user")));
    Api.get("sistema.vialogika.com", "order/user", {}, {"id": "${u.id}"}, (
        Response response) {
      setState(() {
        orders = response.payload.user.orders;
        _loading = false;
      });
    });
  }

  Widget _content() {
    return orders == null && _loading ? Center(child: CircularProgressIndicator()) : Container(
      child: orders == null || orders.length == 0 ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("No hay pedidos aun :("),
            Text("Ve todo lo que tenemos que ofrecerte en la tienda")
          ],
        ),
      ) : ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context,index){
        Order o = orders[index];
        return Card(
          child: ListTile(
            title: Text(o.description),
          ),
        );
      }),
    );
  }
}
