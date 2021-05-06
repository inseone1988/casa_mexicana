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
    this.order,
    this.careers,
  });

  String message;
  bool validated;
  User user;
  List<Book> books;
  Order order;
  List<String> careers;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    message: json["message"] == null ? null : json["message"],
    validated: json["validated"] == null ? null : json["validated"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    books: json["books"] == null ? null : List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    careers: json["careers"] == null ? null : List<String>.from(json["careers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "validated": validated == null ? null : validated,
    "user": user == null ? null : user.toJson(),
    "books": books == null ? null : List<dynamic>.from(books.map((x) => x.toJson())),
    "order": order == null ? null : order.toJson(),
    "careers": careers == null ? null : List<dynamic>.from(careers.map((x) => x)),
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
    this.id,
    this.price,
    this.quantity,
    this.product,
    this.bookid,
  });

  int id;
  double price;
  int quantity;
  Product product;
  int bookid;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"] == null ? null : json["id"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    quantity: json["quantity"] == null ? null : json["quantity"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    bookid: json["bookid"] == null ? null : json["bookid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "price": price == null ? null : price,
    "quantity": quantity == null ? null : quantity,
    "product": product == null ? null : product.toJson(),
    "bookid": bookid == null ? null : bookid,
  };
}

class Product {
  Product({
    this.id,
    this.description,
    this.basePrice,
    this.cost,
    this.code,
    this.sku,
  });

  int id;
  String description;
  String basePrice;
  String cost;
  String code;
  String sku;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] == null ? null : json["id"],
    description: json["description"] == null ? null : json["description"],
    basePrice: json["basePrice"] == null ? null : json["basePrice"],
    cost: json["cost"] == null ? null : json["cost"],
    code: json["code"] == null ? null : json["code"],
    sku: json["sku"] == null ? null : json["sku"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "description": description == null ? null : description,
    "basePrice": basePrice == null ? null : basePrice,
    "cost": cost == null ? null : cost,
    "code": code == null ? null : code,
    "sku": sku == null ? null : sku,
  };
}

class Order {
  Order({
    this.id,
    this.status,
    this.discount,
    this.total,
    this.description,
    this.items,
  });

  int id;
  String status;
  double discount;
  double total;
  String description;
  List<Item> items;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    discount: json["discount"] == null ? null : json["discount"].toDouble(),
    total: json["total"] == null ? null : json["total"].toDouble(),
    description: json["description"] == null ? null : json["description"],
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "discount": discount == null ? null : discount,
    "total": total == null ? null : total,
    "description": description == null ? null : description,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.validated,
    this.name,
    this.career,
    this.quarter,
    this.orders,
    this.products,
    this.chat,
  });

  int id;
  bool validated;
  String name;
  String career;
  String quarter;
  List<Order> orders;
  List<Product> products;
  Chat chat;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    validated: json["validated"] == null ? null : json["validated"],
    name: json["name"] == null ? null : json["name"],
    career: json["career"] == null ? null : json["career"],
    quarter: json["quarter"] == null ? null : json["quarter"],
    orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
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
    this.id,
    this.customerid,
    this.type,
    this.content,
    this.timestamp,
    this.received,
  });

  int id;
  int customerid;
  String type;
  String content;
  DateTime timestamp;
  bool received;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"] == null ? null : json["id"],
    customerid: json["customerid"] == null ? null : json["customerid"],
    type: json["type"] == null ? null : json["type"],
    content: json["content"] == null ? null : json["content"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    received: json["received"] == null ? null : json["received"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "customerid": customerid == null ? null : customerid,
    "type": type == null ? null : type,
    "content": content == null ? null : content,
    "timestamp": timestamp == null ? null : timestamp.toIso8601String(),
    "received": received == null ? null : received,
  };
}
