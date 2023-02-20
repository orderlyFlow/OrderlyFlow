import 'dart:developer';

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
    //print("Database connected");
    collection = db.collection(collectionName);
  }

  /*Future getDocuments() async {
    try {
      final users = await collection.find().toList();
      return users;
    } catch (e) {
      print(e);
      return e;
    }
  }*/
}
