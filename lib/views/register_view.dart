import 'package:flutter/material.dart';

import 'package:notes_with_flutter/constants/routes.dart';

import 'package:notes_with_flutter/services/auth/auth_exceptions.dart';
import 'package:notes_with_flutter/services/auth/auth_service.dart';
// import 'dart:developer' as devtools show log;
import 'package:notes_with_flutter/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Enter Email"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(hintText: "Enter Password"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase()
                    .createUser(email: email, password: password);
                await AuthService.firebase().sendEmailVerification();
                if (context.mounted) {
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }
                // devtools.log(userCredential.toString());
              } on WeakPasswordAuthException {
                if (context.mounted) {
                  await showErrorDialog(context, "Weak password");
                }
              } on EmailAlreadyInUseException {
                if (context.mounted) {
                  await showErrorDialog(context, "Email already in use");
                }
              } on EmailInvalidAuthException {
                if (context.mounted) {
                  await showErrorDialog(context, "Invalid email");
                }
              } on GenericAuthException {
                if (context.mounted) {
                  await showErrorDialog(context, 'Failed to register');
                }
              }
            },
            child: const Text("Register"),
            // style: TextStyle(color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("Already registered? Login here"),
          ),
        ],
      ),
    );
  }
}
