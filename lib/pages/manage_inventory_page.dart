import 'package:brother_app/db/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageInventoryPage extends StatefulWidget {
  @override
  _ManageInventoryPageState createState() => _ManageInventoryPageState();
}

class _ManageInventoryPageState extends State<ManageInventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Manage Inventory!",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder(
            future: Provider.of<MyDatabase>(context, listen: false)
                .getAllProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductData> products = snapshot.data as List<ProductData>;
                return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (_, index) => Container(
                          child: Text(products[index].name),
                        ));
              } else if (snapshot.hasError) {
                throw Exception(snapshot.error);
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
