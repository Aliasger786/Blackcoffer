import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Global/global.dart';
import 'Screens/home_page.dart';
import 'Screens/phone_screen.dart';
import 'Screens/verify_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String currentUID = '';

  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
      } else {
        currentUID = user.uid;
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Black Coffer',
      theme: ThemeData(
          fontFamily: 'OpenSans',
          brightness: Brightness.light,
          scaffoldBackgroundColor: Global.bgColor,
          iconTheme: IconThemeData(
            color: Global.darkColor,
          ),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Global.darkColor,
            ),
          )
          /* light theme settings */
          ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'phone' : 'home',
      routes: {
        'phone': (context) => const Phone(),
        'verify': (context) => const Otp(),
        'home': (context) => MyHomePage(
              uid: currentUID,
            ),
      },
    );
  }
}
