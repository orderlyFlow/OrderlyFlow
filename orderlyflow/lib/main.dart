import 'package:flutter/material.dart';
import 'LogIn/log_in.dart';
import 'mainPage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const LogIn(),
    },
  ));
}

