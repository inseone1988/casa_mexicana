import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  Function(int) onTap;

  AppDrawer({this.onTap});
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Text("Casa Mexicana copy center")),
          ListTile(
            leading: Icon(Icons.home,size: 40,),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.book, size : 40),
            title: Text("Soy UNIMEX"),
            onTap: (){
              widget.onTap(1);
            },
          )
        ],
      ),
    );
  }
}

