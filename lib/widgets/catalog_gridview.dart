import 'dart:convert';

import 'package:brother_app/db/db.dart';
import 'package:brother_app/util/custom_theme.dart';
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
            if (allProducts.isEmpty) {
              return Center(
                child: Text("Your inventory is empty! Add some items first!"),
              );
            } else {
              return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  itemCount: allProducts.length,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  itemBuilder: (_, index) =>
                      _inventoryCard(allProducts[index]));
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _inventoryCard(ProductData data) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: myTheme().accentColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(8.0), child: cachedImages[data.id]!),
            Text(data.name, style: TextStyle(color: Colors.white)),
            Text("Price: ${data.price}", style: TextStyle(color: Colors.white)),
            Text("Amount: ${data.inventoryAmount}",
                style: TextStyle(color: Colors.white)),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
      onTap: () {
        printBarcodeData(data.id.toString(), context);
        print("Item clicked!");
      },
    );
  }
}
