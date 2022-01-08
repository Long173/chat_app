import "package:built_value/built_value.dart";

part 'user.g.dart';

abstract class AbstractUser {}

abstract class AppUser implements Built<AppUser, AppUserBuilder>, AbstractUser {
  String get uid;
  String get email;
  String get name;
  String get image;
  AppUser._();

  factory AppUser([void Function(AppUserBuilder) updates]) = _$AppUser;
}
// cmd: flutter pub run build_runner build
