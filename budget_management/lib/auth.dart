import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class fireAuth extends StatefulWidget {
  fireAuth({Key? key}) : super(key: key);
  @override
  State<fireAuth> createState() => _fireAuthState();
}

class _fireAuthState extends State<fireAuth> {
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


// save user email and password to shared preferences
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
          Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
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
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Color.fromARGB(255, 44, 48, 86)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
              )),
          ElevatedButton(
            onPressed: signup,
            child: Text('signup'),
          ),
          ElevatedButton(
            onPressed: () {
              signin();
              _saveUser();
            },
            child: Text('signin'),
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
        email: _email.text,
        password: _password.text,
      );
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
