import 'package:casa_mexicana/ui/chat.dart';
import 'package:casa_mexicana/ui/drawer.dart';
import 'package:casa_mexicana/ui/pedidos.dart';
import 'package:casa_mexicana/ui/tienda.dart';
import 'package:flutter/material.dart';

class Panel extends StatefulWidget {
  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.android),
                child: Text("Pedidos"),
              ),
              Tab(
                icon: Icon(Icons.add_shopping_cart),
                child: Text("Tienda"),
              ),
              Tab(
                icon: Icon(Icons.message),
                child: Text("Chat"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [Pedidos(), Tienda(), Chat()],
        ),
      ),
    );
  }
}
