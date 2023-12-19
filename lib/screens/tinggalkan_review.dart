import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gede_books/screens/menu.dart';
import 'package:gede_books/screens/order_history.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class TinggalkanReviewWidget extends StatefulWidget {
  final int id;

  TinggalkanReviewWidget({Key? key, required this.id}) : super(key: key);

  @override
  _TinggalkanReviewWidgetState createState() =>
      _TinggalkanReviewWidgetState(id);
}

class _TinggalkanReviewWidgetState extends State<TinggalkanReviewWidget> {
  double _rating = 0.0;
  TextEditingController _commentController = TextEditingController();

  final int id;

  _TinggalkanReviewWidgetState(this.id);

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
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
                    fontSize: 14.0, // Smaller font size for the search bar text
                  ),
                  decoration: InputDecoration(
                    hintText: 'Mau cari buku apa hari ini?',
                    hintStyle: TextStyle(
                      fontSize: 14.0, // Matching font size for the hint
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.grey[600]),
                      iconSize: 20.0, // Reduced icon size for the search icon
                      onPressed: _onSearch,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            RatingBar(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                setState(() {
                  _rating = newRating;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Komentar:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _commentController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan Komentar',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final request = context.read<CookieRequest>();
                var response = await request.post(
                    'https://gedebooks-a07-tk.pbp.cs.ui.ac.id/tinggalkan_review_flutter/$id',
                    jsonEncode({
                      'rating': _rating,
                      'review': _commentController.text
                    }));
                if (response == 'Success') {
                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Berhasil'),
                      content: Text('Berhasil menambahkan review!'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderHistoryPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(content: Text("Gagal menambahkan review.")));
                }
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearch() {}
}

class RatingBar extends StatelessWidget {
  final double initialRating;
  final int itemCount;
  final ValueChanged<double> onRatingUpdate;
  final bool allowHalfRating;
  final Axis direction;
  final EdgeInsets itemPadding;
  final int minRating;

  RatingBar(
      {required this.initialRating,
      required this.itemCount,
      required this.onRatingUpdate,
      this.allowHalfRating = false,
      this.direction = Axis.horizontal,
      this.itemPadding = const EdgeInsets.all(0.0),
      this.minRating = 1,
      required Icon Function(dynamic context, dynamic _) itemBuilder});

  @override
  Widget build(BuildContext context) {
    return direction == Axis.horizontal
        ? Row(
            children: buildRatingBar(),
          )
        : Column(
            children: buildRatingBar(),
          );
  }

  List<Widget> buildRatingBar() {
    List<Widget> widgets = [];
    for (int i = 0; i < itemCount; i++) {
      widgets.add(
        GestureDetector(
          onTap: () => onRatingUpdate(allowHalfRating ? i + 0.5 : i + 1.0),
          child: Padding(
            padding: itemPadding,
            child: Icon(
              i < initialRating.floor()
                  ? Icons.star
                  : (allowHalfRating && i + 0.5 == initialRating)
                      ? Icons.star_half
                      : Icons.star_border,
              size: 40.0,
              color: Colors.amber,
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}

class TinggalkanReviewPage extends StatelessWidget {
  final int id;

  const TinggalkanReviewPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 24.0),
      )),
      home: Scaffold(
        body: Container(
          child: TinggalkanReviewWidget(id: id),
        ),
      ),
    );
  }
}
