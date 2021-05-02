// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.error,
    this.payload,
  });

  bool error;
  Payload payload;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    error: json["error"] == null ? null : json["error"],
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class Payload {
  Payload({
    this.message,
    this.validated,
    this.user,
    this.books,
  });

  String message;
  bool validated;
  User user;
  List<Book> books;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    message: json["message"] == null ? null : json["message"],
    validated: json["validated"] == null ? null : json["validated"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    books: json["books"] == null ? null : List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "validated": validated == null ? null : validated,
    "user": user == null ? null : user.toJson(),
    "books": books == null ? null : List<dynamic>.from(books.map((x) => x.toJson())),
  };
}

class Book {
  Book({
    this.id,
    this.title,
    this.author,
    this.publisher,
    this.edition,
    this.career,
    this.quarter,
    this.status,
    this.blocked,
    this.copies,
    this.item,
  });

  int id;
  String title;
  String author;
  String publisher;
  String edition;
  String career;
  int quarter;
  bool status;
  bool blocked;
  int copies;
  Item item;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    author: json["author"] == null ? null : json["author"],
    publisher: json["publisher"] == null ? null : json["publisher"],
    edition: json["edition"] == null ? null : json["edition"],
    career: json["career"] == null ? null : json["career"],
    quarter: json["quarter"] == null ? null : json["quarter"],
    status: json["status"] == null ? null : json["status"],
    blocked: json["blocked"] == null ? null : json["blocked"],
    copies: json["copies"] == null ? null : json["copies"],
    item: json["item"] == null ? null : Item.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "author": author == null ? null : author,
    "publisher": publisher == null ? null : publisher,
    "edition": edition == null ? null : edition,
    "career": career == null ? null : career,
    "quarter": quarter == null ? null : quarter,
    "status": status == null ? null : status,
    "blocked": blocked == null ? null : blocked,
    "copies": copies == null ? null : copies,
    "item": item == null ? null : item.toJson(),
  };
}

class Item {
  Item({
    this.itemid,
    this.price,
    this.quantity,
    this.product,
  });

  int itemid;
  double price;
  int quantity;
  Product product;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemid: json["itemid"] == null ? null : json["itemid"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    quantity: json["quantity"] == null ? null : json["quantity"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "itemid": itemid == null ? null : itemid,
    "price": price == null ? null : price,
    "quantity": quantity == null ? null : quantity,
    "product": product == null ? null : product.toJson(),
  };
}

class Product {
  Product({
    this.productid,
    this.description,
    this.basePrice,
    this.cost,
    this.code,
    this.sku,
  });

  int productid;
  String description;
  String basePrice;
  String cost;
  String code;
  String sku;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productid: json["productid"] == null ? null : json["productid"],
    description: json["description"] == null ? null : json["description"],
    basePrice: json["basePrice"] == null ? null : json["basePrice"],
    cost: json["cost"] == null ? null : json["cost"],
    code: json["code"] == null ? null : json["code"],
    sku: json["sku"] == null ? null : json["sku"],
  );

  Map<String, dynamic> toJson() => {
    "productid": productid == null ? null : productid,
    "description": description == null ? null : description,
    "basePrice": basePrice == null ? null : basePrice,
    "cost": cost == null ? null : cost,
    "code": code == null ? null : code,
    "sku": sku == null ? null : sku,
  };
}

class User {
  User({
    this.validated,
    this.name,
    this.career,
    this.quarter,
    this.orders,
    this.products,
    this.chat,
  });

  bool validated;
  String name;
  String career;
  String quarter;
  List<Order> orders;
  List<Product> products;
  Chat chat;

  factory User.fromJson(Map<String, dynamic> json) => User(
    validated: json["validated"] == null ? null : json["validated"],
    name: json["name"] == null ? null : json["name"],
    career: json["career"] == null ? null : json["career"],
    quarter: json["quarter"] == null ? null : json["quarter"],
    orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
  );

  Map<String, dynamic> toJson() => {
    "validated": validated == null ? null : validated,
    "name": name == null ? null : name,
    "career": career == null ? null : career,
    "quarter": quarter == null ? null : quarter,
    "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x.toJson())),
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
    "chat": chat == null ? null : chat.toJson(),
  };
}

class Chat {
  Chat({
    this.disabled,
    this.messages,
  });

  bool disabled;
  List<Message> messages;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    disabled: json["disabled"] == null ? null : json["disabled"],
    messages: json["messages"] == null ? null : List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "disabled": disabled == null ? null : disabled,
    "messages": messages == null ? null : List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {
  Message({
    this.messageid,
    this.customerid,
    this.type,
    this.content,
    this.timestamp,
    this.received,
  });

  int messageid;
  int customerid;
  String type;
  String content;
  DateTime timestamp;
  bool received;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    messageid: json["messageid"] == null ? null : json["messageid"],
    customerid: json["customerid"] == null ? null : json["customerid"],
    type: json["type"] == null ? null : json["type"],
    content: json["content"] == null ? null : json["content"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    received: json["received"] == null ? null : json["received"],
  );

  Map<String, dynamic> toJson() => {
    "messageid": messageid == null ? null : messageid,
    "customerid": customerid == null ? null : customerid,
    "type": type == null ? null : type,
    "content": content == null ? null : content,
    "timestamp": timestamp == null ? null : timestamp.toIso8601String(),
    "received": received == null ? null : received,
  };
}

class Order {
  Order({
    this.orderid,
    this.status,
    this.items,
  });

  int orderid;
  String status;
  List<Item> items;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderid: json["orderid"] == null ? null : json["orderid"],
    status: json["status"] == null ? null : json["status"],
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderid": orderid == null ? null : orderid,
    "status": status == null ? null : status,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}
