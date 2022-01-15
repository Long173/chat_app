import 'package:flutter/cupertino.dart';

class LogIn {
  final String email;
  final String password;
  final BuildContext context;
  LogIn({
    required this.email,
    required this.password,
    required this.context,
  });
}

class LogOutAction {
  LogOutAction();
}
