import 'package:flutter/material.dart';
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/screens/detail_buku.dart';
import 'package:gede_books/widgets/left_drawer.dart';
import 'package:gede_books/models/product.dart'; // Pastikan path ini benar

import 'package:http/http.dart' as http;
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Book {
  final String title;
  final String author;
  final String imagePath;
  final int price;

  Book(this.title, this.author, this.imagePath, this.price);
}

Future<List<Book>> fetchBooks(String category) async {
  final response = await http.get(Uri.parse('https://gedebooks-a07-tk.pbp.cs.ui.ac.id/json/'));

  if (response.statusCode == 200) {
    List<Product> products = productFromJson(response.body);
    List<Book> books = [];
    int booksTaken = 0; // Menghitung jumlah buku yang sudah diambil

    for (final product in products) {
      if (booksTaken >= 5) {
        break; // Jika sudah mengambil 100 buku, keluar dari loop
      }

      if (product.fields.category.contains(category) &&
          product.pk != 238 && product.pk != 106) {
        final book = Book(
          product.fields.title,
          '${firstNameValues.reverse[product.fields.firstName]} ${lastNameValues.reverse[product.fields.lastName]}',
          'assets/buku/buku${product.pk}.jpg',
          product.fields.price,
        );
        books.add(book);
        booksTaken++;
      }
    }

    return books;
  } else {
    throw Exception('Failed to load books');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Book>> featuredBooks;
  late Future<List<Book>> adventureBooks;
  late Future<List<Book>> childrenBooks;
  late Future<List<Book>> movieBooks;
  late Future<List<Book>> historicalFiction;
  late Future<List<Book>> scienceFiction;
  final double bookHeight = 110.0; // Tinggi tetap buku

  @override
  void initState() {
    super.initState();
    featuredBooks = fetchBooks('Best');
    adventureBooks = fetchBooks('Adventure');
    childrenBooks = fetchBooks('Children');
    movieBooks = fetchBooks('Movie');
    historicalFiction = fetchBooks('Historical');
    scienceFiction = fetchBooks('Sci');
  }

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
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            buildFeaturedBookSection('Featured Books', featuredBooks),
            SizedBox(height: 20),
            buildBookSection('Adventure Books', adventureBooks),
            SizedBox(height: 20),
            buildBookSection('Children Books', childrenBooks),
            SizedBox(height: 20),
            buildBookSection('Movie Books', movieBooks),
            SizedBox(height: 20),
            buildBookSection('Historical Fiction', historicalFiction),
            SizedBox(height: 20),
            buildBookSection('Science Fiction', scienceFiction),
          ],
        ),
      ),
    ),
  );
}

Widget buildFeaturedBookSection(String sectionTitle, Future<List<Book>> booksFuture) {
  return FutureBuilder<List<Book>>(
    future: booksFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text("Error: ${snapshot.error}");
      } else if (snapshot.hasData) {
        return _buildSectionFeatured(sectionTitle, snapshot.data!);
      } else {
        return Text("No data available");
      }
    },
  );
}

Widget buildBookSection(String sectionTitle, Future<List<Book>> booksFuture) {
  return FutureBuilder<List<Book>>(
    future: booksFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text("Error: ${snapshot.error}");
      } else if (snapshot.hasData) {
        return _buildSection(sectionTitle, snapshot.data!);
      } else {
        return Text("No data available");
      }
    },
  );
}

Widget _buildSectionFeatured(String sectionTitle, List<Book> books) {
  return Container(
    color: Color.fromARGB(255, 45, 94, 167),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  sectionTitle,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Tambahkan aksi yang ingin diambil saat tombol "Lihat Semua" ditekan
                    },
                    child: Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 265,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Tambahkan navigasi ke halaman detail buku di sini
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(
                        title: books[index].title,
                        author: books[index].author,
                        imagePath: books[index].imagePath,
                        price: books[index].price,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  child: Card(
                    margin: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: bookHeight,
                                color: Colors.grey,
                              ),
                              Center(
                                child: Image.asset(
                                  books[index].imagePath,
                                  height: bookHeight,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              processAuthor(books[index].author),
                              style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 54, 51, 51),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              processTitle(books[index].title),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Rp. ${books[index].price},-',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                sectionTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0.0),
              child: TextButton(
                onPressed: () {
                  // Tambahkan aksi yang ingin diambil saat tombol "Lihat Semua" ditekan
                },
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 265, // Tinggi container disesuaikan dengan kebutuhan
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Tambahkan navigasi ke halaman detail buku di sini
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      title: books[index].title,
                      author: books[index].author,
                      imagePath: books[index].imagePath,
                      price: books[index].price,
                    ),
                  ),
                );
              },
              child: Container(
                width: 150,
                child: Card(
                  margin: EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: bookHeight,
                              color: const Color.fromARGB(255, 65, 65, 65),
                            ),
                            Center(
                              child: Image.asset(
                                books[index].imagePath,
                                height: bookHeight,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            processAuthor(books[index].author),
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 54, 51, 51),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            processTitle(books[index].title),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Rp. ${books[index].price},-',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
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
      return words.take(10).join(' ') + ' ...';
    }
    return title;
  }

  String processAuthor(String title) {
    var words = title.split(' ');
    if (words.length > 3) {
      return words.take(3).join(' ') + ' ...';
    }
    return title;
  }

  void _onSearch() {
    // Implementasi pencarian
  }
}