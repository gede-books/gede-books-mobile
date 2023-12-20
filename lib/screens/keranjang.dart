import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gede_books/screens/kategori_buku.dart';
import 'package:gede_books/widgets/empty_cart.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:gede_books/models/cart.dart';
import 'package:gede_books/models/product.dart';
import 'package:gede_books/widgets/left_drawer.dart';

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
      drawer: const LeftDrawer(),
      body: FutureBuilder(
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
            List<CartItemElement> cartItemList = snapshot.data!;
            return ListView.builder(
              itemCount: cartItemList.length,
              itemBuilder: (context, index) {
                final cartItem = cartItemList[index];
                return ShopCard(cartItem);
              },
            );
          }
        },
      ),
    );
  }
    Future<List<CartItemElement>> _fetchData() async {
      final request = context.watch<CookieRequest>();
      final response = await request.get("https://lidwina-eurora-gedebooks.stndar.dev/api/get_cart_json/");

      // List<CartItemElement> result = [];
      //   for (var d in response) {
      //     if (d != null) {
      //       result.add(CartItemElement.fromJson(d));
      //     }
      //   }

      // return result;   
      if (response != null) {
        if (response['status'] == 'success') {
          final List<dynamic> jsonResponse = response['data'];
          List<CartItemElement> result = jsonResponse.map((data) => CartItemElement.fromJson(data)).toList();
          return result;
        }  
      } else {
        print('Failed to fetch data. Response is null.');
      }
      return [];
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
            Image.network(
              item.imageUrl,
              width: 150,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(item.title),
            Text("Price: Rp. ${item.price},-"),
          ],
        ),
      ),
    );
  }
}