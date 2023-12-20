import 'package:flutter/material.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset('assets/images/empty-wishlist.png'),
          ),
        ),
        const Text(
          "Wishlist Anda masih kosong, nih! :(",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )
      ],
    );
  }
}