import 'package:casa_mexicana/api/response.dart';
import 'package:flutter/material.dart';

class OrderDetailView extends StatefulWidget {
  final Order order;

  const OrderDetailView({Key key, this.order}) : super(key: key);

  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de venta ${widget.order.id}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.blue,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.shopping_basket,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Center(
                  child: ListView.builder(
                    itemCount: widget.order.items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.menu_book_sharp),
                        title: Text(widget.order.items != null ? widget.order.items[index].book.title : "ERROR"),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
