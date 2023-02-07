import 'package:flutter/material.dart';
import 'package:orderlyflow/main_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => mainPage(),
    },
  ));
}
