import 'package:built_value/built_value.dart';

part 'user.g.dart';

abstract class AbstractAppUser {}

abstract class AppUser
    implements Built<AppUser, AppUserBuilder>, AbstractAppUser {
  String get email;
  String get image;
  String get name;
  String get dateCreate;
  AppUser._();

  factory AppUser([void Function(AppUserBuilder)? updates]) = _$AppUser;

  static void updateImage() {}
}
// cmd: flutter pub run build_runner build
