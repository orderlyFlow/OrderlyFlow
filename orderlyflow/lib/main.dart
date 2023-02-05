import 'package:flutter/material.dart';
import 'LogIn/log_in.dart';
import 'chatPage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => chatPage(),
    },
  ));
}
