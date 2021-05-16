import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CheckoutProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<int, int> _scannedIds = {};
  int _tempAmount = 1;
  Map<int, int> get scannedIds => _scannedIds;
  int get tempAmount => _tempAmount;

  void initializeNewCheckoutDialog(int productId) {
    _tempAmount = scannedIds[productId]!;
  }

  void setTempAmount(int amount) {
    _tempAmount = amount;
    notifyListeners();
  }

  void incrementTempAmount() {
    _tempAmount++;
    notifyListeners();
  }

  void decrementTempAmount() {
    _tempAmount--;
    notifyListeners();
  }

  void setNewAmountForId(int productId) {
    _scannedIds.update(productId, (value) => tempAmount);
    _tempAmount = 1; //reset temp
    notifyListeners();
  }

  // void decrementAmountForId(int productId, currentAmount) {
  //   _scannedIds.update(productId, (value) => value - 1);
  //   notifyListeners();
  // }
  //
  // void incrementAmountForId(int productId) {
  //   _scannedIds.update(productId, (value) => value + 1);
  //   notifyListeners();
  // }

  void addScannedId(int productId) {
    if (_scannedIds.containsKey(productId)) {
      _scannedIds.update(productId, (value) => value + 1);
    } else {
      _scannedIds.putIfAbsent(productId, () => 1);
    }
    notifyListeners();
  }

  void clearScannedIds() {
    _scannedIds.clear();
    notifyListeners();
  }

  void removeScannedId(int productId) {
    scannedIds.remove(productId);
    notifyListeners();
  }
}
