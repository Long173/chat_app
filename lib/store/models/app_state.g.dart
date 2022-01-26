// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final String status;
  @override
  final BuiltList<RecentMessage> recentMess;
  @override
  final AppUser? user;
  @override
  final bool isDark;
  @override
  final BuiltList<Friend> friend;

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {required this.status,
      required this.recentMess,
      this.user,
      required this.isDark,
      required this.friend})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, 'AppState', 'status');
    BuiltValueNullFieldError.checkNotNull(recentMess, 'AppState', 'recentMess');
    BuiltValueNullFieldError.checkNotNull(isDark, 'AppState', 'isDark');
    BuiltValueNullFieldError.checkNotNull(friend, 'AppState', 'friend');
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        status == other.status &&
        recentMess == other.recentMess &&
        user == other.user &&
        isDark == other.isDark &&
        friend == other.friend;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, status.hashCode), recentMess.hashCode),
                user.hashCode),
            isDark.hashCode),
        friend.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('status', status)
          ..add('recentMess', recentMess)
          ..add('user', user)
          ..add('isDark', isDark)
          ..add('friend', friend))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  ListBuilder<RecentMessage>? _recentMess;
  ListBuilder<RecentMessage> get recentMess =>
      _$this._recentMess ??= new ListBuilder<RecentMessage>();
  set recentMess(ListBuilder<RecentMessage>? recentMess) =>
      _$this._recentMess = recentMess;

  AppUserBuilder? _user;
  AppUserBuilder get user => _$this._user ??= new AppUserBuilder();
  set user(AppUserBuilder? user) => _$this._user = user;

  bool? _isDark;
  bool? get isDark => _$this._isDark;
  set isDark(bool? isDark) => _$this._isDark = isDark;

  ListBuilder<Friend>? _friend;
  ListBuilder<Friend> get friend =>
      _$this._friend ??= new ListBuilder<Friend>();
  set friend(ListBuilder<Friend>? friend) => _$this._friend = friend;

  AppStateBuilder() {
    AppState._initializeBuilder(this);
  }

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _recentMess = $v.recentMess.toBuilder();
      _user = $v.user?.toBuilder();
      _isDark = $v.isDark;
      _friend = $v.friend.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              status: BuiltValueNullFieldError.checkNotNull(
                  status, 'AppState', 'status'),
              recentMess: recentMess.build(),
              user: _user?.build(),
              isDark: BuiltValueNullFieldError.checkNotNull(
                  isDark, 'AppState', 'isDark'),
              friend: friend.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recentMess';
        recentMess.build();
        _$failedField = 'user';
        _user?.build();

        _$failedField = 'friend';
        friend.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
