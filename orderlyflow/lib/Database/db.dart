import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';
import 'db.dart';
import 'dart:developer';

var db;
var collection;

class MongoDB {
  static connect() async {
    db = await Db.create(mongoDB_URL);
    await db.open();

    inspect(db);
    var status = db.serverStatus();
    print(status);
    print("Database connected");
    //collection = db.collection(collectionName);
  }
}
