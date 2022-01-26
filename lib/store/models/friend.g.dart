// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Friend extends Friend {
  @override
  final String name;
  @override
  final String avatar;
  @override
  final String email;

  factory _$Friend([void Function(FriendBuilder)? updates]) =>
      (new FriendBuilder()..update(updates)).build();

  _$Friend._({required this.name, required this.avatar, required this.email})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'Friend', 'name');
    BuiltValueNullFieldError.checkNotNull(avatar, 'Friend', 'avatar');
    BuiltValueNullFieldError.checkNotNull(email, 'Friend', 'email');
  }

  @override
  Friend rebuild(void Function(FriendBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendBuilder toBuilder() => new FriendBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Friend &&
        name == other.name &&
        avatar == other.avatar &&
        email == other.email;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, name.hashCode), avatar.hashCode), email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Friend')
          ..add('name', name)
          ..add('avatar', avatar)
          ..add('email', email))
        .toString();
  }
}

class FriendBuilder implements Builder<Friend, FriendBuilder> {
  _$Friend? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  FriendBuilder();

  FriendBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _avatar = $v.avatar;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Friend other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Friend;
  }

  @override
  void update(void Function(FriendBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Friend build() {
    final _$result = _$v ??
        new _$Friend._(
            name: BuiltValueNullFieldError.checkNotNull(name, 'Friend', 'name'),
            avatar: BuiltValueNullFieldError.checkNotNull(
                avatar, 'Friend', 'avatar'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'Friend', 'email'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
