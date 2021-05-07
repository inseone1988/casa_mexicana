import 'dart:convert';

import 'package:casa_mexicana/api/api.dart';
import 'package:casa_mexicana/api/response.dart';
import 'package:casa_mexicana/ui/widgets/dropdown.dart';
import 'package:casa_mexicana/ui/widgets/orderdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  String career = "Administracion";
  int quarter = 1;

  List<Book> books;

  double _total = 0.00;
  double _subtotal = 0.00;

  int copiesTotal = 0;

  double _discount = 0.00;

  Order order;

  bool disableMakeOrder = false;

  List<String> careers = [];

  NumberFormat f = NumberFormat.currency(
      decimalDigits: 2, locale: "es_MX", customPattern: "##0.0#");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material UNIMEX"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: DropDownMenu(
                        values: careers,
                        onSelect: (String value) {
                          career = value;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: DropDownMenu(
                        values: List.generate(10, (index) {
                          return "${(index + 1)}";
                        }),
                        onSelect: (String value) {
                          quarter = int.parse(value);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(icon: Icon(Icons.sync), onPressed: (){
                        _getBooks();
                      }),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: books == null
                    ? Center(child: CircularProgressIndicator())
                    : books.length > 0
                        ? ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (a, b) {
                              Book c = books[b];
                              return ListTile(
                                isThreeLine: true,
                                leading: Icon(Icons.menu_book_outlined),
                                trailing: Text("${c.item.quantity}"),
                                title: Text(c.title != null
                                    ? c.title
                                    : "No hay titulo"),
                                subtitle: Column(
                                  children: [
                                    Text(
                                        "${c.author} - ${c.publisher} - ${c.edition}"),
                                    ButtonBar(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                books.remove(c);
                                                _calculateTotal();
                                              });
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.info,
                                              color: Colors.lightBlueAccent,
                                            ),
                                            onPressed: () {
                                              _showInfo(c);
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                c.item.quantity -= 1;
                                                if (c.item.quantity == 0)
                                                  books.remove(c);
                                                _calculateTotal();
                                              });
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.add_box,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                c.item.quantity += 1;
                                                _calculateTotal();
                                              });
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            })
                        : Center(
                            child: Text("No hay libros en este paquete"),
                          ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Subtotal ",
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text("\$ ${f.format(_subtotal)}"),
                              ),
                            )
                          ],
                        )),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                              "Descuento ",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text("\$ ${f.format(_discount)}"),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                              "Total ",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text("\$ ${f.format(_total)}"),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: books != null &&
                                books.length > 0 &&
                                !disableMakeOrder
                            ? () {
                                _processOrder();
                              }
                            : null,
                        child: Text("Confirmar pedido"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(""),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _calculateTotal() {
    _subtotal = 0;
    _discount = 0;
    _total = 0;
    copiesTotal = 0;
    books.forEach((element) {
      _subtotal +=
          ((element.copies * element.item.quantity) * element.item.price) + 15;
      copiesTotal += (element.copies * element.item.quantity);
    });
    if (copiesTotal > 500) {
      if (copiesTotal < 2000) _discount = (_subtotal * 0.05);
      if (copiesTotal > 2000 && copiesTotal < 5000)
        _discount = (_subtotal * 0.15);
      if (copiesTotal > 5000) _discount = (_subtotal * 0.18);
      if (_discount > 300) _discount = 300;
    }
    print(copiesTotal);
    _total = (_subtotal - _discount);
  }

  void _getBooks() {
    setState(() {
      books=null;
    });
    Api.get(
        "sistema.vialogika.com",
        "books",
        {},
        {"career": career, "quarter": "${quarter}"},
        (Response r) async => {
              setState(() {
                books = r.payload.books;
                books.forEach((element) {
                  element.item = Item(quantity: 1, price: 0.40);
                });
                _calculateTotal();
                print("Loaded books");
              }),
              await Api.get("sistema.vialogika.com", "careers", {}, {}, (Response r) {
                setState(() {
                  careers = r.payload.careers;
                  print("Loaded careers");
                });
              })
            });
  }

  void _showInfo(Book book) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(book.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text("Autor : ${book.author}"),
                      ),
                      ListTile(
                        title: Text("Editorial : ${book.publisher}"),
                      ),
                      ListTile(
                        title: Text("Edicion : ${book.edition}"),
                      ),
                      ListTile(
                        title: Text("Carrera : ${book.career}"),
                      ),
                      ListTile(
                        title: Text("Cuatrimestre : ${book.quarter}"),
                      )
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Sugerir una correccion")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK")),
            ],
          );
        });
  }

  void _processOrder()async {
    FlutterSecureStorage storage = await FlutterSecureStorage();
    User u = User.fromJson(jsonDecode(await storage.read(key: "user")));
    order = Order();
    order.status = "Pendiente de pago";
    order.discount = _discount;
    order.total = _total;
    order.items = [];
    order.description = "$career $quarter";
    order.userId = u.id;
    books.forEach((element) {
      element.item.bookid = element.id;
      order.items.add(element.item);
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return OrderDialog(
            order,
            orderResult: (bool r) {
              //Navigator.of(context).pop();
              setState(() {
                disableMakeOrder = true;
              });
              closeWindow();
            },
          );
        });
  }

  void closeWindow() {
    Navigator.of(context).pop();
  }
}
