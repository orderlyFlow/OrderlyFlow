import 'package:flutter/material.dart';
import 'LogIn/log_in.dart';
import 'loadingPage/home_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
    },
  ));
}
