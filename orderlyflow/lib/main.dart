import 'package:flutter/material.dart';

import 'package:orderlyflow/chatPage.dart';
import 'LogIn/log_in.dart';
import 'Database/db.dart';
import 'package:orderlyflow/main_page.dart';

//const mongoDB_URL = "";
//const collName = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => mainPage(),
    },
  ));
}
