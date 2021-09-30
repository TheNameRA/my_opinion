import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_opinion/screens/opinion.dart';
import 'package:my_opinion/screens/sign_in.dart';
import 'package:provider/provider.dart';

class WrapperWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = context.watch<User?>();
    print(user);
    if (user == null) {
      return SignIn();
    } else {
      return OpinionWidget();
    }
  }
}
