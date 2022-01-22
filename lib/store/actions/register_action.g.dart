// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterMiddlewareAction extends RegisterMiddlewareAction {
  @override
  final String email;
  @override
  final String password;
  @override
  final String name;
  @override
  final String image;

  factory _$RegisterMiddlewareAction(
          [void Function(RegisterMiddlewareActionBuilder)? updates]) =>
      (new RegisterMiddlewareActionBuilder()..update(updates)).build();

  _$RegisterMiddlewareAction._(
      {required this.email,
      required this.password,
      required this.name,
      required this.image})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, 'RegisterMiddlewareAction', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, 'RegisterMiddlewareAction', 'password');
    BuiltValueNullFieldError.checkNotNull(
        name, 'RegisterMiddlewareAction', 'name');
    BuiltValueNullFieldError.checkNotNull(
        image, 'RegisterMiddlewareAction', 'image');
  }

  @override
  RegisterMiddlewareAction rebuild(
          void Function(RegisterMiddlewareActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterMiddlewareActionBuilder toBuilder() =>
      new RegisterMiddlewareActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterMiddlewareAction &&
        email == other.email &&
        password == other.password &&
        name == other.name &&
        image == other.image;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, email.hashCode), password.hashCode), name.hashCode),
        image.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RegisterMiddlewareAction')
          ..add('email', email)
          ..add('password', password)
          ..add('name', name)
          ..add('image', image))
        .toString();
  }
}

class RegisterMiddlewareActionBuilder
    implements
        Builder<RegisterMiddlewareAction, RegisterMiddlewareActionBuilder> {
  _$RegisterMiddlewareAction? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  RegisterMiddlewareActionBuilder();

  RegisterMiddlewareActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _name = $v.name;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterMiddlewareAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegisterMiddlewareAction;
  }

  @override
  void update(void Function(RegisterMiddlewareActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RegisterMiddlewareAction build() {
    final _$result = _$v ??
        new _$RegisterMiddlewareAction._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'RegisterMiddlewareAction', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, 'RegisterMiddlewareAction', 'password'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'RegisterMiddlewareAction', 'name'),
            image: BuiltValueNullFieldError.checkNotNull(
                image, 'RegisterMiddlewareAction', 'image'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new