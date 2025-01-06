import 'package:flutter/material.dart';
import 'package:notes_with_flutter/constants/routes.dart';
import 'package:notes_with_flutter/constants/strings.dart';
import 'package:notes_with_flutter/services/auth/auth_service.dart';

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
          children: [
            const Text(verifyAcc),
            const Text(resendEmail),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text("Send Email Verification"),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                }
              },
              child: const Text("Restart"),
            )
          ],
        ),
      ),
    );
  }
}
