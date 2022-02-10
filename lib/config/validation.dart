import 'package:flutter/material.dart';

abstract class AbstractValidation {
  void emailValidation(String email,BuildContext context);
  void passwordValidation(String password,BuildContext context);
  void matchPassword(String password, var confirm, BuildContext context);
  void fillCheck(var list, BuildContext context);
}

class Validation implements AbstractValidation {
  @override
  void emailValidation(String email, BuildContext context) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email invalid, please check again'),
        ),
      );
      return;
    }
  }

  @override
  void passwordValidation(String password,BuildContext context) {
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be at least 6 characters'),
        ),
      );
    }
  }

  @override
  void matchPassword(String password, var confirm, BuildContext context) {
    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password is not match'),
        ),
      );
      return;
    }
  }

  @override
  void fillCheck(var list, BuildContext context) {
    for (var value in list) {
      if (value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill all field'),
          ),
        );
        return;
      }
    }
  }
}
