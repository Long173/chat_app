import 'package:app_chat/route.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/selectors/app_state_view_model.dart';
import 'package:app_chat/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../const.dart';
import '../../keys.dart';
import 'login_widgets.dart';

class LoginScreen extends StatefulWidget {
  static final _navigatorKey = NavKey.navKey;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var validation = Validation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'Login',
                style: kLoginText,
              ),
              SizedBox(
                height: 10,
              ),
              Hero(
                tag: 'icon',
                child: Image.asset(
                  'assets/icon/logo.png',
                  height: 150,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                InputField(
                  controller: emailController,
                  icon: Icons.email,
                  hintText: 'Type your email',
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                InputField(
                  controller: passwordController,
                  icon: Icons.lock,
                  hintText: 'Type your password',
                  obscure: true,
                ),
                SizedBox(
                  height: 20,
                ),
                StoreConnector<AppState, AppStateViewModel>(
                  converter: (Store<AppState> store) =>
                      AppStateViewModel.create(store),
                  distinct: true,
                  builder: (BuildContext context, vm) {
                    return GestureDetector(
                      onTap: () async {
                        var email = emailController.text.trim();
                        var password = passwordController.text.trim();
                        validation.fillCheck([email, password]);
                        validation.emailValidation(email);
                        validation.passwordValidation(password);
                        vm.dispatch(
                            action: LogIn(email: email, password: password));
                      },
                      child: LoginButton(),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not register yet? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        LoginScreen._navigatorKey.currentState!
                            .pushNamed(Routes.register);
                      },
                      child: Text(
                        'Register Now',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
