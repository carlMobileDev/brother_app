import 'package:barcode/barcode.dart';

//Readme: https://pub.dev/packages/barcode

String buildBarcode(
  Barcode bc,
  String data, {
  double? width,
  double? height,
  double? fontHeight,
}) {
  /// Create the Barcode

  String svg = bc.toSvg(
    data,
    width: width ?? 200,
    height: height ?? 80,
    fontHeight: fontHeight,
  );

  return svg;
}
