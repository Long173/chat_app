import 'package:app_chat/store/actions/change_theme_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColorLight,
        child: Center(
          child: StoreConnector<AppState, AppStateViewModel>(
              converter: (Store<AppState> store) =>
                  AppStateViewModel.create(store),
              builder: (BuildContext context, vm) {
                return CupertinoSwitch(
                  value: vm.isDark,
                  onChanged: (value) {
                    setState(() {
                      vm.dispatch(
                        action:
                            ChangeThemeMiddlewareAction.create(isDark: value),
                      );
                    });
                  },
                );
              }),
        ));
  }
}
