import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _dumbValue = 0;

  int get dumbValue => _dumbValue;
}
