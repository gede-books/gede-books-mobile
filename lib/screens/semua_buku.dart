import 'package:flutter/material.dart';
import 'package:gede_books/models/product.dart';
import 'package:gede_books/screens/cari_buku.dart';
import 'package:gede_books/screens/detail_buku.dart';
import 'package:gede_books/widgets/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:gede_books/screens/keranjang.dart';
import 'package:gede_books/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<List<Book>> fetchBooks(String category, int page, int booksPerPage) async {
  // URL mungkin perlu diubah untuk mendukung pagination
  final response = await http.get(Uri.parse('https://lidwina-eurora-gedebooks.stndar.dev/json/?page=$page'));

  if (response.statusCode == 200) {
    List<Product> products = productFromJson(response.body);
    List<Book> books = [];
    for (final product in products) {
      if (product.fields.category.contains(category) &&
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

    // Mengambil sejumlah buku sesuai booksPerPage
    int startIndex = (page - 1) * booksPerPage;
    int endIndex = startIndex + booksPerPage;
    return books.sublist(startIndex, endIndex <= books.length ? endIndex : books.length);
  } else {
    throw Exception('Failed to load books');
  }
}

final TextEditingController searchController = TextEditingController();

class AllBookPage extends StatefulWidget {
  AllBookPage({Key? key}) : super(key: key);

  @override
  _AllBookPageState createState() => _AllBookPageState();
}

class _AllBookPageState extends State<AllBookPage> {
  late Future<List<Book>> allBooks;
  int currentPage = 1;
  final int booksPerPage = 10;
  int totalBooks = 100; // Variabel untuk menyimpan total buku
  final double bookHeight = 110.0; // Tinggi tetap buku

  @override
  void initState() {
    super.initState();
    allBooks = fetchBooks("", currentPage, booksPerPage);
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
              buildBookSection('Semua Buku', allBooks),
              buildPageNavigation(),
              buildPageSelection(),
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
          child: Center(
            child: Text(
              'Semua Koleksi Buku',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                height: 280,
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

  Widget buildPageNavigation() {
    int totalPages = (totalBooks / booksPerPage).ceil(); // Menghitung total halaman

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (currentPage > 1) {
              setState(() {
                currentPage--;
                allBooks = fetchBooks("", currentPage, booksPerPage);
              });
            }
          },
        ),
        Text('Halaman $currentPage dari $totalPages'), // Menampilkan informasi halaman
        IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            if (currentPage < totalPages) {
              setState(() {
                currentPage++;
                allBooks = fetchBooks("", currentPage, booksPerPage);
              });
            }
          },
        ),
      ],
    );
  }

Widget buildPageSelection() {
  int totalPages = (totalBooks / booksPerPage).ceil();
  List<Widget> pageList = [];

  // Fungsi untuk membuat tombol halaman
  Widget pageButton(int page) {
    return TextButton(
      onPressed: () => goToPage(page),
      child: Text(
        '$page',
        style: TextStyle(
          fontWeight: currentPage == page ? FontWeight.bold : FontWeight.normal,
          color: currentPage == page ? Colors.blue : Colors.black, // Warna biru jika halaman saat ini
        ),
      ),
    );
  }

  // Fungsi untuk menambahkan pemisah yang lebih kecil
  void addSeparator() {
    pageList.add(SizedBox(width: 1)); // Sesuaikan lebar sesuai kebutuhan
  }

  // Selalu tambahkan halaman 1
  pageList.add(pageButton(1));

  // Tambahkan ellipsis jika perlu di sebelah kanan halaman 1
  if (currentPage > 3) {
    addSeparator();
    pageList.add(Text('...'));
  }

  // Tambahkan halaman saat ini, sebelum, dan sesudah, tetapi tidak termasuk 1 dan terakhir
  if (currentPage > 2 && currentPage < totalPages) {
    addSeparator();
    pageList.add(pageButton(currentPage - 1));
  }
  if (currentPage != 1 && currentPage != totalPages) {
    addSeparator();
    pageList.add(pageButton(currentPage));
  }
  if (currentPage < totalPages - 1 && currentPage > 1) {
    addSeparator();
    pageList.add(pageButton(currentPage + 1));
  }

  // Tambahkan ellipsis jika perlu di sebelah kiri halaman terakhir
  if (currentPage < totalPages - 2) {
    addSeparator();
    pageList.add(Text('...'));
  }

  // Selalu tambahkan halaman terakhir
  if (totalPages > 1) {
    addSeparator();
    pageList.add(pageButton(totalPages));
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: pageList,
  );
}

  void goToPage(int page) {
    setState(() {
      currentPage = page;
      allBooks = fetchBooks("", currentPage, booksPerPage);
    });
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
