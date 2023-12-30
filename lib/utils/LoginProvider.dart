
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  String? userId;

  void setUserId(String userId) {
    this.userId = userId;
    notifyListeners();
  }
}