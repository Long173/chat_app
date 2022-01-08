import 'package:app_chat/store/models/message.dart';
import 'package:built_value/built_value.dart';

part 'app_state.g.dart';

abstract class AbstractAppState {}

abstract class AppState
    implements Built<AppState, AppStateBuilder>, AbstractAppState {
  String get status;
  List<RecentMessage>? get recentMess;
  AppState._();

  static void _initializeBuilder(AppStateBuilder builder) {
    builder.status = "idle";
  }

  factory AppState([void Function(AppStateBuilder)? updates]) = _$AppState;
}
// cmd: flutter pub run build_runner build
