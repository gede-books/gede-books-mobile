import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath),
            Text("Author: $author"),
            Text("Price: Rp. $price,-"),
            // Tambahkan informasi buku lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
