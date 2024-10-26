import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'capture_page.dart';
import 'qa_page.dart';
/*import 'read_page.dart';
import 'qa_page.dart';
import 'sos_page.dart';
import 'assistance_page.dart'; */

void main() {
  runApp(MaterialApp(
    title: 'BreakFree',
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/singup': (context) => SignUpPage(),
      '/login': (context) => LoginPage(),
      '/home': (context) => HomePage(),
      '/profile': (context) => ProfilePage(),
      '/capture': (context) => CapturePage(),
      '/qa': (context) => QAPage(),
      /*'/read': (context) => ReadPage(),
      '/qa': (context) => QAPage(),
      '/sos': (context) => SOSPage(),
     '/assistance': (context) => AssistancePage(),*/
    },
  ));
}
