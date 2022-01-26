import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/models/friend.dart';
import 'package:app_chat/store/models/message.dart';
import 'package:app_chat/store/models/user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:redux/redux.dart';

part 'app_state_view_model.g.dart';

abstract class AbstractAppStateViewModel {}

abstract class AppStateViewModel
    implements
        Built<AppStateViewModel, AppStateViewModelBuilder>,
        AbstractAppStateViewModel {
  String get status;
  BuiltList<RecentMessage> get recentMess;
  AppUser? get user;
  bool get isDark;
  BuiltList<Friend> get friend;
  Function({required dynamic action}) get dispatch;

  AppStateViewModel._();

  factory AppStateViewModel.create(Store<AppState> store) {
    onDispatch({required dynamic action}) {
      store.dispatch(action);
    }

    return AppStateViewModel((update) => update
      ..status = store.state.status
      ..recentMess = ListBuilder(store.state.recentMess)
      ..user = store.state.user?.toBuilder()
      ..dispatch = onDispatch
      ..friend = ListBuilder(store.state.friend)
      ..isDark = store.state.isDark);
  }
  factory AppStateViewModel([void Function(AppStateViewModelBuilder) updates]) =
      _$AppStateViewModel;
}
