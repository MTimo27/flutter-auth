import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_v3/resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLoginScreen = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthMethods().signInWithEmailAndPassword(
          _controllerEmail.text, _controllerPassword.text);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAAndPassword() async {
    try {
      await AuthMethods().createUserWithEmailAndPassword(
          _controllerEmail.text, _controllerPassword.text);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await AuthMethods().signInWithGoogle();
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text("Firebase Auth");
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'HMMM ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: () {
          isLoginScreen
              ? signInWithEmailAndPassword()
              : createUserWithEmailAAndPassword();
        },
        child: Text(isLoginScreen ? 'Login' : 'Sign Up'));
  }

  Widget _googleButton() {
    return ElevatedButton(
        onPressed: () {
          signInWithGoogle();
        },
        child: const Text("Sign in with Google"));
  }

  Widget _LoginScreenOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLoginScreen = !isLoginScreen;
          });
        },
        child: Text(isLoginScreen
            ? 'Need an account? Register'
            : 'Already have an account? LoginScreen'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _entryField('email', _controllerEmail),
                _entryField('password', _controllerPassword),
                _errorMessage(),
                _submitButton(),
                _LoginScreenOrRegisterButton(),
                _googleButton(),
              ])),
    );
  }
}
