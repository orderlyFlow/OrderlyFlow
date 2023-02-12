import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';
import 'db.dart';
import 'dart:developer';

class MongoDB {
  static connect() async {
    var db = await Db.create(mongoDB_URL);
    await db.open(secure: true);
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var colection = db.collection(collectionName);
  }
}
