import 'package:flutter/material.dart';
import 'LogIn/log_in.dart';
import 'LogIn/log_in.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LogIn(),
    },
  ));
}
