// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppUser extends AppUser {
  @override
  final String email;
  @override
  final String image;
  @override
  final String name;
  @override
  final String dateCreate;

  factory _$AppUser([void Function(AppUserBuilder)? updates]) =>
      (new AppUserBuilder()..update(updates)).build();

  _$AppUser._(
      {required this.email,
      required this.image,
      required this.name,
      required this.dateCreate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, 'AppUser', 'email');
    BuiltValueNullFieldError.checkNotNull(image, 'AppUser', 'image');
    BuiltValueNullFieldError.checkNotNull(name, 'AppUser', 'name');
    BuiltValueNullFieldError.checkNotNull(dateCreate, 'AppUser', 'dateCreate');
  }

  @override
  AppUser rebuild(void Function(AppUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppUserBuilder toBuilder() => new AppUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppUser &&
        email == other.email &&
        image == other.image &&
        name == other.name &&
        dateCreate == other.dateCreate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, email.hashCode), image.hashCode), name.hashCode),
        dateCreate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppUser')
          ..add('email', email)
          ..add('image', image)
          ..add('name', name)
          ..add('dateCreate', dateCreate))
        .toString();
  }
}

class AppUserBuilder implements Builder<AppUser, AppUserBuilder> {
  _$AppUser? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _dateCreate;
  String? get dateCreate => _$this._dateCreate;
  set dateCreate(String? dateCreate) => _$this._dateCreate = dateCreate;


  AppUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _image = $v.image;
      _name = $v.name;
      _dateCreate = $v.dateCreate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppUser;
  }

  @override
  void update(void Function(AppUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppUser build() {
    final _$result = _$v ??
        new _$AppUser._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'AppUser', 'email'),
            image: BuiltValueNullFieldError.checkNotNull(
                image, 'AppUser', 'image'),
            name:
                BuiltValueNullFieldError.checkNotNull(name, 'AppUser', 'name'),
            dateCreate: BuiltValueNullFieldError.checkNotNull(
                dateCreate, 'AppUser', 'dateCreate'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
