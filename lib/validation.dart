import 'package:fluttertoast/fluttertoast.dart';

class Validation {
  void emailValidation(var email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      Fluttertoast.showToast(msg: 'Email invalid, please check again');
      return;
    }
  }

  void passwordValidation(var password) {
    if (password.length < 6) {
      Fluttertoast.showToast(msg: 'Password must be at least 6 characters');
    }
  }

  void matchPassword(var password, var confirm) {
    if (password != confirm) {
      Fluttertoast.showToast(msg: 'Password is not match');
      return;
    }
  }

  void fillCheck(var list) {
    for (var value in list) {
      if (value.isEmpty) {
        Fluttertoast.showToast(msg: 'Please fill all field');
        return;
      }
    }
  }
}
