import 'package:app_chat/store/models/user.dart';

class LogIn {
  final String email;
  final String password;
  LogIn({
    required this.email,
    required this.password,
  });
}

class OnAuthenticated {
  final AppUser user;

  const OnAuthenticated({required this.user});
}

class LogOutAction {
  LogOutAction();
}
