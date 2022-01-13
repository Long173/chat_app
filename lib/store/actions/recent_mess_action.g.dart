// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_mess_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetAllRecentMess extends GetAllRecentMess {
  @override
  final User user;

  factory _$GetAllRecentMess(
          [void Function(GetAllRecentMessBuilder)? updates]) =>
      (new GetAllRecentMessBuilder()..update(updates)).build();

  _$GetAllRecentMess._({required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(user, 'GetAllRecentMess', 'user');
  }

  @override
  GetAllRecentMess rebuild(void Function(GetAllRecentMessBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetAllRecentMessBuilder toBuilder() =>
      new GetAllRecentMessBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAllRecentMess && user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(0, user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetAllRecentMess')..add('user', user))
        .toString();
  }
}

class GetAllRecentMessBuilder
    implements Builder<GetAllRecentMess, GetAllRecentMessBuilder> {
  _$GetAllRecentMess? _$v;

  User? _user;
  User? get user => _$this._user;
  set user(User? user) => _$this._user = user;

  GetAllRecentMessBuilder();

  GetAllRecentMessBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetAllRecentMess other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetAllRecentMess;
  }

  @override
  void update(void Function(GetAllRecentMessBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetAllRecentMess build() {
    final _$result = _$v ??
        new _$GetAllRecentMess._(
            user: BuiltValueNullFieldError.checkNotNull(
                user, 'GetAllRecentMess', 'user'));
    replace(_$result);
    return _$result;
  }
}

class _$ChangeRecentMess extends ChangeRecentMess {
  @override
  final List<RecentMessage> recentMess;

  factory _$ChangeRecentMess(
          [void Function(ChangeRecentMessBuilder)? updates]) =>
      (new ChangeRecentMessBuilder()..update(updates)).build();

  _$ChangeRecentMess._({required this.recentMess}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        recentMess, 'ChangeRecentMess', 'recentMess');
  }

  @override
  ChangeRecentMess rebuild(void Function(ChangeRecentMessBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangeRecentMessBuilder toBuilder() =>
      new ChangeRecentMessBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeRecentMess && recentMess == other.recentMess;
  }

  @override
  int get hashCode {
    return $jf($jc(0, recentMess.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChangeRecentMess')
          ..add('recentMess', recentMess))
        .toString();
  }
}

class ChangeRecentMessBuilder
    implements Builder<ChangeRecentMess, ChangeRecentMessBuilder> {
  _$ChangeRecentMess? _$v;

  List<RecentMessage>? _recentMess;
  List<RecentMessage>? get recentMess => _$this._recentMess;
  set recentMess(List<RecentMessage>? recentMess) =>
      _$this._recentMess = recentMess;

  ChangeRecentMessBuilder();

  ChangeRecentMessBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recentMess = $v.recentMess;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeRecentMess other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChangeRecentMess;
  }

  @override
  void update(void Function(ChangeRecentMessBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChangeRecentMess build() {
    final _$result = _$v ??
        new _$ChangeRecentMess._(
            recentMess: BuiltValueNullFieldError.checkNotNull(
                recentMess, 'ChangeRecentMess', 'recentMess'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
