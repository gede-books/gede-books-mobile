import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gede_books/screens/kategori_buku.dart';
import 'package:gede_books/widgets/empty_cart.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:gede_books/models/cart.dart';
import 'package:gede_books/models/product.dart';



class ShopItem {
  final String title;
  final String author;
  final String imagePath;
  final int price;
  final int bookCode;

  ShopItem({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.price,
    required this.bookCode,
  });
}

Future<List<CartItem>> _fetchData() async {
  final response = await http.get(Uri.parse("https://lidwina-eurora-gedebooks.stndar.dev/api/get_cart_json/"));

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    List<CartItem> cartItemList = jsonResponse.map((item) => cartItemFromJson(json.encode(item))).toList();

    return cartItemList;
  } else {
    throw Exception('Failed to load data. Status code: ${response.statusCode}');
  }
}

class KeranjangPage extends StatefulWidget {
  KeranjangPage({Key? key}) : super(key: key);

  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: FutureBuilder<List<CartItem>>(
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
            return EmptyCart();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final cartItem = snapshot.data![index];
                return Column(
                  children: cartItem.cartItems.map((cartItemElement) {
                    return ShopCard(cartItemElement);
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
  final CartItemElement item;

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
            Text("Price: Rp. ${item.price},-"),
            // ... (tambahkan widget atau informasi lainnya sesuai kebutuhan)
          ],
        ),
      ),
    );
  }
}