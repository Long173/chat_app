import 'package:app_chat/screens/login_screen/login_widgets.dart';
import 'package:app_chat/screens/register_screen/register_widgets.dart';
import 'package:app_chat/store/actions/register_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/selectors/app_state_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../const.dart';
import '../../keys.dart';
import '../../validation.dart';

class RegisterScreen extends StatelessWidget {
  static final _navigatorKey = NavKey.navKey;
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        leading: BackButtonAppBar(
          navigatorKey: _navigatorKey,
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Register',
                style: kLoginText,
              ),
              Column(
                children: [
                  InputField(
                      controller: fullNameController,
                      hintText: 'Full Name',
                      icon: Icons.person),
                  InputField(
                      controller: emailController,
                      hintText: 'Email',
                      icon: Icons.email),
                  InputField(
                    controller: passwordController,
                    hintText: 'Password',
                    icon: Icons.lock,
                    obscure: true,
                  ),
                  InputField(
                    controller: confirmController,
                    hintText: 'Confirm Password',
                    icon: Icons.lock,
                    obscure: true,
                  ),
                ],
              ),
              StoreConnector<AppState, AppStateViewModel>(
                converter: (Store<AppState> store) =>
                    AppStateViewModel.create(store),
                builder: (context, viewModel) {
                  return GestureDetector(
                    onTap: () async {
                      var fullName = fullNameController.text.trim();
                      var email = emailController.text.trim();
                      var password = passwordController.text.trim();
                      var confirm = confirmController.text.trim();

                      fillCheck([fullName, email, password, confirm]);
                      emailValidation(email);
                      passwordValidation(password);
                      matchPassword(password, confirm);
                      viewModel.dispatch(
                        action: Register(
                          name: fullName,
                          email: email,
                          password: password,
                        ),
                      );
                    },
                    child: RegisterButton(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}