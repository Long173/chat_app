import 'package:app_chat/config/route.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../config/const.dart';
import '../../config/keys.dart';
import 'login_widgets.dart';

class LoginScreen extends StatefulWidget {
  static final _navigatorKey = NavKey.navKey;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 50,),
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
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
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
                      textInputType: TextInputType.text,
                      hintText: 'Enter your password',
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
                            
                            vm.dispatch(
                              action: LoginMiddlewareAction.create(
                                email: email,
                                password: password,
                              ),
                            );
                          },
                          child: CustomButton(
                            text: 'Log In',
                          ),
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
                        ),
                        GestureDetector(
                          onTap: () {
                            LoginScreen._navigatorKey.currentState!
                                .pushNamed(Routes.register);
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
