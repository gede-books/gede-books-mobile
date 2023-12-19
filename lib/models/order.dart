import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  List<OrderItem> orderItems;

  Order({
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class OrderItem {
  int id;
  String title;
  int price;
  String category;
  double rating;
  String imageUrl;
  bool reviewed;

  OrderItem({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.rating,
    required this.imageUrl,
    required this.reviewed,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        category: json["category"],
        rating: json["rating"],
        imageUrl: json["image_url"],
        reviewed: json["reviewed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "category": category,
        "rating": rating,
        "image_url": imageUrl,
        "reviewed": reviewed,
      };
}
