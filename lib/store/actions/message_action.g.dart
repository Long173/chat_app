// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendMessageMiddlewareAction extends SendMessageMiddlewareAction {
  @override
  final String message;
  @override
  final String sender;
  @override
  final String receiver;
  @override
  final String type;
  @override
  final Timestamp timeSend;
  @override
  final bool seen;

  factory _$SendMessageMiddlewareAction(
          [void Function(SendMessageMiddlewareActionBuilder)? updates]) =>
      (new SendMessageMiddlewareActionBuilder()..update(updates)).build();

  _$SendMessageMiddlewareAction._(
      {required this.message,
      required this.sender,
      required this.receiver,
      required this.type,
      required this.timeSend,
      required this.seen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        message, 'SendMessageMiddlewareAction', 'message');
    BuiltValueNullFieldError.checkNotNull(
        sender, 'SendMessageMiddlewareAction', 'sender');
    BuiltValueNullFieldError.checkNotNull(
        receiver, 'SendMessageMiddlewareAction', 'receiver');
    BuiltValueNullFieldError.checkNotNull(
        type, 'SendMessageMiddlewareAction', 'type');
    BuiltValueNullFieldError.checkNotNull(
        timeSend, 'SendMessageMiddlewareAction', 'timeSend');
    BuiltValueNullFieldError.checkNotNull(
        seen, 'SendMessageMiddlewareAction', 'seen');
  }

  @override
  SendMessageMiddlewareAction rebuild(
          void Function(SendMessageMiddlewareActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendMessageMiddlewareActionBuilder toBuilder() =>
      new SendMessageMiddlewareActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendMessageMiddlewareAction &&
        message == other.message &&
        sender == other.sender &&
        receiver == other.receiver &&
        type == other.type &&
        timeSend == other.timeSend &&
        seen == other.seen;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, message.hashCode), sender.hashCode),
                    receiver.hashCode),
                type.hashCode),
            timeSend.hashCode),
        seen.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SendMessageMiddlewareAction')
          ..add('message', message)
          ..add('sender', sender)
          ..add('receiver', receiver)
          ..add('type', type)
          ..add('timeSend', timeSend)
          ..add('seen', seen))
        .toString();
  }
}

class SendMessageMiddlewareActionBuilder
    implements
        Builder<SendMessageMiddlewareAction,
            SendMessageMiddlewareActionBuilder> {
  _$SendMessageMiddlewareAction? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _sender;
  String? get sender => _$this._sender;
  set sender(String? sender) => _$this._sender = sender;

  String? _receiver;
  String? get receiver => _$this._receiver;
  set receiver(String? receiver) => _$this._receiver = receiver;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  Timestamp? _timeSend;
  Timestamp? get timeSend => _$this._timeSend;
  set timeSend(Timestamp? timeSend) => _$this._timeSend = timeSend;

  bool? _seen;
  bool? get seen => _$this._seen;
  set seen(bool? seen) => _$this._seen = seen;

  SendMessageMiddlewareActionBuilder();

  SendMessageMiddlewareActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _sender = $v.sender;
      _receiver = $v.receiver;
      _type = $v.type;
      _timeSend = $v.timeSend;
      _seen = $v.seen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendMessageMiddlewareAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SendMessageMiddlewareAction;
  }

  @override
  void update(void Function(SendMessageMiddlewareActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SendMessageMiddlewareAction build() {
    final _$result = _$v ??
        new _$SendMessageMiddlewareAction._(
            message: BuiltValueNullFieldError.checkNotNull(
                message, 'SendMessageMiddlewareAction', 'message'),
            sender: BuiltValueNullFieldError.checkNotNull(
                sender, 'SendMessageMiddlewareAction', 'sender'),
            receiver: BuiltValueNullFieldError.checkNotNull(
                receiver, 'SendMessageMiddlewareAction', 'receiver'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, 'SendMessageMiddlewareAction', 'type'),
            timeSend: BuiltValueNullFieldError.checkNotNull(
                timeSend, 'SendMessageMiddlewareAction', 'timeSend'),
            seen: BuiltValueNullFieldError.checkNotNull(
                seen, 'SendMessageMiddlewareAction', 'seen'));
    replace(_$result);
    return _$result;
  }
}

class _$DeleteMessageMiddlewareAction extends DeleteMessageMiddlewareAction {
  factory _$DeleteMessageMiddlewareAction(
          [void Function(DeleteMessageMiddlewareActionBuilder)? updates]) =>
      (new DeleteMessageMiddlewareActionBuilder()..update(updates)).build();

  _$DeleteMessageMiddlewareAction._() : super._();

  @override
  DeleteMessageMiddlewareAction rebuild(
          void Function(DeleteMessageMiddlewareActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteMessageMiddlewareActionBuilder toBuilder() =>
      new DeleteMessageMiddlewareActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteMessageMiddlewareAction;
  }

  @override
  int get hashCode {
    return 971602711;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('DeleteMessageMiddlewareAction')
        .toString();
  }
}

class DeleteMessageMiddlewareActionBuilder
    implements
        Builder<DeleteMessageMiddlewareAction,
            DeleteMessageMiddlewareActionBuilder> {
  _$DeleteMessageMiddlewareAction? _$v;

  DeleteMessageMiddlewareActionBuilder();

  @override
  void replace(DeleteMessageMiddlewareAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteMessageMiddlewareAction;
  }

  @override
  void update(void Function(DeleteMessageMiddlewareActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DeleteMessageMiddlewareAction build() {
    final _$result = _$v ?? new _$DeleteMessageMiddlewareAction._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
