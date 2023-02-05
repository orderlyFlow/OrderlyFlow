import 'package:flutter/material.dart';
import 'LogIn/log_in.dart';
import 'main_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => mainPage(),
    },
  ));
}
