// import 'package:app1/googleAuth.dart';
import 'package:budget_management/home.dart';
import 'package:budget_management/screen/landing.dart';
import 'package:budget_management/screen/login/login.dart';
import 'package:budget_management/screen/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:html';

class landing extends StatefulWidget {
  landing({Key? key}) : super(key: key);

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return const HomeLanding();
              } else {
                return const LoginAuth();
              }
            })));
  }
}
