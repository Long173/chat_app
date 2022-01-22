// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_mess_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RencentChatMiddlewareAction extends RencentChatMiddlewareAction {
  @override
  final User user;

  factory _$RencentChatMiddlewareAction(
          [void Function(RencentChatMiddlewareActionBuilder)? updates]) =>
      (new RencentChatMiddlewareActionBuilder()..update(updates)).build();

  _$RencentChatMiddlewareAction._({required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        user, 'RencentChatMiddlewareAction', 'user');
  }

  @override
  RencentChatMiddlewareAction rebuild(
          void Function(RencentChatMiddlewareActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RencentChatMiddlewareActionBuilder toBuilder() =>
      new RencentChatMiddlewareActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RencentChatMiddlewareAction && user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(0, user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RencentChatMiddlewareAction')
          ..add('user', user))
        .toString();
  }
}

class RencentChatMiddlewareActionBuilder
    implements
        Builder<RencentChatMiddlewareAction,
            RencentChatMiddlewareActionBuilder> {
  _$RencentChatMiddlewareAction? _$v;

  User? _user;
  User? get user => _$this._user;
  set user(User? user) => _$this._user = user;

  RencentChatMiddlewareActionBuilder();

  RencentChatMiddlewareActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RencentChatMiddlewareAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RencentChatMiddlewareAction;
  }

  @override
  void update(void Function(RencentChatMiddlewareActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RencentChatMiddlewareAction build() {
    final _$result = _$v ??
        new _$RencentChatMiddlewareAction._(
            user: BuiltValueNullFieldError.checkNotNull(
                user, 'RencentChatMiddlewareAction', 'user'));
    replace(_$result);
    return _$result;
  }
}

class _$RencentChatReducerAction extends RencentChatReducerAction {
  @override
  final List<RecentMessage> recentMess;

  factory _$RencentChatReducerAction(
          [void Function(RencentChatReducerActionBuilder)? updates]) =>
      (new RencentChatReducerActionBuilder()..update(updates)).build();

  _$RencentChatReducerAction._({required this.recentMess}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        recentMess, 'RencentChatReducerAction', 'recentMess');
  }

  @override
  RencentChatReducerAction rebuild(
          void Function(RencentChatReducerActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RencentChatReducerActionBuilder toBuilder() =>
      new RencentChatReducerActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RencentChatReducerAction && recentMess == other.recentMess;
  }

  @override
  int get hashCode {
    return $jf($jc(0, recentMess.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RencentChatReducerAction')
          ..add('recentMess', recentMess))
        .toString();
  }
}

class RencentChatReducerActionBuilder
    implements
        Builder<RencentChatReducerAction, RencentChatReducerActionBuilder> {
  _$RencentChatReducerAction? _$v;

  List<RecentMessage>? _recentMess;
  List<RecentMessage>? get recentMess => _$this._recentMess;
  set recentMess(List<RecentMessage>? recentMess) =>
      _$this._recentMess = recentMess;

  RencentChatReducerActionBuilder();

  RencentChatReducerActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recentMess = $v.recentMess;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RencentChatReducerAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RencentChatReducerAction;
  }

  @override
  void update(void Function(RencentChatReducerActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RencentChatReducerAction build() {
    final _$result = _$v ??
        new _$RencentChatReducerAction._(
            recentMess: BuiltValueNullFieldError.checkNotNull(
                recentMess, 'RencentChatReducerAction', 'recentMess'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
