// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderlyflow/Pages/CalendarPage/calendar.dart';
import 'package:orderlyflow/Pages/ChatPage/chatPage.dart';
import 'package:orderlyflow/Pages/MainPage/mainPage%20widgets/dashboard.dart';
import 'package:orderlyflow/Pages/RequestPage/requests.dart';
import 'package:orderlyflow/Pages/TaskPage/tasks.dart';
import 'Pages/LogInPage/LogIn/log_in.dart';
import 'loadingPage/home_screen.dart';
import 'Database/db.dart';
import 'package:orderlyflow/Pages/MainPage/main_page.dart';
import 'package:orderlyflow/Pages/CalendarPage/calendar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MongoDB.connect();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LogIn(),
      //LogIn(),
    },
  ));
}
