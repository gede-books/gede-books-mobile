// To parse this JSON data, do
//
//     final wishlistItem = wishlistItemFromJson(jsonString);

import 'dart:convert';

WishlistItem cartItemFromJson(String str) => WishlistItem.fromJson(json.decode(str));

String wishlistItemToJson(WishlistItem data) => json.encode(data.toJson());

class WishlistItem {
    List<WishlistItemElement> wishlistItems;
    // int total;

    WishlistItem({
        required this.wishlistItems,
        // required this.total,
    });

    factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
        wishlistItems: List<WishlistItemElement>.from(json["wishlist_items"].map((x) => WishlistItemElement.fromJson(x))),
        // total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "wishlist_items": List<dynamic>.from(wishlistItems.map((x) => x.toJson())),
        // "total": total,
    };
}

class WishlistItemElement {
    int id;
    String title;
    // int quantity;
    // int price;
    // int totalPrice;
    String imageUrl;

    WishlistItemElement({
        required this.id,
        required this.title,
        // required this.quantity,
        // required this.price,
        // required this.totalPrice,
        required this.imageUrl,
    });

    factory WishlistItemElement.fromJson(Map<String, dynamic> json) => WishlistItemElement(
        id: json["id"],
        title: json["title"],
        // quantity: json["quantity"],
        // price: json["price"],
        // totalPrice: json["total_price"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        // "quantity": quantity,
        // "price": price,
        // "total_price": totalPrice,
        "image_url": imageUrl,
    };
}