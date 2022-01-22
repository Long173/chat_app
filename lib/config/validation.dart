import 'package:fluttertoast/fluttertoast.dart';

abstract class AbstractValidation {
  void emailValidation(String email);
  void passwordValidation(String password);
  void matchPassword(String password, var confirm);
  void fillCheck(var list);
}

class Validation implements AbstractValidation {
  @override
  void emailValidation(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      Fluttertoast.showToast(msg: 'Email invalid, please check again');
      return;
    }
  }

  @override
  void passwordValidation(String password) {
    if (password.length < 6) {
      Fluttertoast.showToast(msg: 'Password must be at least 6 characters');
    }
  }

  @override
  void matchPassword(String password, var confirm) {
    if (password != confirm) {
      Fluttertoast.showToast(msg: 'Password is not match');
      return;
    }
  }

  @override
  void fillCheck(var list) {
    for (var value in list) {
      if (value.isEmpty) {
        Fluttertoast.showToast(msg: 'Please fill all field');
        return;
      }
    }
  }
}
