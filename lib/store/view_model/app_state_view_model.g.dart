// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppStateViewModel extends AppStateViewModel {
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
  @override
  final int page;
  @override
  final Function({required dynamic action}) dispatch;

  factory _$AppStateViewModel(
          [void Function(AppStateViewModelBuilder)? updates]) =>
      (new AppStateViewModelBuilder()..update(updates)).build();

  _$AppStateViewModel._(
      {required this.status,
      required this.recentMess,
      this.user,
      required this.isDark,
      required this.friend,
      required this.page,
      required this.dispatch})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        status, 'AppStateViewModel', 'status');
    BuiltValueNullFieldError.checkNotNull(
        recentMess, 'AppStateViewModel', 'recentMess');
    BuiltValueNullFieldError.checkNotNull(
        isDark, 'AppStateViewModel', 'isDark');
    BuiltValueNullFieldError.checkNotNull(
        friend, 'AppStateViewModel', 'friend');
    BuiltValueNullFieldError.checkNotNull(page, 'AppStateViewModel', 'page');
    BuiltValueNullFieldError.checkNotNull(
        dispatch, 'AppStateViewModel', 'dispatch');
  }

  @override
  AppStateViewModel rebuild(void Function(AppStateViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateViewModelBuilder toBuilder() =>
      new AppStateViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is AppStateViewModel &&
        status == other.status &&
        recentMess == other.recentMess &&
        user == other.user &&
        isDark == other.isDark &&
        friend == other.friend &&
        page == other.page &&
        dispatch == _$dynamicOther.dispatch;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, status.hashCode), recentMess.hashCode),
                        user.hashCode),
                    isDark.hashCode),
                friend.hashCode),
            page.hashCode),
        dispatch.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppStateViewModel')
          ..add('status', status)
          ..add('recentMess', recentMess)
          ..add('user', user)
          ..add('isDark', isDark)
          ..add('friend', friend)
          ..add('page', page)
          ..add('dispatch', dispatch))
        .toString();
  }
}

class AppStateViewModelBuilder
    implements Builder<AppStateViewModel, AppStateViewModelBuilder> {
  _$AppStateViewModel? _$v;

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

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  Function({required dynamic action})? _dispatch;
  Function({required dynamic action})? get dispatch => _$this._dispatch;
  set dispatch(Function({required dynamic action})? dispatch) =>
      _$this._dispatch = dispatch;

  AppStateViewModelBuilder();

  AppStateViewModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _recentMess = $v.recentMess.toBuilder();
      _user = $v.user?.toBuilder();
      _isDark = $v.isDark;
      _friend = $v.friend.toBuilder();
      _page = $v.page;
      _dispatch = $v.dispatch;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppStateViewModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppStateViewModel;
  }

  @override
  void update(void Function(AppStateViewModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppStateViewModel build() {
    _$AppStateViewModel _$result;
    try {
      _$result = _$v ??
          new _$AppStateViewModel._(
              status: BuiltValueNullFieldError.checkNotNull(
                  status, 'AppStateViewModel', 'status'),
              recentMess: recentMess.build(),
              user: _user?.build(),
              isDark: BuiltValueNullFieldError.checkNotNull(
                  isDark, 'AppStateViewModel', 'isDark'),
              friend: friend.build(),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, 'AppStateViewModel', 'page'),
              dispatch: BuiltValueNullFieldError.checkNotNull(
                  dispatch, 'AppStateViewModel', 'dispatch'));
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
            'AppStateViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
