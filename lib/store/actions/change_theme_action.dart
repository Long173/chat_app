import 'package:built_value/built_value.dart';

part 'change_theme_action.g.dart';


abstract class AbstractChangeTheme {}

abstract class ChangeThemeMiddlewareAction
    implements
        Built<ChangeThemeMiddlewareAction, ChangeThemeMiddlewareActionBuilder>,AbstractChangeTheme {
  bool get isDark;

  ChangeThemeMiddlewareAction._();
  factory ChangeThemeMiddlewareAction.create({required bool isDark})=>ChangeThemeMiddlewareAction((update)=> update..isDark = isDark);
    
  
  factory ChangeThemeMiddlewareAction(
          [void Function(ChangeThemeMiddlewareActionBuilder) updates]) =
      _$ChangeThemeMiddlewareAction;
}


abstract class ChangeThemeReducerAction
    implements
        Built<ChangeThemeReducerAction, ChangeThemeReducerActionBuilder>,AbstractChangeTheme {
  bool get isDark;

  ChangeThemeReducerAction._();
  factory ChangeThemeReducerAction.create({required bool isDark})=>ChangeThemeReducerAction((update)=> update..isDark = isDark);
    
  
  factory ChangeThemeReducerAction(
          [void Function(ChangeThemeReducerActionBuilder) updates]) =
      _$ChangeThemeReducerAction;
}