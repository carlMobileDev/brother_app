import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:brother_app/db/db.dart';
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
  Map<int, int> scannedIds = {};
  Map<int, Image> cachedImages = {};

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes != null && int.parse(barcodeScanRes) > 0) {
        int productId = int.parse(barcodeScanRes);
        if (scannedIds.containsKey(productId)) {
          scannedIds.update(productId, (value) => value + 1);
        } else {
          scannedIds.putIfAbsent(productId, () => 1);
        }
      }
    });
  }

  Future<void> scanBarcodeContinuous() async {
    String barcodeScanRes;
    List<int> scannedProductIds = [];
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      FlutterBarcodeScanner.getBarcodeStreamReceiver(
        "#ff6666",
        "Done",
        false,
        ScanMode.QR,
      )?.listen((barcode) async {
        if (barcode != null && int.parse(barcode) > 0) {
          int productId = int.parse(barcode);

          //Got a barcode

          // ProductData product = ProductData.fromJson(json.decode(barcode));
          // products.add(product);
          print("Scanned!");
          //scannedProductIds.add(productId);
          HapticFeedback.heavyImpact();
          Flushbar(
            title: "Success",
            message: "Added to Checkout",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ).show(context);

          if (scannedIds.containsKey(productId)) {
            scannedIds.update(productId, (value) => value + 1);
          } else {
            scannedIds.putIfAbsent(productId, () => 1);
          }
        }
      }

          /// barcode to be used
          );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  Future<void> _scanBarcode() async {
    var barcode = await _getBarcode();
    if (barcode.isNotEmpty) {
      int productId = int.parse(barcode);

      if (productId > 0) {
        setState(() {
          if (scannedIds.containsKey(productId)) {
            scannedIds.update(productId, (value) => value + 1);
          } else {
            scannedIds.putIfAbsent(productId, () => 1);
          }
        });
        Flushbar(
          title: "Success",
          message: "Scan another Item!",
          duration: (Duration(seconds: 1)),
          backgroundColor: Colors.green,
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
      subtitle: quantity != null
          ? Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    flex: 5,
                    child: MaterialButton(
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        onPressed: (() {
                          if (quantity == 1) {
                            scannedIds.remove(product.id);
                            Flushbar(
                              title: "Removing Item",
                              message: "${product.name} removed from checkout",
                              duration: (Duration(seconds: 1)),
                              backgroundColor: Colors.yellow,
                              messageColor: Colors.black,
                            ).show(context);
                          } else {
                            scannedIds.update(product.id, (value) => value - 1);
                          }
                          setState(() {});
                        }))),
                Expanded(
                    flex: 3,
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                Expanded(
                    flex: 5,
                    child: MaterialButton(
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                        onPressed: (() {
                          setState(() {
                            scannedIds.update(product.id, (value) => value + 1);
                          });
                        }))),
              ],
            )
          : Container(),
      trailing: quantity != null
          ? Text(
              "\$${roundToDecimals(product.price! * quantity, 2).toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white),
            )
          : Text(""),
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

  @override
  Widget build(BuildContext context) {
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
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    _scanBarcode();
                  });
                }),
            IconButton(
              icon: const Icon(Icons.folder, color: Colors.green),
              onPressed: () {
                setState(() {
                  _getCatalog();
                });
              },
            )
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
                  return Column(
                    children: [
                      MaterialButton(
                          child: Text("Scan Barcode"), onPressed: _scanBarcode),
                      MaterialButton(
                        child: Text("Checkout from catalog"),
                        onPressed: _getCatalog,
                      )
                    ],
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
                                      color: Colors.green),
                                  child: makeListTile(
                                      product, scannedIds[product.id]))),
                        SizedBox(height: 70),
                        Text(
                            "Total \$${roundToDecimals(totalCost, 2).toStringAsFixed(2)}")
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
