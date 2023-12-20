import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Menyusun child secara vertikal di tengah
      children: [
        Center(
          child: Image.asset(
            'assets/images/empty-cart.png',
            width: 100,
            height: 100,
          ),
        ),
        SizedBox(height: 8), // Jarak antara gambar dan teks
        const Text(
          "Keranjang Anda masih kosong :(",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
