import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterAuth extends StatefulWidget {
  const RegisterAuth({Key? key}) : super(key: key);
  @override
  State<RegisterAuth> createState() => _RegisterAuthState();
}

class _RegisterAuthState extends State<RegisterAuth> {
  final myController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> email;
  late Future<String> name;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

// save user email to shared preferences
  Future<void> _saveUser() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('email', _email.text);
    await prefs.setString('name', _name.text);
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    // getValue();
  }

// // to get value from shared preferences
//   getValue() async {
//     final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     final SharedPreferences prefs = await _prefs;
//     _email.text = prefs.getString('email')!;
//     _name.text = prefs.getString('name')!;
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
           Row(
             children: const [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  
                ),
              ),
              BackButton(),
             ],
           ),
          Image.asset(
            'assets/register_image.jpg',
            height: 300,
            width: 300,
          ),

          // name text field
          Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Color.fromARGB(255, 44, 48, 86)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
              )),

          // email text field
          Padding(
              padding: const EdgeInsets.all(15),
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

          // password text field
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

          //confirm password text field
          Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: _confirmPassword,
                decoration: const InputDecoration(
                  hintText: "Confirm Password",
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
            onPressed: signup,
            child: const Text('Register'),
          ),
        ],
      )),
    );
  }

  signup() async {
    print("up");
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        // name: _name.text,
        email: _email.text,
        password: _password.text,
      );

      credential.user?.updateDisplayName(_name.text);
      print(credential.user!.email);
      print(credential.user!.displayName);
      _saveUser();

      print(_name.text);
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
