// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

class CartItemElement {
    int id;
    String title;
    int quantity;
    int price;
    int totalPrice;
    String imageUrl;

    CartItemElement({
        required this.id,
        required this.title,
        required this.quantity,
        required this.price,
        required this.totalPrice,
        required this.imageUrl,
    });

    factory CartItemElement.fromRawJson(String str) => CartItemElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartItemElement.fromJson(Map<String, dynamic> json) => CartItemElement(
        id: json["id"],
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"],
        totalPrice: json["total_price"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "quantity": quantity,
        "price": price,
        "total_price": totalPrice,
        "image_url": imageUrl,
    };
}
