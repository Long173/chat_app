
import 'package:built_value/built_value.dart';

part 'register_action.g.dart';

abstract class AbstractRegister {}

abstract class RegisterMiddlewareAction
    implements
        Built<RegisterMiddlewareAction, RegisterMiddlewareActionBuilder>,
        AbstractRegister {
  String get email;
  String get password;
  String get name;
  String get image;
  RegisterMiddlewareAction._();

  factory RegisterMiddlewareAction.create({
    required String email,
    required String password,
    required String name,
    String image = 'assets/person.png'
  }) =>
      RegisterMiddlewareAction((update) => update
        ..email = email
        ..password = password);

  factory RegisterMiddlewareAction(
          [void Function(RegisterMiddlewareActionBuilder) updates]) =
      _$RegisterMiddlewareAction;
}

// cmd: flutter pub run build_runner build