import 'dart:math';

import 'package:brother_app/db/db.dart';
import 'package:flutter/painting.dart';

class ReceiptData {
  late String name;
  late int quantity;
  late double totalCost;

  ReceiptData(this.name, this.quantity, this.totalCost);

  ReceiptData.fromProductData(ProductData p, int amount) {
    ReceiptData(p.name, amount, (p.price! * amount));
  }

  @override
  String toString() {
    return name +
        "   -   " +
        quantity.toString() +
        "|      \$" +
        roundToDecimals(totalCost, 2).toStringAsFixed(2);
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
}
