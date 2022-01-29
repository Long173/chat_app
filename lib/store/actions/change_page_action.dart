import 'package:built_value/built_value.dart';

part 'change_page_action.g.dart';

abstract class AbstractChangePage {}


abstract class ChangePageMiddlewareAction
    implements
        Built<ChangePageMiddlewareAction, ChangePageMiddlewareActionBuilder>,AbstractChangePage {
  int get goToPage;

  ChangePageMiddlewareAction._();
  factory ChangePageMiddlewareAction.create({required int newPage}) =>
      ChangePageMiddlewareAction((update) => update..goToPage = newPage);
  factory ChangePageMiddlewareAction(
          [void Function(ChangePageMiddlewareActionBuilder) updates]) =
      _$ChangePageMiddlewareAction;
}

abstract class ChangePageReducerAction implements Built<ChangePageReducerAction, ChangePageReducerActionBuilder>,AbstractChangePage {
  int get goToPage;

  ChangePageReducerAction._();


    factory ChangePageReducerAction.create({required int newPage}) =>
      ChangePageReducerAction((update) => update..goToPage = newPage);
  factory ChangePageReducerAction([void Function(ChangePageReducerActionBuilder) updates]) = _$ChangePageReducerAction;
}