import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_opinion/services/authentication_service.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthenticationService _auth =
      AuthenticationService(FirebaseAuth.instance);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Войти анонимно'),
          onPressed: () async {
            _auth.signIn();
          },
        ),
      ),
    );
  }
}
