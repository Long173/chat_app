import 'package:flutter/cupertino.dart';

class Register {
  final String email;
  final String password;
  final String name;
  final String image;
  final BuildContext context;
  Register(
      {required this.name,
      required this.context,
      required this.email,
      required this.password,
      this.image = 'assets/images/person.png'});
}
