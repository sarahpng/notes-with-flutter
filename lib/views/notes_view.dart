import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_with_flutter/constants/routes.dart';
// import 'dart:developer' as devtools show log;

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<MenuAction>(
            iconColor: Colors.white,
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutlog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, (route) => false);
                    }
                  }
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text(
                  "Log out",
                ),
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text('Notes'),
      ),
    );
  }
}

Future<bool> showLogOutlog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Sign out"),
            ),
          ],
        );
      }).then(
    (value) => value ?? false,
  );
}
