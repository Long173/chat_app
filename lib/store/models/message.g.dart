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
  final String type;
  @override
  final String time;
  @override
  final String image;
  @override
  final bool seen;
  @override
  final Timestamp realTime;

  factory _$RecentMessage([void Function(RecentMessageBuilder)? updates]) =>
      (new RecentMessageBuilder()..update(updates)).build();

  _$RecentMessage._(
      {required this.sender,
      required this.body,
      required this.type,
      required this.time,
      required this.image,
      required this.seen,
      required this.realTime})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(sender, 'RecentMessage', 'sender');
    BuiltValueNullFieldError.checkNotNull(body, 'RecentMessage', 'body');
    BuiltValueNullFieldError.checkNotNull(type, 'RecentMessage', 'type');
    BuiltValueNullFieldError.checkNotNull(time, 'RecentMessage', 'time');
    BuiltValueNullFieldError.checkNotNull(image, 'RecentMessage', 'image');
    BuiltValueNullFieldError.checkNotNull(seen, 'RecentMessage', 'seen');
    BuiltValueNullFieldError.checkNotNull(
        realTime, 'RecentMessage', 'realTime');
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
        type == other.type &&
        time == other.time &&
        image == other.image &&
        seen == other.seen &&
        realTime == other.realTime;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, sender.hashCode), body.hashCode),
                        type.hashCode),
                    time.hashCode),
                image.hashCode),
            seen.hashCode),
        realTime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RecentMessage')
          ..add('sender', sender)
          ..add('body', body)
          ..add('type', type)
          ..add('time', time)
          ..add('image', image)
          ..add('seen', seen)
          ..add('realTime', realTime))
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

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _time;
  String? get time => _$this._time;
  set time(String? time) => _$this._time = time;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  bool? _seen;
  bool? get seen => _$this._seen;
  set seen(bool? seen) => _$this._seen = seen;

  Timestamp? _realTime;
  Timestamp? get realTime => _$this._realTime;
  set realTime(Timestamp? realTime) => _$this._realTime = realTime;

  RecentMessageBuilder();

  RecentMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sender = $v.sender;
      _body = $v.body;
      _type = $v.type;
      _time = $v.time;
      _image = $v.image;
      _seen = $v.seen;
      _realTime = $v.realTime;
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
            type: BuiltValueNullFieldError.checkNotNull(
                type, 'RecentMessage', 'type'),
            time: BuiltValueNullFieldError.checkNotNull(
                time, 'RecentMessage', 'time'),
            image: BuiltValueNullFieldError.checkNotNull(
                image, 'RecentMessage', 'image'),
            seen: BuiltValueNullFieldError.checkNotNull(
                seen, 'RecentMessage', 'seen'),
            realTime: BuiltValueNullFieldError.checkNotNull(
                realTime, 'RecentMessage', 'realTime'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
