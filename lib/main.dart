import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_flutter/constants/routes.dart';
import 'package:notes_with_flutter/firebase_options.dart';
import 'package:notes_with_flutter/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_with_flutter/views/notes_view.dart';
import 'package:notes_with_flutter/views/register_view.dart';
import 'package:notes_with_flutter/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        // snapshot is the state of the future
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
          // you need to ask user to login again after verifying the email
          // final user = FirebaseAuth.instance.currentUser;
          // print(user?.emailVerified);
          // if (user?.emailVerified ?? false) {
          //   // print("you are a verified");
          //   return const Text("Done");
          // } else {
          //   // print("you are not verified user");
          //   // pushing Verify Email View for the verification
          //   // pushing a new scaffold on top a scaffold in future builder was causing the error
          //   // Navigator.of(context).push(MaterialPageRoute(
          //   //   builder: (context) => const VerifyEmailView(),
          //   // ));
          //   return const VerifyEmailView();
          // }
        }
      },
    );
  }
}
