import 'package:built_value/built_value.dart';

part 'status_reducer_action.g.dart';

abstract class AbstractStatusReducerAction {}

abstract class StatusReducerAction
    implements
        Built<StatusReducerAction, StatusReducerActionBuilder>,
        AbstractStatusReducerAction{
  String get newStatus;
  StatusReducerAction._();

  factory StatusReducerAction.create({required String status}) =>
      StatusReducerAction((update) => update..newStatus = status);

  static void _initializeBuilder(StatusReducerActionBuilder builder) {}

  factory StatusReducerAction(
          [void Function(StatusReducerActionBuilder)? updates]) =
      _$StatusReducerAction;
}
