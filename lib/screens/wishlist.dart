import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gede_books/models/model_wishlist.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'package:gede_books/widgets/empty_wishlist.dart';

class ShopItem {
  final String title;
  final String imagePath;
  final int bookCode;

  ShopItem(
      {required this.title, required this.imagePath, required this.bookCode});
}

Future<List<WishlistItem>> _fetchData() async {
  final response = await http.get(Uri.parse(
      "https://lidwina-eurora-gedebooks.stndar.dev/api/get_wishlist_json/"));

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    List<WishlistItem> wishlistItemList = jsonResponse
        .map((item) => wishlistItemFromJson(json.encode(item)))
        .toList();

    return wishlistItemList;
  } else {
    throw Exception('Failed to load data. Status code: ${response.statusCode}');
  }
}

class WishlistPage extends StatefulWidget {
  WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: FutureBuilder<List<WishlistItem>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return EmptyWishlist();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final wishlistItem = snapshot.data![index];
                return Column(
                  children: wishlistItem.wishlistItems.map((wishlistItemElement) {
                    return ShopCard(wishlistItemElement);
                  }).toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final WishlistItemElement item;

  const ShopCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Tambahkan widget Image untuk menampilkan gambar
            Image.network(
              item.imageUrl, // Ganti dengan path atau URL sesuai kebutuhan
              width: 150,  // Sesuaikan lebar gambar sesuai kebutuhan
              height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan
              fit: BoxFit.cover, // Sesuaikan fit gambar sesuai kebutuhan
            ),
            SizedBox(height: 10), // Tambahkan spasi antara gambar dan teks
            Text(item.title),
            // ... (tambahkan widget atau informasi lainnya sesuai kebutuhan)
          ],
        ),
      ),
    );
  }
}