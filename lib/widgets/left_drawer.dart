import 'package:flutter/material.dart';
import 'package:gede_books/screens/menu.dart';
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/screens/wishlist.dart';
import 'package:gede_books/screens/order_history.dart';
import 'package:gede_books/screens/login.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView( // Menggunakan ListView untuk memungkinkan item-itemnya scrollable
        children: <Widget>[
          Container(
            color: Colors.grey[850],
            height: 140,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
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
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Great Educational, Diverse,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '& Entertaining Books',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.shelves),
            title: Text('Kategori'),
            children: <Widget>[
              ListTile(
                title: const Text('     Adventure'),
                onTap: () {
                  // Aksi ketika 'Adventure' dipilih
                },
              ),
              ListTile(
                title: const Text('     Children'),
                onTap: () {
                  // Aksi ketika 'Children' dipilih
                },
              ),
              ListTile(
                title: const Text('     Horror'),
                onTap: () {
                  // Aksi ketika 'Horror' dipilih
                },
              ),
              ListTile(
                title: const Text('     Humorous'),
                onTap: () {
                  // Aksi ketika 'Humorous' dipilih
                },
              ),
              ListTile(
                title: const Text('     Love'),
                onTap: () {
                  // Aksi ketika 'Love' dipilih
                },
              ),
              ListTile(
                title: const Text('     Movie'),
                onTap: () {
                  // Aksi ketika 'Movie' dipilih
                },
              ),
              ListTile(
                title: const Text('     Politics'),
                onTap: () {
                  // Aksi ketika 'Politics' dipilih
                },
              ),
              ListTile(
                title: const Text('     Sci-Fi'),
                onTap: () {
                  // Aksi ketika 'Sci-Fi' dipilih
                },
              ),
              // Tambahkan lebih banyak ListTile di sini untuk kategori lain
            ],
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text('Keranjang Saya'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KeranjangPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books_outlined),
            title: Text('Pesanan Saya'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderHistoryPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('WishList Saya'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Login'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => LoginPage(),
                  ),
              );
            },
          ),
        ],
      ),
    );
  }
}