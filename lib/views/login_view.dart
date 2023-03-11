import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/service/auth/auth_exceptions.dart';
import 'package:mynotes/service/auth/auth_service.dart';
import 'package:mynotes/service/auth/bloc/auth_bloc.dart';
import 'package:mynotes/service/auth/bloc/auth_event.dart';
import 'package:mynotes/service/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/colors.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/loading_dialog.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
import 'package:mynotes/widgets.dart/text_input_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
                context, 'Cannot find a user with the entered credentials!');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Login',
              style: TextStyle(color: Colors.black),
            )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Please log in to your account in order to interact with and create notes!',
                style: TextStyle(color: textColor),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldInput(
                textEditingController: _email,
                hintText: "Enter your email here",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldInput(
                textEditingController: _password,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  final email = _email.text;
                  final password = _password.text;
                  context.read<AuthBloc>().add(
                        AuthEventLogin(
                          email,
                          password,
                        ),
                      );
                },
                child: Container(
                  // ignore: sort_child_properties_last
                  child: const Text(
                    "Log in",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: buttonColor),
                ),
              ),
              TextButton(
                  onPressed: () => {
                        context.read<AuthBloc>().add(
                              const AuthEventForgotPassword(),
                            ),
                      },
                  child: const Text(
                    'I forgot my password',
                    style: TextStyle(color: textColor),
                  )),
              TextButton(
                  onPressed: () => {
                        context.read<AuthBloc>().add(
                              const AuthEventShouldRegister(),
                            ),
                      },
                  child: const Text(
                    'Not registered yet? Register here! ',
                    style: TextStyle(color: textColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


 //   try {

                  //     await AuthService.firebase().login(
                  //       email: email,
                  //       password: password,
                  //     );
                  //     final user = AuthService.firebase().currentUser;
                  //     if (user?.isEmailVerified ?? false) {
                  //       // user email is verified
                  //       Navigator.of(context).pushNamedAndRemoveUntil(
                  //         notesRoute,
                  //         (route) => false,
                  //       );
                  //     } else {
                  //       // user email is not verified
                  //       Navigator.of(context).pushNamedAndRemoveUntil(
                  //           verifyEmailRoute, (route) => false);
                  //     }
                  //   } on UserNotFoundAuthException {
                  //     await showErrorDialog(
                  //       context,
                  //       'User not found',
                  //     );
                  //   } on WrongPasswordAuthException {
                  //     await showErrorDialog(
                  //       context,
                  //       'Wrong credentials',
                  //     );
                  //   } on GenericAuthException {
                  //     await showErrorDialog(
                  //       context,
                  //       'Authentication error',
                  //     );
                  //   }
                  // },