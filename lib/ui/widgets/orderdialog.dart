import 'dart:convert';

import 'package:casa_mexicana/api/api.dart';
import 'package:casa_mexicana/api/response.dart';
import 'package:flutter/material.dart';

class OrderDialog extends StatefulWidget {
  Order order;

  Function(bool) orderResult;

  @override
  _OrderDialogState createState() => _OrderDialogState();

  OrderDialog(this.order, {this.orderResult});
}

class _OrderDialogState extends State<OrderDialog> {
  String _title = "Realizando pedido";
  bool _sendingInfo = true;

  int orderId;

  bool error = false;
  String message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: _sendingInfo
          ? Center(child: CircularProgressIndicator())
          : error
              ? Center(
                  child: Text(
                  message,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ))
              : Text(
                  "El pedido se realizo con exito folio : $orderId.\nPuedes reportar tu pago desde la pestaña pedidos."),
      actions: [
        TextButton(
            onPressed: _sendingInfo
                ? null
                : () {
                    Navigator.pop(context);
                    if(widget.orderResult != null)widget.orderResult(true);
                  },
            child: Text("OK"))
      ],
    );
  }

  void doRequest() {
    Api.post("sistema.vialogika.com", "order",
        headers: {"Content-Type": "application/json"},
        requestBody: jsonEncode(widget.order.toJson()),
        callback: (Response response) {
      error = response.error;
      setState(() {
        _sendingInfo = false;
        if (response.error) {
          message = response.payload.message;
          _title = "Error";
        }
        _title = "Pedido exitoso";
        orderId = response.payload.order.id;
      });
    });
  }
}
