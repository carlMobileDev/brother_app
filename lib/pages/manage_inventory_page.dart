import 'package:brother_app/widgets/catalog_gridview.dart';
import 'package:flutter/material.dart';

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
        body: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16, 8, 0),
            child: CatalogGridview(
                // onClick: (ProductData p) {
                //   printBarcodeData(p.id.toString());
                //   print("Item clicked!");
                // },
                )));
  }
}
