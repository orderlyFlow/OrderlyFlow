import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'constant.dart';
import 'db.dart';
import 'dart:developer';

var db;
var collection;

class MongoDB {
  static connect() async {
    db = await Mongo.Db.create(mongoDB_URL);
    await db.open();

    inspect(db);
    var status = db.serverStatus();
    print(status);
    print("Database connected");
  }

  static Future<Map<String, dynamic>> getInfo() async {
    var db = await Mongo.Db.create(mongoDB_URL);

    await db.open();

    //print('Connected to database');
    var information = await db
        .collection('Personnel')
        .findOne(Mongo.where.eq('_id', 100000)) as Map<String, dynamic>;
    if (information != null) {
      return information;
      // do something with the person object
    } else {
      // handle the case where the result is null
    }

    //await db.close();
  }
}
