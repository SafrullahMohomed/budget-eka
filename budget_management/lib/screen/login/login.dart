import 'package:budget_management/screen/register/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuth extends StatefulWidget {
  const LoginAuth({Key? key}) : super(key: key);
  @override
  State<LoginAuth> createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  final myController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> email;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

// save user email to shared preferences
  Future<void> _saveUser() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('email', _email.text);
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    getValue();
  }

// to get value from shared preferences
  getValue() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    _email.text = prefs.getString('email')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Image.asset(
            'assets/login_image.jpg',
            height: 300,
            width: 300,
          ),
          Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Color.fromARGB(255, 44, 48, 86)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Color.fromARGB(255, 44, 48, 86)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
                obscureText: true,
              )),
          ElevatedButton(
            
            onPressed: () {
              signin();
              _saveUser();
            },
            child: const Text('Sign In'),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
            
                style: TextStyle(
                  
                  color: Colors.black,
                  fontSize: 15,
                ),
                text: "Don't have an account? "),
            TextSpan(
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
                text: "Sign Up",
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterAuth(),),);
                  }),
          ])),
        ],
      )),
    );
  }

  signin() async {
    print("in");
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}

