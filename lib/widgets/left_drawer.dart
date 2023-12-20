import 'package:flutter/material.dart';
import 'package:gede_books/screens/menu.dart';
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/screens/wishlist.dart';
import 'package:gede_books/screens/semua_buku.dart';
import 'package:gede_books/screens/kategori_buku.dart';
import 'package:gede_books/screens/order_history.dart';
import 'package:gede_books/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
          FutureBuilder<String?>(
            future: _getStoredUsername(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  title: Text(
                      'Welcome, ${snapshot.data}!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return Container(); // Handle loading or errors
              }
            },
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
                title: Text(
                  '    Lihat Semua Buku',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Mengatur teks menjadi italic
                    color: Colors.blue[900], // Mengatur warna teks
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllBookPage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('     Adventure'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBookPage(category: 'Adventure'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('     Children'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBookPage(category: 'Children'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('     Harvard Classics'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBookPage(category: 'Harvard Classics'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('     Historical Fiction'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBookPage(category: 'Historical Fiction'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('     Horror'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBookPage(category: 'Horror'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('     Love'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBookPage(category: 'Love'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('     Movie'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBookPage(category: 'Movie'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('     Science Fiction'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBookPage(category: 'Science Fiction'),
                    ),
                  );
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
          if (!request.loggedIn)
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          if (request.loggedIn)
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: Colors.red,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () async {

                final response = await request.logout("https://gedebooks-a07-tk.pbp.cs.ui.ac.id/auth/logout/");
                String message = response["message"];

                if (response['status']) {
                  String uname = response["username"];
                  await _clearStoredUsername();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname."),
                  ));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message"),
                  ));
                }
              },
            ),
        ],
      ),
    );
  }
  Future<void> _clearStoredUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  Future<String?> _getStoredUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}