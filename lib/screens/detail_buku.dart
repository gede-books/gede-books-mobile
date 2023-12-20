
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
import 'dart:convert' as convert;
import 'package:gede_books/models/cart.dart';
import 'package:gede_books/models/model_wishlist.dart';

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

  BookDetailPage({
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
  });

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

  Future<bool> _getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

class _BookDetailPageState extends State<BookDetailPage> {
  bool isCartPressed = false;
  bool isWishListPressed = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _getLoginStatus();
  }

  Future<void> _getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

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
              } else if (!request.loggedIn) {
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
          padding:
              EdgeInsets.symmetric(horizontal: 10.0), // Margin di sisi halaman
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(widget.title, // Title
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                SizedBox(height: 15), // Space between title and image
                Image.asset(
                  widget.imagePath,
                  height: 400,
                ),
                SizedBox(height: 5),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.author}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20, // Adjust the font size here
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Rp. ${widget.price},-",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bahasa",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                              width:
                                  8), // Add some space between "Bahasa" and the language name
                          Text(
                            "${widget.language.toString().split('.').last}", // Extract the language name from the enum
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Kategori:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        widget.category == " "
                            ? "Tidak ada informasi kategori"
                            : widget.category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: widget.category == " "
                              ? FontStyle.italic
                              : FontStyle.normal,
                          color: widget.category == " "
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Space before buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (isLoggedIn) {
                          // TODO pass data add to cart
                          // endpoint: "https://lidwina-eurora-gedebooks.stndar.dev/add_to_cart/${widget.bookCode}"
                          final response = await request.postJson(
                            "https://lidwina-eurora-gedebooks.stndar.dev/add_to_cart/${widget.bookCode}/",
                            convert.jsonEncode(<String, String>{
                              "id": widget.bookCode.toString(),
                              "title": widget.title,
                              "quantity": "1",
                              "price": widget.price.toString(),
                              "total_price": widget.price.toString(),
                              "image_url": widget.imagePath,
                            })
                          );

                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Buku berhasil ditambahkan!"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Gagal menambahkan buku ke dalam keranjang."),
                            ));
                          }
                        }
                        else if (!isLoggedIn) {
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
                        primary: isCartPressed
                            ? Colors.blue
                            : Colors.grey[850], // Color change when pressed
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
                      onPressed: () async {
                        /*
                        TODO: Tambahkan logic untuk memasukkan ke wishlist di sini
                        */
                        if (isLoggedIn) {
                          // TODO pass data add to wishlist
                          // endpoint: "https://lidwina-eurora-gedebooks.stndar.dev/add_to_wishlist/${widget.bookCode}"
                          final response = await request.postJson(
                            "https://lidwina-eurora-gedebooks.stndar.dev/add_to_wishlist/${widget.bookCode}/",
                            convert.jsonEncode(<String, String>{
                              "id": widget.bookCode.toString(),
                              "title": widget.title,
                              "image_url": widget.imagePath,
                            })
                          );

                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Buku berhasil ditambahkan ke wishlist! ^v^"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Gagal menambahkan buku ke dalam wishlist! :("),
                            ));
                          }
                        }
                        else if (!isLoggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                        setState(() {
                          isWishListPressed = !isWishListPressed;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        primary: isWishListPressed
                            ? Colors.white
                            : Colors
                                .grey[850], // Text color change when pressed
                        backgroundColor: isWishListPressed
                            ? Colors.pink
                            : Colors
                                .white, // Background color change when pressed
                        side: BorderSide(
                            color: isWishListPressed
                                ? Colors.pink
                                : Color.fromARGB(255, 30, 30,
                                    30)), // Border color change when pressed
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
