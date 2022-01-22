import 'package:built_value/built_value.dart';

part 'update_user_info.g.dart';

abstract class AbstractUpdateInfo {}

abstract class UpdateUserInfoMiddlewareAction
    implements
        Built<UpdateUserInfoMiddlewareAction,
            UpdateUserInfoMiddlewareActionBuilder>,
        AbstractUpdateInfo {
  String get image;
  UpdateUserInfoMiddlewareAction._();

  factory UpdateUserInfoMiddlewareAction.create({required String image}) =>
      UpdateUserInfoMiddlewareAction((update) => update..image = image);
  factory UpdateUserInfoMiddlewareAction(
          [void Function(UpdateUserInfoMiddlewareActionBuilder) updates]) =
      _$UpdateUserInfoMiddlewareAction;
}

abstract class UpdateUserInfoReducerAction implements Built<UpdateUserInfoReducerAction, UpdateUserInfoReducerActionBuilder>,AbstractUpdateInfo {
  
  String get image;
  UpdateUserInfoReducerAction._();
    factory UpdateUserInfoReducerAction.create({required String newImage}) =>
      UpdateUserInfoReducerAction((update) => update..image = newImage);
  factory UpdateUserInfoReducerAction([void Function(UpdateUserInfoReducerActionBuilder) updates]) = _$UpdateUserInfoReducerAction;
}

//  flutter pub run build_runner build