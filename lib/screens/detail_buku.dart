import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gede_books/models/product.dart';
import 'package:gede_books/screens/menu.dart';
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookDetailPage extends StatefulWidget {
  // final Book book;
  final String title;
  final String author;
  final String imagePath;
  final int price;
  final int bookCode;
  final Language language;
  final Year year;
  final String subjects;
  final String category;
  double rating = 0.0;
  // final Function(Book) onAddToCart;


  BookDetailPage({
    // required this.book,
    required this.title,
    required this.author,
    required this.imagePath,
    required this.price,
    required this.bookCode,
    required this.language,
    required this.year,
    required this.subjects,
    required this.category,
    required this.rating,
    // required this.onAddToCart,
  });

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool isCartPressed = false;
  bool isWishListPressed = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/GEDE-Books Logo.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 8),
              Text(
                'GEDE-Books',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        elevation: 500,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              if (request.loggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KeranjangPage(),
                  ),
                );
              }
              else if (!request.loggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              }
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5.0),
          child: Container(
            height: 15.0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0), // Margin di sisi halaman
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  widget.title, // Title
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center
                ),
                SizedBox(height: 20), // Space between title and image
                Image.asset(widget.imagePath),
                Text("Author: ${widget.author}"),
                Text("Price: Rp. ${widget.price},-"),
                SizedBox(height: 20), // Space before buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (request.loggedIn) {
                          /*
                          TODO
                          */

                        }
                        else if (!request.loggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                        setState(() {
                          isCartPressed = !isCartPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: isCartPressed ? Colors.blue : Colors.grey[850], // Color change when pressed
                        onPrimary: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text(' Keranjang'),
                        ],
                      ),
                    ),
                    SizedBox(width: 10), // Space between buttons
                    OutlinedButton(
                      onPressed: () {
                        /*
                        TODO: Tambahkan logic untuk memasukkan ke wishlist di sini
                        */
                        setState(() {
                          isWishListPressed = !isWishListPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        primary: isWishListPressed ? Colors.white : Colors.grey[850], // Text color change when pressed
                        backgroundColor: isWishListPressed ? Colors.pink : Colors.white, // Background color change when pressed
                        side: BorderSide(color: isWishListPressed ? Colors.pink : Color.fromARGB(255, 30, 30, 30)), // Border color change when pressed
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border),
                          Text(' Wishlist'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                /*
                TODO: Modifikasi modul review MULAI DARI SINI
                NOTE: Kode sebelum ini sebisa mungkin jangan diubah-ubah karena udah modul orang lain
                */
                Text(
                  "Review", // Tulisan "Review"
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // INI BATAS UNTUK MODUL REVIEW. Jangan merubah atau menghapus kode yang berasa setelah ini, semua modul review ditaruh sebelum kurung kurawal di bawah
              ],
            ),
          ),
        ),
      ),
    );
  }
}
