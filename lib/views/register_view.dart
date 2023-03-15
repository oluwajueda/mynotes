import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mynotes/service/auth/auth_exceptions.dart';

import 'package:mynotes/service/auth/bloc/auth_bloc.dart';
import 'package:mynotes/service/auth/bloc/auth_event.dart';
import 'package:mynotes/service/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/colors.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

import 'package:mynotes/widgets.dart/text_input_field.dart';

class Registerview extends StatefulWidget {
  const Registerview({Key? key}) : super(key: key);

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
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
        if (state is AuthStateRegistering) {
          if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'weak password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email is already in use');
          } else if (state.exception is GenericAuthException) {
            showErrorDialog(context, 'Failed to register');
          } else if (state.exception is InvalidEmailAuthException) {
            showErrorDialog(context, 'Invalid email');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Register',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your email and password to see your notes!',
                style: TextStyle(color: textColor),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldInput(
                textEditingController: _email,
                textInputType: TextInputType.emailAddress,
                hintText: "Enter your email here",
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldInput(
                textEditingController: _password,
                textInputType: TextInputType.text,
                hintText: "Enter your password here",
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
                        AuthEventRegister(
                          email,
                          password,
                        ),
                      );
                },
                child: Container(
                  // ignore: sort_child_properties_last
                  child: const Text(
                    "Register",
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
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //   loginRoute,
                        //   (route) => false,
                        // );
                        context.read<AuthBloc>().add(
                              const AuthEventLogOut(),
                            );
                      },
                      child: const Text(
                        'Already registered? Login here!',
                        style: TextStyle(color: textColor),
                      ),
                    )
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
