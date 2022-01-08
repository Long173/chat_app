// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecentMessage extends RecentMessage {
  @override
  final String sender;
  @override
  final String body;
  @override
  final Timestamp time;
  @override
  final String image;

  factory _$RecentMessage([void Function(RecentMessageBuilder)? updates]) =>
      (new RecentMessageBuilder()..update(updates)).build();

  _$RecentMessage._(
      {required this.sender,
      required this.body,
      required this.time,
      required this.image})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(sender, 'RecentMessage', 'sender');
    BuiltValueNullFieldError.checkNotNull(body, 'RecentMessage', 'body');
    BuiltValueNullFieldError.checkNotNull(time, 'RecentMessage', 'time');
    BuiltValueNullFieldError.checkNotNull(image, 'RecentMessage', 'image');
  }

  @override
  RecentMessage rebuild(void Function(RecentMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecentMessageBuilder toBuilder() => new RecentMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecentMessage &&
        sender == other.sender &&
        body == other.body &&
        time == other.time &&
        image == other.image;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, sender.hashCode), body.hashCode), time.hashCode),
        image.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RecentMessage')
          ..add('sender', sender)
          ..add('body', body)
          ..add('time', time)
          ..add('image', image))
        .toString();
  }
}

class RecentMessageBuilder
    implements Builder<RecentMessage, RecentMessageBuilder> {
  _$RecentMessage? _$v;

  String? _sender;
  String? get sender => _$this._sender;
  set sender(String? sender) => _$this._sender = sender;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  Timestamp? _time;
  Timestamp? get time => _$this._time;
  set time(Timestamp? time) => _$this._time = time;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  RecentMessageBuilder();

  RecentMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sender = $v.sender;
      _body = $v.body;
      _time = $v.time;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecentMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RecentMessage;
  }

  @override
  void update(void Function(RecentMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RecentMessage build() {
    final _$result = _$v ??
        new _$RecentMessage._(
            sender: BuiltValueNullFieldError.checkNotNull(
                sender, 'RecentMessage', 'sender'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, 'RecentMessage', 'body'),
            time: BuiltValueNullFieldError.checkNotNull(
                time, 'RecentMessage', 'time'),
            image: BuiltValueNullFieldError.checkNotNull(
                image, 'RecentMessage', 'image'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
