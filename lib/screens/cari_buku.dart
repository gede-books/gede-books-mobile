import 'package:flutter/material.dart';
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/screens/detail_buku.dart';
import 'package:gede_books/widgets/left_drawer.dart';
import 'package:gede_books/models/product.dart';

import 'package:http/http.dart' as http;

class Book {
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

  Book(this.title, this.author, this.imagePath, this.price, this.bookCode, this.language, this.year, this.subjects, this.category, this.rating);
}

Future<List<Book>> fetchBooks(String keyword) async {
  final response = await http.get(Uri.parse('https://lidwina-eurora-gedebooks.stndar.dev/json/'));

  if (response.statusCode == 200) {
    List<Product> products = productFromJson(response.body);
    List<Book> books = [];

    for (final product in products) {
      if (product.pk >= 1 && product.pk <= 100 &&
          product.fields.title.toLowerCase().contains(keyword.toLowerCase()) &&
          product.pk != 238 && product.pk != 106) {
        final book = Book(
          product.fields.title,
          '${firstNameValues.reverse[product.fields.firstName]} ${lastNameValues.reverse[product.fields.lastName]}',
          'assets/buku/buku${product.pk}.jpg',
          product.fields.price,
          product.fields.bookCode,
          product.fields.language,
          product.fields.year,
          product.fields.subjects,
          product.fields.category,
          product.fields.rating,
        );
        books.add(book);
      }
    }

    return books;
  } else {
    throw Exception('Failed to load books');
  }
}

final TextEditingController searchController = TextEditingController();

class SearchBookPage extends StatefulWidget {
  final String title;

  SearchBookPage({Key? key, required this.title}) : super(key: key);

  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  late Future<List<Book>> allBooks;
  final double bookHeight = 110.0; // Tinggi tetap buku

@override
void initState() {
  super.initState();
  allBooks = fetchBooks(widget.title);
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
                  controller: searchController,
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
            buildBookSection('Kategori buku', allBooks),
          ],
        ),
      ),
    ),
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
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: books.map((book) {
            return InkWell(
              onTap: () {
                // Navigasi ke halaman detail buku saat card buku ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      title: book.title,
                      author: book.author,
                      imagePath: book.imagePath,
                      price: book.price,
                      bookCode: book.bookCode,
                      language: book.language,
                      year: book.year,
                      subjects: book.subjects,
                      category: book.category,
                      rating: book.rating,
                    ),
                  ),
                );
              },
              child: Container(
                width: 170,
                height: 265,
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
                              child: Image.asset(book.imagePath, height: bookHeight),
                            ),
                          ],
                        ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          processAuthor(book.author),
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
                          processTitle(book.title),
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
                          'Rp. ${book.price},-',
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
            )
          );
        }).toList(),
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
    if (words.length > 4) {
      return words.take(4).join(' ') + ' ...';
    }
    return title;
  }

  void _onSearch() {
    String searchQuery = searchController.text.trim();
    if (searchQuery.isNotEmpty) {
      // Clear the search query and trigger a rebuild of the widget
      setState(() {
        searchController.clear();
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchBookPage(title: searchQuery),
        ),
      );
    }
  }
}