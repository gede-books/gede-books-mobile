import 'package:flutter/material.dart';
import 'package:gede_books/screens/menu.dart';
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookDetailPage extends StatefulWidget {
  final String title;
  final String author;
  final String imagePath;
  final int price;

  BookDetailPage({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.price,
  });

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

Future<void> tambahKeKeranjang({
  required String title,
  required String author,
  required String imagePath,
  required int price,
  required BuildContext context,
}) async {
  final url = 'https://lidwina-eurora-gedebooks.stndar.dev/add_to_cart/';
  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'title': title,
        'author': author,
        'imagePath': imagePath,
        'price': price.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Successful response, handle accordingly
      print('Book added to cart successfully.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Book added to cart successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Handle other errors
      print('Failed to add book to cart.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add book to cart.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } catch (error) {
    // Handle other errors, e.g., network issues
    print('Error: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // Title
            SizedBox(height: 20), // Space between title and image
            Image.asset(widget.imagePath),
            Text("Author: ${widget.author}"),
            Text("Price: Rp. ${widget.price},-"),
            SizedBox(height: 20), // Space before buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (request.loggedIn) {
                      tambahKeKeranjang(
                        title: widget.title,
                        author: widget.author,
                        imagePath: widget.imagePath,
                        price: widget.price,
                        context: context,
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
                    TODO: Tambahin logic untuk memasukkan ke wishlist disini
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
          ],
        ),
      ),
    );
  }
}