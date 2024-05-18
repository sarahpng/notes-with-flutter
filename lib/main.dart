import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_flutter/firebase_options.dart';
import 'package:notes_with_flutter/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_with_flutter/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    routes: {
      '/login': (context) => const LoginView(),
      '/register': (context) => const RegisterView(),
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
            return const LoginView();
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
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Verify Email",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const Text("Please Verify your email address"),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text("Send Email Verification"),
          ),
        ],
      ),
    );
  }
}
