import 'dart:ui' as ui;

import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:brother_app/util/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;

const int DEFAULT_BARCODE_HEIGHT = 100;
const int DEFAULT_BARCODE_WIDTH = 200;

void printLabel(ui.Image image, BuildContext context) async {
  var printer = new Printer();
  var printInfo = PrinterInfo();
  printInfo.printerModel = Model.QL_1110NWB;

  //printInfo.printMode = PrintMode.FIT_TO_PAGE;
  printInfo.isAutoCut = true;
  printInfo.port = Port.BLUETOOTH;
  // Set the label type.
  printInfo.labelNameIndex = QL1100.ordinalFromID(QL1100.W62.getId());

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
Future<void> printBarcodeData(String data, BuildContext context) async {
  final image.Image newImage =
      image.Image(DEFAULT_BARCODE_WIDTH, DEFAULT_BARCODE_HEIGHT);
  //fill with solid white.
  image.fill(newImage, image.getColor(255, 255, 255));
  drawBarcode(newImage, Barcode.qrCode(), data,
      width: DEFAULT_BARCODE_WIDTH, height: DEFAULT_BARCODE_HEIGHT);
  ui.Image uiImage =
      await getUiImage(newImage, DEFAULT_BARCODE_HEIGHT, DEFAULT_BARCODE_WIDTH);
  printLabel(uiImage, context);
  return;
}
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
