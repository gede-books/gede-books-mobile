import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gede_books/widgets/empty_cart.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


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

class KeranjangPage extends StatefulWidget {
  KeranjangPage({Key? key}) : super(key: key);

  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  Future<List<ShopItem>> _fetchData() async {
    final request = context.watch<CookieRequest>();
    final response = await request.get("https://lidwina-eurora-gedebooks.stndar.dev/api/get_cart_json");

    if (response.statusCode == 200) {
      // Jika respons sukses (kode status 200 OK), parse data JSON
      final List<dynamic> responseData = json.decode(response.body);

      // Ubah data JSON menjadi list ShopItem
      List<ShopItem> items = responseData.map((json) {
        return ShopItem(
          title: json['title'],
          author: json['author'],
          imagePath: json['imagePath'],
          price: json['price'],
          bookCode: json['bookCode'],
        );
      }).toList();

      return items;
    } else {
      // Jika respons tidak sukses, lemparkan exception atau tangani sesuai kebutuhan
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: FutureBuilder<List<ShopItem>>(
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
                final item = snapshot.data![index];
                return ShopCard(item);
              },
            );
          }
        },
      ),
    );
  }
}



class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Tambahkan widget Image untuk menampilkan gambar
            Image.asset(
              'path/to/your/image/${item.imagePath}',  // Ganti dengan path atau URL sesuai kebutuhan
              width: 150,  // Sesuaikan lebar gambar sesuai kebutuhan
              height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan
              fit: BoxFit.cover, // Sesuaikan fit gambar sesuai kebutuhan
            ),
            SizedBox(height: 10), // Tambahkan spasi antara gambar dan teks
            Text(item.title),
            Text(item.author),
            Text("Price: Rp. ${item.price},-"),
            // ... (tambahkan widget atau informasi lainnya sesuai kebutuhan)
          ],
        ),
      ),
    );
  }
}

