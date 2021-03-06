import 'package:app_chat/config/route.dart';
import 'package:app_chat/screens/login_screen/login_widgets.dart';
import 'package:app_chat/store/actions/register_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../config/const.dart';
import '../../config/keys.dart';
import '../../config/validation.dart';

class RegisterScreen extends StatefulWidget {
  static final _navigatorKey = NavKey.navKey;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  var validation = Validation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                                    SizedBox(height: 50,),

                      Text(
                        'Register',
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
                  Column(
                    children: [
                      InputField(
                          textInputType: TextInputType.text,
                          controller: fullNameController,
                          hintText: 'Full Name',
                          icon: Icons.person),
                      InputField(
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          hintText: 'Email',
                          icon: Icons.email),
                      InputField(
                        textInputType: TextInputType.text,
                        controller: passwordController,
                        hintText: 'Password',
                        icon: Icons.lock,
                        obscure: true,
                      ),
                      InputField(
                        textInputType: TextInputType.text,
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
              
                          
                          viewModel.dispatch(
                            action: RegisterMiddlewareAction.create(
                              name: fullName,
                              email: email,
                              password: password,
                              confirm: confirm,
                            ),
                          );
                        },
                        child: CustomButton(
                          text: "Sign Up",
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
                          'Have account yet? ',
                        ),
                        GestureDetector(
                          onTap: () {
                            RegisterScreen._navigatorKey.currentState!
                                .pushNamed(Routes.login);
                          },
                          child: Text(
                            'Login Now',
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
          ),
        ),
      ),
    );
  }
}
