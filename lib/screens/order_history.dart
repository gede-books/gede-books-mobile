import 'package:flutter/material.dart';
import 'package:gede_books/widgets/left_drawer.dart';
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}

class OrderHistoryPage extends StatelessWidget {
  OrderHistoryPage({Key? key}) : super(key: key);

  final List<ShopItem> items = [

  ];

  void _onSearch() {
    // Define what happens when the search icon is tapped.
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
          preferredSize: Size.fromHeight(60.0),
          child: Container(
            height: 70.0,
            child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              style: TextStyle(
                fontSize: 14.0, // Smaller font size for the search bar text
              ),
              decoration: InputDecoration(
                hintText: 'Mau cari buku apa hari ini?',
                hintStyle: TextStyle(
                  fontSize: 14.0, // Matching font size for the hint
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.grey[600]),
                  iconSize: 20.0, // Reduced icon size for the search icon
                  onPressed: _onSearch,
          ),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        ),
          ),

        ),
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
    );
  }
}