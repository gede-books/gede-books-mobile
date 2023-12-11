import 'package:flutter/material.dart';
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/widgets/left_drawer.dart';

class Book {
  final String title;
  final String author;
  final String imagePath;
  final int price;

  Book(this.title, this.author, this.imagePath, this.price);
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final double bookHeight = 50.0; // Tinggi tetap buku

  // Daftar buku untuk kategori 'Featured'
  final List<Book> featuredBooks = [
    Book("The Declaration of Independence of the United States", "Thomas Jefferson", "assets/buku/1-25/buku1.jpg", 300000),
    Book("John F. Kennedy's Inaugural Address", "John F. (John Fitzgerald) Kennedy", "assets/buku/1-25/buku2.jpg", 250000),
    Book("Lincoln's Gettysburg Address Given November 19, 1863 on the battlefield near Gettysburg, Pennsylvania, USA", "Abraham Lincoln", "assets/buku/1-25/buku3.jpg", 175000),
    // Tambahkan lebih banyak buku di sini
  ];

  // Daftar buku untuk kategori 'Adventure Books'
  final List<Book> adventureBooks = [
    Book("The Declaration of Independence of the United States", "Thomas Jefferson", "assets/buku/1-25/buku1.jpg", 300000),
    Book("Alice’s Adventure in Wonderland", "Lewis Carroll", "assets/buku/1-25/buku7.jpg", 175000),
    // Tambahkan lebih banyak buku di sini
  ];

  // Daftar buku untuk kategori 'Children Books'
  final List<Book> childrenBooks = [
    Book("The Declaration of Independence of the United States", "Thomas Jefferson", "assets/buku/1-25/buku1.jpg", 300000),
    Book("Alice’s Adventure in Wonderland", "Lewis Carroll", "assets/buku/1-25/buku7.jpg", 175000),
    // Tambahkan lebih banyak buku di sini
  ];

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KeranjangPage(),
                ),
              );
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
                    fontSize: 14.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Mau cari buku apa hari ini?',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.grey[600]),
                      iconSize: 20.0,
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

      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              _buildSection('Featured', featuredBooks),
              SizedBox(height: 20), // Jarak antar section
              _buildSection('Adventure Books', adventureBooks),
              SizedBox(height: 20), // Jarak antar section
              _buildSection('Children Books', childrenBooks),
            ],
          ),
        ),
      ),
    );
  }

    Widget _buildSection(String sectionTitle, List<Book> books) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Lihat Semua',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                child: Card(
                  margin: EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Wrap(
                      children: <Widget>[
                        Image.asset(books[index].imagePath, height: bookHeight),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                          title: Text(
                            processTitle(books[index].title),
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Text(
                                'Rp. ${books[index].price},-',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String processTitle(String title) {
    var words = title.split(' ');
    if (words.length > 10) {
      return words.take(10).join(' ') + '...';
    }
    return title;
  }

  void _onSearch() {
    // Implementasi pencarian
  }
}