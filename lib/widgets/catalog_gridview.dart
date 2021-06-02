import 'dart:async';
import 'dart:convert';

import 'package:brother_app/db/db.dart';
import 'package:brother_app/util/print_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CatalogGridview extends StatefulWidget {
  const CatalogGridview({
    Key? key,
  }) : super(key: key);

  @override
  _CatalogGridviewState createState() => _CatalogGridviewState();
}

class _CatalogGridviewState extends State<CatalogGridview> {
  Map<int, Image> cachedImages = {};
  List<ProductData> selectedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<List<ProductData>> _loadProducts() async {
    List<ProductData> allProducts =
        await Provider.of<MyDatabase>(context, listen: false).getAllProducts();
    for (ProductData product in allProducts) {
      if (!cachedImages.containsKey(product.id))
        cachedImages.putIfAbsent(
            product.id, () => Image.memory(base64Decode(product.image)));
    }
    return allProducts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductData> allProducts = snapshot.data as List<ProductData>;
            return StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                itemCount: allProducts.length,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                itemBuilder: (_, index) => _inventoryCard(allProducts[index]));
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _inventoryCard(ProductData data) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green[200],
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(8.0), child: cachedImages[data.id]!),
            Text(data.name),
            Text("Price: ${data.price}"),
            Text("Amount: ${data.inventoryAmount}"),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => PrintAlertDialog(
            productId: data.id,
            productName: data.name,
            productPrice: data.price!,
          ),
          barrierDismissible: true,
        );
        //printBarcodeData(data.id.toString());
        print("Item clicked!");
      },
    );
  }
}

class PrintAlertDialog extends StatelessWidget {
  final int productId;
  final String productName;
  final double productPrice;
  const PrintAlertDialog(
      {Key? key,
      required this.productId,
      required this.productName,
      required this.productPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Print?"),
        content: Text("How many barcodes would you like to print?"),
        actions: [
          TextButton(
              onPressed: () {
                printBarcodeData(
                    productId.toString(), productName, productPrice);
                Navigator.pop(context);
              },
              child: Text("One")),
          TextButton(
              onPressed: () {
                printBarcodeData(
                    productId.toString(), productName, productPrice);
                Navigator.pop(context);
                new Timer.periodic(Duration(seconds: 10), (Timer t) {
                  printBarcodeData(
                      productId.toString(), productName, productPrice);
                  if (t.tick == 4) {
                    t.cancel();
                  }
                });
              },
              child: Text("Five"))
        ]);
  }
}
