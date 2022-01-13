import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/models/message.dart';
import 'package:redux/redux.dart';

class AppStateViewModel {
  final String status;
  final List<RecentMessage>? recentMess;
  final Function({required dynamic action}) dispatch;

  AppStateViewModel({
    required this.recentMess,
    required this.status,
    required this.dispatch,
  });

  factory AppStateViewModel.create(Store<AppState> store) {
    onDispatch({required dynamic action}) {
      store.dispatch(action);
    }

    return AppStateViewModel(
      recentMess: store.state.recentMess,
      status: store.state.status,
      dispatch: onDispatch,
    );
  }
}
