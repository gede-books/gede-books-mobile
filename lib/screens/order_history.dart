import 'package:flutter/material.dart';
import 'package:gede_books/models/order.dart';
import 'package:gede_books/screens/menu.dart';
import 'package:gede_books/widgets/left_drawer.dart';
import 'package:gede_books/widgets/order_item_card.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class OrderHistoryWidget extends StatefulWidget {
  const OrderHistoryWidget({Key? key}) : super(key: key);

  @override
  OrderHistoryWidgetState createState() {
    return OrderHistoryWidgetState();
  }
}

class OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  void _onSearch() {
    // Define what happens when the search icon is tapped.
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<List<OrderItem>> _fetchData() async {
    final request = context.watch<CookieRequest>();
    var response = await request
        .get('https://gedebooks-a07-tk.pbp.cs.ui.ac.id/purchased_books_ajax/');
    List<OrderItem> listOrderItem = Order.fromJson(response).orderItems;
    setState(() {
      _listOrderItem = listOrderItem;
    });
    return listOrderItem;
  }

  final ScrollController _firstController = ScrollController();
  List<OrderItem> _listOrderItem = [];
  late Future<List<OrderItem>> myFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myFuture = _fetchData();
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listAppointmentNew) {
      setState(() => _listOrderItem = _listAppointmentNew);
    });
  }

  @override
  void initState() {
    super.initState();
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
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
                      fontSize:
                          14.0, // Smaller font size for the search bar text
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
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: Column(children: <Widget>[
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Daftar Pesanan",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder<List<OrderItem>>(
                  future: myFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (_listOrderItem.isEmpty) {
                        return const Text("Kamu belum pernah memesan buku.");
                      } else {
                        return Scrollbar(
                            thumbVisibility: true,
                            controller: _firstController,
                            child: ListView.builder(
                                controller: _firstController,
                                itemCount: _listOrderItem.length,
                                itemBuilder: (context, index) {
                                  return orderItemCard(
                                      _listOrderItem[index], context);
                                }));
                      }
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 100),
                          Text("Sedang mengambil data.."),
                          SizedBox(height: 20),
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator()),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ]),
        ));
  }
}

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 24.0),
      )),
      home: Scaffold(
        body: Container(
          child: const OrderHistoryWidget(),
        ),
      ),
    );
  }
}
