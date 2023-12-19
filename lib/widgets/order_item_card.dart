import 'package:flutter/material.dart';
import 'package:gede_books/models/order.dart';
import 'package:gede_books/screens/menu.dart';
import 'package:gede_books/screens/tinggalkan_review.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

Widget orderItemCard(orderItem, BuildContext context) {
  return Card(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${orderItem.imageUrl}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderItem.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Price: Rp. ${orderItem.price}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Category: ${orderItem.category}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(width: 4.0),
                          Text(
                            '${orderItem.rating}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      if (!orderItem.reviewed)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TinggalkanReviewPage(orderItem.id)),
                                );
                              },
                              child: Text('Tinggalkan Review'),
                            ),
                          ],
                        )
                    ]),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
