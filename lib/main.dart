import 'package:billing_app/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home(),
    );
  }
}

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<Product> products = [];

  double getTotalAmount() {
    double total = 0;
    for (var product in products) {
      total += product.price * product.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].name),
                  subtitle: Text(
                      'Price: ${products[index].price.toStringAsFixed(2)}, Quantity: ${products[index].quantity}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Amount: \$${getTotalAmount().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to screen for adding products (scan or manual entry)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          ).then((value) {
            if (value != null) {
              setState(() {
                products.add(value);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Center(
        child: MaterialButton(
        onPressed: () {
            // Simulate adding product, replace with scanning or manual entry logic
            Product product = Product(
              name: 'Product X',
              price: 10.0,
              quantity: 1,
            );
            Navigator.pop(context, product);
          },
          child: Text('Add Product'),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final int quantity;
  Product({required this.name, required this.price, required this.quantity});
}
