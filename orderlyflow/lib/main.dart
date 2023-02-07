import 'package:flutter/material.dart';
import 'package:orderlyflow/chatPage.dart';
import 'LogIn/log_in.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => chatPage(),
    },
  ));
}
