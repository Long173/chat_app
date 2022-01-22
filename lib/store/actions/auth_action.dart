import 'package:app_chat/store/models/user.dart';
import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_action.g.dart';

abstract class AbstractAuth {}

abstract class LoginMiddlewareAction
    implements
        Built<LoginMiddlewareAction, LoginMiddlewareActionBuilder>,
        AbstractAuth {
  String get email;
  String get password;

  LoginMiddlewareAction._();

  factory LoginMiddlewareAction.create({
    required String email,
    required String password,
  }) =>
      LoginMiddlewareAction((update) => update
        ..email = email
        ..password = password);

  factory LoginMiddlewareAction(
          [void Function(LoginMiddlewareActionBuilder) updates]) =
      _$LoginMiddlewareAction;
}

abstract class LoginReducerAction
    implements
        Built<LoginReducerAction, LoginReducerActionBuilder>,
        AbstractAuth {
  AppUser get user;

  LoginReducerAction._();

  factory LoginReducerAction.create({required AppUser newUser}) =>
      LoginReducerAction((update) => update..user = newUser.toBuilder());

  factory LoginReducerAction(
          [void Function(LoginReducerActionBuilder) updates]) =
      _$LoginReducerAction;
}

abstract class VerifyUserMiddlewareAction
    implements
        Built<VerifyUserMiddlewareAction, VerifyUserMiddlewareActionBuilder>,
        AbstractAuth {
  User get user;

  VerifyUserMiddlewareAction._();
  factory VerifyUserMiddlewareAction.create({required User newUser}) =>
      VerifyUserMiddlewareAction((update) => update..user = newUser);

  factory VerifyUserMiddlewareAction(
          [void Function(VerifyUserMiddlewareActionBuilder) updates]) =
      _$VerifyUserMiddlewareAction;
}

abstract class LogoutMiddlewareAction
    implements
        Built<LogoutMiddlewareAction, LogoutMiddlewareActionBuilder>,
        AbstractAuth {
  LogoutMiddlewareAction._();

  factory LogoutMiddlewareAction(
          [void Function(LogoutMiddlewareActionBuilder) updates]) =
      _$LogoutMiddlewareAction;
}


// cmd: flutter pub run build_runner build