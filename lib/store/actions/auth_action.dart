import 'package:app_chat/store/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class VerifyUser {
  final User user;
  VerifyUser({required this.user});
}

class Authenticated {
  final AppUser user;

  const Authenticated({required this.user});
}

class LogOutAction {
  LogOutAction();
}
