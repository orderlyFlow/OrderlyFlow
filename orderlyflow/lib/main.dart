// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderlyflow/calendar.dart';
import 'package:orderlyflow/Pages/chatPage.dart';
import 'package:orderlyflow/mainPage%20widgets/dashboard.dart';
import 'package:orderlyflow/tasks.dart';
import 'LogIn/log_in.dart';
import 'loadingPage/home_screen.dart';
import 'Database/db.dart';
import 'package:orderlyflow/main_page.dart';
import 'package:orderlyflow/calendar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LogIn(),
    },
  ));
}
