// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_reducer_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatusReducerAction extends StatusReducerAction {
  @override
  final String newStatus;

  factory _$StatusReducerAction(
          [void Function(StatusReducerActionBuilder)? updates]) =>
      (new StatusReducerActionBuilder()..update(updates)).build();

  _$StatusReducerAction._({required this.newStatus}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        newStatus, 'StatusReducerAction', 'newStatus');
  }

  @override
  StatusReducerAction rebuild(
          void Function(StatusReducerActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatusReducerActionBuilder toBuilder() =>
      new StatusReducerActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatusReducerAction && newStatus == other.newStatus;
  }

  @override
  int get hashCode {
    return $jf($jc(0, newStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StatusReducerAction')
          ..add('newStatus', newStatus))
        .toString();
  }
}

class StatusReducerActionBuilder
    implements Builder<StatusReducerAction, StatusReducerActionBuilder> {
  _$StatusReducerAction? _$v;

  String? _newStatus;
  String? get newStatus => _$this._newStatus;
  set newStatus(String? newStatus) => _$this._newStatus = newStatus;

  StatusReducerActionBuilder() {
    StatusReducerAction._initializeBuilder(this);
  }

  StatusReducerActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newStatus = $v.newStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatusReducerAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$StatusReducerAction;
  }

  @override
  void update(void Function(StatusReducerActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StatusReducerAction build() {
    final _$result = _$v ??
        new _$StatusReducerAction._(
            newStatus: BuiltValueNullFieldError.checkNotNull(
                newStatus, 'StatusReducerAction', 'newStatus'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
