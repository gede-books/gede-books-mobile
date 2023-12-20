import 'package:flutter/material.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/empty-wishlist.png',
            width: 100,
            height: 100,
          ),
        ),
        SizedBox(height: 8), // Jarak antara gambar dan teks
        const Text(
          "Wishlist Anda masih kosong, nih :(",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}