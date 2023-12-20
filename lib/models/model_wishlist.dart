// To parse this JSON data, do
//
//     final wishlistItem = wishlistItemFromJson(jsonString);

import 'dart:convert';

WishlistItem wishlistItemFromJson(String str) => WishlistItem.fromJson(json.decode(str));

String wishlistItemToJson(WishlistItem data) => json.encode(data.toJson());

class WishlistItem {
    List<WishlistItemElement> wishlistItems;

    WishlistItem({
        required this.wishlistItems,
    });

    factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
        wishlistItems: List<WishlistItemElement>.from(json["wishlist_items"].map((x) => WishlistItemElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "wishlist_items": List<dynamic>.from(wishlistItems.map((x) => x.toJson())),
    };
}

class WishlistItemElement {
    int id;
    String title;
    String imageUrl;

    WishlistItemElement({
        required this.id,
        required this.title,
        required this.imageUrl,
    });

    factory WishlistItemElement.fromJson(Map<String, dynamic> json) => WishlistItemElement(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_url": imageUrl,
    };
}