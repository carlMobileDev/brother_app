import 'dart:convert';

import 'package:brother_app/db/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CatalogGridview extends StatefulWidget {
  final Function onClick;

  const CatalogGridview({Key? key, required this.onClick}) : super(key: key);

  @override
  _CatalogGridviewState createState() => _CatalogGridviewState();
}

class _CatalogGridviewState extends State<CatalogGridview> {
  Map<int, Image> cachedImages = {};
  List<ProductData> allProducts = [];
  List<ProductData> selectedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    allProducts =
        await Provider.of<MyDatabase>(context, listen: false).getAllProducts();
    for (ProductData product in allProducts) {
      if (!cachedImages.containsKey(product.id))
        cachedImages.putIfAbsent(
            product.id, () => Image.memory(base64Decode(product.image)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        itemCount: allProducts.length,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        itemBuilder: (_, index) => _inventoryCard(allProducts[index]));
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
      onTap: widget.onClick(),
    );
  }
}
