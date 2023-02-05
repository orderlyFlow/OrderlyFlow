import 'package:flutter/material.dart';
import 'main_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => mainPage(),
    },
  ));
}
