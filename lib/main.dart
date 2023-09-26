import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Shirt', price: 20),
    Product(name: 'Pants', price: 30),
    Product(name: 'Blazer', price: 50),
    Product(name: 'Shoes', price: 20),
    Product(name: 'Wrist Watch', price: 10),
    Product(name: 'Cap', price: 5),
    Product(name: 'T-shirt', price: 10),
    Product(name: 'Sneaker', price: 15),
    Product(name: 'Jeans', price: 20),
    Product(name: 'Jacket', price: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(products)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(product: products[index]);
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int quantity = 0;

  Product({required this.name, required this.price});
}

class ProductItem extends StatefulWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.product.name),
      subtitle: Text('\$${widget.product.price.toStringAsFixed(2)}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Counts: ${widget.product.quantity}'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.product.quantity++;
                if (widget.product.quantity == 5) {
                  showCongratulationsDialog(context, widget.product.name);
                }
              });
            },
            child: Text('Buy Now'),
          ),
        ],
      ),
    );
  }

  void showCongratulationsDialog(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 $productName!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage(this.products);

  @override
  Widget build(BuildContext context) {

    Set<String> uniqueProductNames = {};

    for (Product product in products) {
      if (product.quantity > 0) {
        uniqueProductNames.add(product.name);
      }
    }

    int totalUniqueItemsInCart = uniqueProductNames.length;


    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Center(
        child: Text('Total Items in Cart: $totalUniqueItemsInCart'),
      ),
    );
  }
}
