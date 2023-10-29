import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text(
      '~SMART EXPENSES~',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
    );
  }

  Widget _entryField(
    bool pass,
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      obscureText: pass,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'SignUp'),
      style: ElevatedButton.styleFrom(
        primary: Color(0xff222c3c),
        onPrimary: Colors.white, // Text color
        elevation: 8, // Add elevation (shadow)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // Add rounded corners
        ),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Login' : 'Register instead'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEAE3),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                )),
            _title(),
            const SizedBox(
              height: 50,
            ),
            _entryField(false, 'Email', _controllerEmail),
            const SizedBox(height: 20),
            _entryField(true, 'Password', _controllerPassword),
            const SizedBox(height: 20),
            _errorMessage(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _loginOrRegisterButton(),
                _submitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
