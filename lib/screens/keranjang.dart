import 'package:flutter/material.dart';
import 'package:gede_books/screens/detail_buku.dart';
import 'package:gede_books/screens/menu.dart';
import 'package:gede_books/widgets/left_drawer.dart';
import 'package:gede_books/widgets/empty_cart.dart';

class ShopItem {
  final String title;
  final String author;
  final String imagePath;
  final int price;
  final int bookCode;

  ShopItem({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.price,
    required this.bookCode,
  });
}

class KeranjangPage extends StatefulWidget {
  KeranjangPage({Key? key}) : super(key: key);

  final List<ShopItem> items = [];

  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
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
      ),
      body: widget.items.isEmpty
          ? EmptyCart()
          : ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return ShopCard(item);
        },
      ),
    );
  }

  // void tambahKeKeranjang(Book book) {
  //   bool isBookInCart = widget.items.any((item) => item.bookCode == book.bookCode);

  //   if (!isBookInCart) {
  //     setState(() {
  //       widget.items.add(ShopItem(
  //         title: book.title,
  //         author: book.author,
  //         imagePath: book.imagePath,
  //         price: book.price,
  //         bookCode: book.bookCode,
  //       ));
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Buku ditambahkan ke keranjang')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Buku sudah ada di keranjang')),
  //     );
  //   }
  // }
}

class KeranjangModel extends ChangeNotifier {
  List<ShopItem> items = [];

  void tambahKeKeranjang(Book book) {
    bool isBookInCart = items.any((item) => item.bookCode == book.bookCode);

    if (!isBookInCart) {
      items.add(ShopItem(
        title: book.title,
        author: book.author,
        imagePath: book.imagePath,
        price: book.price,
        bookCode: book.bookCode,
      ));
      notifyListeners(); // Notify listeners of the change
      print("yes");
    } else {
      // Show a snackbar or handle the case where the book is already in the cart
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Buku sudah ada di keranjang')),
      // );
      print("no");
    }
  }
}


class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Tambahkan widget Image untuk menampilkan gambar
            Image.asset(
              'path/to/your/image/${item.imagePath}',  // Ganti dengan path atau URL sesuai kebutuhan
              width: 150,  // Sesuaikan lebar gambar sesuai kebutuhan
              height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan
              fit: BoxFit.cover, // Sesuaikan fit gambar sesuai kebutuhan
            ),
            SizedBox(height: 10), // Tambahkan spasi antara gambar dan teks
            Text(item.title),
            Text(item.author),
            Text("Price: Rp. ${item.price},-"),
            // ... (tambahkan widget atau informasi lainnya sesuai kebutuhan)
          ],
        ),
      ),
    );
  }
}

