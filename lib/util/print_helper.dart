import 'dart:math';
import 'dart:ui' as ui;

import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:brother_app/db/db.dart';
import 'package:brother_app/util/image_helper.dart';
import 'package:brother_app/util/receipt_data.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;

const int DEFAULT_BARCODE_HEIGHT = 100;
const int DEFAULT_BARCODE_WIDTH = 200;

void printLabel(
    ui.Image image, BuildContext context, LabelSize labelSize) async {
  var printer = new Printer();
  var printInfo = PrinterInfo();
  printInfo.printerModel = Model.QL_1110NWB;

  //printInfo.printMode = PrintMode.FIT_TO_PAGE;
  printInfo.isAutoCut = true;
  printInfo.port = Port.BLUETOOTH;
  // Set the label type.
  if (labelSize == LabelSize.SMALL) {
    printInfo.labelNameIndex = QL1100.ordinalFromID(QL1100.W62.getId());
  } else {
    printInfo.labelNameIndex = QL1100.ordinalFromID(QL1100.W103.getId());
  }
  // Set the printer info so we can use the SDK to get the printers.
  await printer.setPrinterInfo(printInfo);

  // Get a list of printers with my model available in the network.
  List<BluetoothPrinter> printers =
      await printer.getBluetoothPrinters([Model.QL_1110NWB.getName()]);

  if (printers.isEmpty) {
    // Show a message if no printers are found.
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Text("No paired printers found on your device."),
    //   ),
    // ));
    print("Could not find printer!");
    AlertDialog errorDialog = AlertDialog(
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text("Ok"))
      ],
      title: Text("No Printers Found!"),
    );
    showDialog(
        context: context,
        builder: (_) {
          return errorDialog;
        });
    return;
  }
  // Get the IP Address from the first printer found.
  printInfo.macAddress = printers.single.macAddress;

  printer.setPrinterInfo(printInfo);
  printer.printImage(image);
}

//Takes the data to encode in the barcode (typically product.id)
// and prints it via the brother sdk
Future<void> printBarcodeData(
    String data, String name, double price, BuildContext context) async {
  image.Image newImage =
      image.Image(DEFAULT_BARCODE_WIDTH, DEFAULT_BARCODE_HEIGHT);
  //fill with solid white.
  image.fill(newImage, image.getColor(255, 255, 255));
  drawBarcode(newImage, Barcode.qrCode(), data, width: 100, height: 50);
  newImage = image.drawString(newImage, image.arial_14, 85, 10, name,
      color: Colors.black.value);
  newImage = image.drawString(newImage, image.arial_24, 85, 55,
      "\$" + roundToDecimals(price, 2).toStringAsFixed(2),
      color: Colors.black.value);

  ui.Image uiImage =
      await getUiImage(newImage, DEFAULT_BARCODE_HEIGHT, DEFAULT_BARCODE_WIDTH);
  printLabel(uiImage, context, LabelSize.SMALL);
  return;
}

Future<void> printReceiptData(List<ProductData> products,
    Map<int, int> scannedAmounts, String total, BuildContext context) async {
  int headerHeight = 50;
  int trailerHeight = 50;
  int totalHeight = 50 + (products.length * 25) + headerHeight + trailerHeight;
  image.Image newImage = image.Image(DEFAULT_BARCODE_WIDTH, totalHeight);
  image.fill(newImage, image.getColor(255, 255, 255));
  newImage = image.drawString(newImage, image.arial_24, 20, 20, "Receipt",
      color: Colors.black.value);
  int currentHeight = 25 + headerHeight;
  for (ProductData p in products) {
    ReceiptData rData = ReceiptData(
        p.name, scannedAmounts[p.id]!, p.price! * scannedAmounts[p.id]!);
    newImage = image.drawString(
        newImage, image.arial_14, 05, currentHeight, rData.toString(),
        color: Colors.black.value);
    currentHeight += 10;
    newImage = image.drawString(newImage, image.arial_14, 15, currentHeight,
        "------------------------------------");
    currentHeight += 15;
  }

  newImage = image.drawString(
      newImage,
      image.arial_14,
      DEFAULT_BARCODE_WIDTH ~/ 2,
      totalHeight - trailerHeight,
      "Total: \$$total",
      color: Colors.black.value);

  ui.Image uiImage =
      await getUiImage(newImage, totalHeight, DEFAULT_BARCODE_WIDTH);
  printLabel(uiImage, context, LabelSize.LARGE);

  return;
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

enum LabelSize { LARGE, SMALL }
// void captureContext(BuildContext context, GlobalKey widgetKey) async {
//   try {
//     print('capturing current context');
//     RenderRepaintBoundary? boundary =
//         widgetKey.currentContext?.findRenderObject();
//
//     //boundary.toImage requires time to paint before it can capture.
//     if (boundary!.debugNeedsPaint) {
//       print("Waiting for boundary to be painted.");
//       await Future.delayed(const Duration(milliseconds: 20));
//       return captureContext(context, widgetKey);
//     }
//
//     ui.Image image = await boundary.toImage();
//     _print(context, image);
//     // ByteData byteData =
//     //     await image.toByteData(format: ui.ImageByteFormat.png);
//     // var pngBytes = byteData.buffer.asUint8List();
//     // var bs64 = base64Encode(pngBytes);
//     // print(pngBytes);
//     // print(bs64);
//     // setState(() {});
//     // return pngBytes;
//   } catch (e) {
//     print(e);
//   }
// }
