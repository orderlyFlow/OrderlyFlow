import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Database/textControllers.dart';
import 'constant.dart';
import 'db.dart';
import 'dart:developer';

var db;
var collection;

class MongoDB {
  static connect() async {
    db = await Mongo.Db.create(mongoDB_URL);
    final collectionName = db.collection("Personnel");
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
  }

  static Future<Map<String, dynamic>> getInfo() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    final information = await coll.findOne(Mongo.where.eq('_id', 100000))
        as Map<String, dynamic>;
    return information;

    //await db.close();
  }

  static Future<Map<String, dynamic>> getID() async {
    /////////////////////////////
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    final information = await coll.findOne(Mongo.where
            .eq('_id', StoreController.ID_controller.value.text.trim()))
        as Map<String, dynamic>;
    if (information != null) {
      StoreController.ID_found = true as Rx;
      return information;
    } else {
      return StoreController.ID_controller.update((val) {
        "ID not found";
      }) as Map<String, dynamic>;
    }
    //await db.close();
  }

  static Future<Map<String, dynamic>> getPassword() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    final information = await coll.findOne(Mongo.where
            .eq('password', StoreController.Pass_controller.value.text.trim()))
        as Map<String, dynamic>;
    if (information != null) {
      StoreController.Pass_found = true as Rx;
      return information;
    } else {
      return StoreController.ID_controller.update((val) {
        "Password is incorrect";
      }) as Map<String, dynamic>;
    }

    //await db.close();
  }

  /*static Future<Map<String, dynamic>> getOTP() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    final information = await coll.findOne(Mongo.where.eq('otp', StoreController.OTP_controller.value.text.trim()))
        as Map<String, dynamic>;
    if (information != null) {
      StoreController.OTP_found = true as Rx;
      return information;
    } else {
      return StoreController.OTP_controller.update((val) {
        "Password is incorrect";
      }) as Map<String, dynamic>;

    //await db.close();
  }*/
}
