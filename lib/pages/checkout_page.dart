import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:brother_app/db/db.dart';
import 'package:brother_app/providers/checkout_provider.dart';
import 'package:brother_app/util/custom_theme.dart';
import 'package:brother_app/util/print_helper.dart';
import 'package:brother_app/widgets/checkout_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class BarcodeReader extends StatefulWidget {
  @override
  _BarcodeReaderState createState() => _BarcodeReaderState();
}

class _BarcodeReaderState extends State<BarcodeReader> {
  //Holds Product Ids scanned and their quantities
  //Map<int, int> scannedIds = {};
  Map<int, Image> cachedImages = {};

  Future<void> _scanBarcode() async {
    var barcode = await _getBarcode();
    if (barcode.isNotEmpty) {
      int productId = int.parse(barcode);

      if (productId > 0) {
        setState(() {
          context.read<CheckoutProvider>().addScannedId(productId);
        });
        Flushbar(
          title: "Success",
          message: "Scan another Item!",
          duration: (Duration(seconds: 1)),
          backgroundColor: myTheme().accentColor,
        ).show(context);
        Timer(Duration(seconds: 1), () {
          if (barcode.isNotEmpty) _scanBarcode();
        });
      } else {
        //Scan was canceled
      }
    }
  }

  Future<String> _getBarcode() async {
    String barcodeScanResult = "";
    try {
      barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Done', true, ScanMode.QR);
    } on PlatformException catch (e) {}
    return barcodeScanResult;
  }

  void _getCatalog() {}

  Widget makeListTile(ProductData product, int? quantity) {
    return ListTile(
      dense: false,
      //contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white)),
        ),
        child: cachedImages[product.id],
      ),
      title: Text(
        product.name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      isThreeLine: true,
      subtitle: Text(
        "Quantity: " +
            Provider.of<CheckoutProvider>(context)
                .scannedIds[product.id]
                .toString(),
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      trailing: quantity != null
          ? Text(
              "\$${roundToDecimals(product.price! * quantity, 2).toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white),
            )
          : Text(""),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CheckoutItemDialog(
                productId: product.id,
              );
            });
      },
    );
  }

  double roundToDecimals(double numToRound, int deciPlaces) {
    num modPlus1 = pow(10.0, deciPlaces + 1);
    String strMP1 = ((numToRound * modPlus1).roundToDouble() / modPlus1)
        .toStringAsFixed(deciPlaces + 1);
    int lastDigitStrMP1 = int.parse(strMP1.substring(strMP1.length - 1));

    num mod = pow(10.0, deciPlaces);
    String strDblValRound =
        ((numToRound * mod).roundToDouble() / mod).toStringAsFixed(deciPlaces);
    int lastDigitStrDVR =
        int.parse(strDblValRound.substring(strDblValRound.length - 1));

    return (lastDigitStrMP1 == 5 && lastDigitStrDVR % 2 != 0)
        ? ((numToRound * mod).truncateToDouble() / mod)
        : double.parse(strDblValRound);
  }

  void _showReceiptDialog(
      List<ProductData> products, Map<int, int> scannedIds, double totalCost) {
    showDialog(
      context: context,
      builder: (_) => PrintReceiptDialog(
          purchasedData: products,
          scannedIds: scannedIds,
          totalCost: totalCost),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<int, int> scannedIds = context.watch<CheckoutProvider>().scannedIds;
    print("rebuilding");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Checkout!",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: myTheme().accentColor,
                ),
                onPressed: () {
                  setState(() {
                    _scanBarcode();
                  });
                }),
            // IconButton(
            //   icon: const Icon(Icons.folder, color: Colors.green),
            //   onPressed: () {
            //     setState(() {
            //       _getCatalog();
            //     });
            //   },
            // )
          ],
        ),
        body: FutureBuilder(
            future: Provider.of<MyDatabase>(context, listen: false)
                .getAllProductsForIds(scannedIds.keys.toList()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                double totalCost = 0;
                List<ProductData> products = snapshot.data as List<ProductData>;
                if (products.isEmpty) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: myTheme().accentColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: MaterialButton(
                          child: Text("Scan Barcode",
                              style: TextStyle(color: Colors.white)),
                          onPressed: _scanBarcode),
                    ),
                    // MaterialButton(
                    //   child: Text("Checkout from catalog"),
                    //   onPressed: _getCatalog,
                    // )
                  );
                } else {
                  for (var product in products) {
                    print(product.name);
                    if (!cachedImages.containsKey(product.id))
                      cachedImages.putIfAbsent(product.id,
                          () => Image.memory(base64Decode(product.image)));
                    if (product.price != null &&
                        scannedIds[product.id] != null) {
                      double pri = totalCost;
                      pri = pri + (product.price! * scannedIds[product.id]!);
                      totalCost = pri;
                    }
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var product in products)
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: myTheme().primaryColor),
                                  child: makeListTile(
                                      product, scannedIds[product.id]))),
                        SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Total \$${roundToDecimals(totalCost, 2).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(height: 20),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(12),
                          color: Colors.red,
                          child:
                              Text("Checkout", style: TextStyle(fontSize: 23)),
                          onPressed: () {
                            Map<int, int> copyOfScannedIds =
                                Map.from(scannedIds);
                            _showReceiptDialog(
                                products, copyOfScannedIds, totalCost);

                            for (var product in products) {
                              Provider.of<MyDatabase>(context, listen: false)
                                  .decrementInventoryAmountForProduct(
                                      product.id, scannedIds[product.id]!);
                            }

                            setState(() {
                              scannedIds.clear();
                            });
                          },
                        )
                      ],
                    ),
                  );
                }
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}

class PrintReceiptDialog extends StatelessWidget {
  final List<ProductData> purchasedData;
  final Map<int, int> scannedIds;
  final double totalCost;

  const PrintReceiptDialog(
      {Key? key,
      required this.purchasedData,
      required this.scannedIds,
      required this.totalCost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Print?"),
        content: Text("Print a purchase receipt?"),
        actions: [
          TextButton(
              onPressed: () {
                printReceiptData(purchasedData, scannedIds,
                    roundToDecimals(totalCost, 2).toStringAsFixed(2), context);
                Navigator.pop(context);
              },
              child: Text("Print")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"))
        ]);
  }
}
