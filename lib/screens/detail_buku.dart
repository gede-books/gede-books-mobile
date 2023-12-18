import 'package:flutter/material.dart';
import 'package:gede_books/screens/menu.dart';

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

class _BookDetailPageState extends State<BookDetailPage> {
  bool isCartPressed = false;
  bool isWishListPressed = false;

  @override
  Widget build(BuildContext context) {
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
              // Handle shopping cart action
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
                    /*
                    TODO: Tambahin logic untuk memasukkan ke keranjang disini
                    */
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