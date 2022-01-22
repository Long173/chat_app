// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginMiddlewareAction extends LoginMiddlewareAction {
  @override
  final String email;
  @override
  final String password;

  factory _$LoginMiddlewareAction(
          [void Function(LoginMiddlewareActionBuilder)? updates]) =>
      (new LoginMiddlewareActionBuilder()..update(updates)).build();

  _$LoginMiddlewareAction._({required this.email, required this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, 'LoginMiddlewareAction', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, 'LoginMiddlewareAction', 'password');
  }

  @override
  LoginMiddlewareAction rebuild(
          void Function(LoginMiddlewareActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginMiddlewareActionBuilder toBuilder() =>
      new LoginMiddlewareActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginMiddlewareAction &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, email.hashCode), password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginMiddlewareAction')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class LoginMiddlewareActionBuilder
    implements Builder<LoginMiddlewareAction, LoginMiddlewareActionBuilder> {
  _$LoginMiddlewareAction? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  LoginMiddlewareActionBuilder();

  LoginMiddlewareActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginMiddlewareAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginMiddlewareAction;
  }

  @override
  void update(void Function(LoginMiddlewareActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginMiddlewareAction build() {
    final _$result = _$v ??
        new _$LoginMiddlewareAction._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'LoginMiddlewareAction', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, 'LoginMiddlewareAction', 'password'));
    replace(_$result);
    return _$result;
  }
}

class _$LoginReducerAction extends LoginReducerAction {
  @override
  final AppUser user;

  factory _$LoginReducerAction(
          [void Function(LoginReducerActionBuilder)? updates]) =>
      (new LoginReducerActionBuilder()..update(updates)).build();

  _$LoginReducerAction._({required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(user, 'LoginReducerAction', 'user');
  }

  @override
  LoginReducerAction rebuild(
          void Function(LoginReducerActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginReducerActionBuilder toBuilder() =>
      new LoginReducerActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginReducerAction && user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(0, user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginReducerAction')
          ..add('user', user))
        .toString();
  }
}

class LoginReducerActionBuilder
    implements Builder<LoginReducerAction, LoginReducerActionBuilder> {
  _$LoginReducerAction? _$v;

  AppUserBuilder? _user;
  AppUserBuilder get user => _$this._user ??= new AppUserBuilder();
  set user(AppUserBuilder? user) => _$this._user = user;

  LoginReducerActionBuilder();

  LoginReducerActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginReducerAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginReducerAction;
  }

  @override
  void update(void Function(LoginReducerActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginReducerAction build() {
    _$LoginReducerAction _$result;
    try {
      _$result = _$v ?? new _$LoginReducerAction._(user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LoginReducerAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$VerifyUserMiddlewareAction extends VerifyUserMiddlewareAction {
  @override
  final User user;

  factory _$VerifyUserMiddlewareAction(
          [void Function(VerifyUserMiddlewareActionBuilder)? updates]) =>
      (new VerifyUserMiddlewareActionBuilder()..update(updates)).build();

  _$VerifyUserMiddlewareAction._({required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        user, 'VerifyUserMiddlewareAction', 'user');
  }

  @override
  VerifyUserMiddlewareAction rebuild(
          void Function(VerifyUserMiddlewareActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyUserMiddlewareActionBuilder toBuilder() =>
      new VerifyUserMiddlewareActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyUserMiddlewareAction && user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(0, user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VerifyUserMiddlewareAction')
          ..add('user', user))
        .toString();
  }
}

class VerifyUserMiddlewareActionBuilder
    implements
        Builder<VerifyUserMiddlewareAction, VerifyUserMiddlewareActionBuilder> {
  _$VerifyUserMiddlewareAction? _$v;

  User? _user;
  User? get user => _$this._user;
  set user(User? user) => _$this._user = user;

  VerifyUserMiddlewareActionBuilder();

  VerifyUserMiddlewareActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyUserMiddlewareAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerifyUserMiddlewareAction;
  }

  @override
  void update(void Function(VerifyUserMiddlewareActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$VerifyUserMiddlewareAction build() {
    final _$result = _$v ??
        new _$VerifyUserMiddlewareAction._(
            user: BuiltValueNullFieldError.checkNotNull(
                user, 'VerifyUserMiddlewareAction', 'user'));
    replace(_$result);
    return _$result;
  }
}

class _$LogoutMiddlewareAction extends LogoutMiddlewareAction {
  factory _$LogoutMiddlewareAction(
          [void Function(LogoutMiddlewareActionBuilder)? updates]) =>
      (new LogoutMiddlewareActionBuilder()..update(updates)).build();

  _$LogoutMiddlewareAction._() : super._();

  @override
  LogoutMiddlewareAction rebuild(
          void Function(LogoutMiddlewareActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LogoutMiddlewareActionBuilder toBuilder() =>
      new LogoutMiddlewareActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LogoutMiddlewareAction;
  }

  @override
  int get hashCode {
    return 128459588;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('LogoutMiddlewareAction').toString();
  }
}

class LogoutMiddlewareActionBuilder
    implements Builder<LogoutMiddlewareAction, LogoutMiddlewareActionBuilder> {
  _$LogoutMiddlewareAction? _$v;

  LogoutMiddlewareActionBuilder();

  @override
  void replace(LogoutMiddlewareAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LogoutMiddlewareAction;
  }

  @override
  void update(void Function(LogoutMiddlewareActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LogoutMiddlewareAction build() {
    final _$result = _$v ?? new _$LogoutMiddlewareAction._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
