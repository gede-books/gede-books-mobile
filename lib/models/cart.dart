// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

CartItem cartItemFromJson(String str) => CartItem.fromJson(json.decode(str));

String cartItemToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
    List<CartItemElement> cartItems;
    int total;

    CartItem({
        required this.cartItems,
        required this.total,
    });

    factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cartItems: List<CartItemElement>.from(json["cart_items"].map((x) => CartItemElement.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
        "total": total,
    };
}

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
