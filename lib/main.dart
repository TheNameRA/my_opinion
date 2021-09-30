import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_opinion/wrapper.dart';
import 'package:my_opinion/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>(
      initialData: null,
      create: (context) =>
          AuthenticationService(FirebaseAuth.instance).authStateChanges,
      child: MaterialApp(
        home: WrapperWidget(),
        title: 'Моё мнение',
        theme: ThemeData(
          backgroundColor: Colors.blueGrey[200],
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
