import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  String? _userId;

  String get userId => _userId!;

  set userId(String userId) {
    _userId = userId;
    notifyListeners();
  }
}
