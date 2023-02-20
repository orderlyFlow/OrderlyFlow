import 'package:flutter/material.dart';
import 'package:orderlyflow/calendar.dart';
import 'package:orderlyflow/chatPage.dart';
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
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Dashboard(),
    },
  ));
}
