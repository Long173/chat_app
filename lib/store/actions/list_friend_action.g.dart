// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_friend_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListFriendMiddlewareAction extends ListFriendMiddlewareAction {
  @override
  final User user;

  factory _$ListFriendMiddlewareAction(
          [void Function(ListFriendMiddlewareActionBuilder)? updates]) =>
      (new ListFriendMiddlewareActionBuilder()..update(updates)).build();

  _$ListFriendMiddlewareAction._({required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        user, 'ListFriendMiddlewareAction', 'user');
  }

  @override
  ListFriendMiddlewareAction rebuild(
          void Function(ListFriendMiddlewareActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListFriendMiddlewareActionBuilder toBuilder() =>
      new ListFriendMiddlewareActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListFriendMiddlewareAction && user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(0, user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListFriendMiddlewareAction')
          ..add('user', user))
        .toString();
  }
}

class ListFriendMiddlewareActionBuilder
    implements
        Builder<ListFriendMiddlewareAction, ListFriendMiddlewareActionBuilder> {
  _$ListFriendMiddlewareAction? _$v;

  User? _user;
  User? get user => _$this._user;
  set user(User? user) => _$this._user = user;

  ListFriendMiddlewareActionBuilder();

  ListFriendMiddlewareActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListFriendMiddlewareAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ListFriendMiddlewareAction;
  }

  @override
  void update(void Function(ListFriendMiddlewareActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListFriendMiddlewareAction build() {
    final _$result = _$v ??
        new _$ListFriendMiddlewareAction._(
            user: BuiltValueNullFieldError.checkNotNull(
                user, 'ListFriendMiddlewareAction', 'user'));
    replace(_$result);
    return _$result;
  }
}

class _$ListFriendReducerAction extends ListFriendReducerAction {
  @override
  final BuiltList<Friend> listFriend;

  factory _$ListFriendReducerAction(
          [void Function(ListFriendReducerActionBuilder)? updates]) =>
      (new ListFriendReducerActionBuilder()..update(updates)).build();

  _$ListFriendReducerAction._({required this.listFriend}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listFriend, 'ListFriendReducerAction', 'listFriend');
  }

  @override
  ListFriendReducerAction rebuild(
          void Function(ListFriendReducerActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListFriendReducerActionBuilder toBuilder() =>
      new ListFriendReducerActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListFriendReducerAction && listFriend == other.listFriend;
  }

  @override
  int get hashCode {
    return $jf($jc(0, listFriend.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListFriendReducerAction')
          ..add('listFriend', listFriend))
        .toString();
  }
}

class ListFriendReducerActionBuilder
    implements
        Builder<ListFriendReducerAction, ListFriendReducerActionBuilder> {
  _$ListFriendReducerAction? _$v;

  ListBuilder<Friend>? _listFriend;
  ListBuilder<Friend> get listFriend =>
      _$this._listFriend ??= new ListBuilder<Friend>();
  set listFriend(ListBuilder<Friend>? listFriend) =>
      _$this._listFriend = listFriend;

  ListFriendReducerActionBuilder();

  ListFriendReducerActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _listFriend = $v.listFriend.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListFriendReducerAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ListFriendReducerAction;
  }

  @override
  void update(void Function(ListFriendReducerActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListFriendReducerAction build() {
    _$ListFriendReducerAction _$result;
    try {
      _$result = _$v ??
          new _$ListFriendReducerAction._(listFriend: listFriend.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'listFriend';
        listFriend.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListFriendReducerAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
