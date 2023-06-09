import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_gg/screen/editprofile_screen.dart';
import 'package:grad_gg/screen/login_screen.dart';
import 'package:grad_gg/screen/navigate.dart';
import 'package:grad_gg/screen/mainscreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const  Mynavi();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
