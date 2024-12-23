import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }
}
