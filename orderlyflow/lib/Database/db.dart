// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'constant.dart';
import 'dart:typed_data';
import 'package:bson/bson.dart';
import 'package:http/http.dart' as http;
import 'db.dart';
import 'dart:developer';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:bson/bson.dart';
import 'package:email_auth/email_auth.dart';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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

    var IDCont = int.parse(StoreController.ID_controller.value.text.trim());
    final information = await coll.findOne(Mongo.where.eq("ID", IDCont))
        as Map<String, dynamic>;
    return information;

    //await db.close();
  }

  static Future<String> getName() async {
    var person = await getInfo();
    var name = person['name'];
    return name;

    //await db.close();
  }

  static Future<Map<String, dynamic>> getID() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    var IDCont = int.parse(StoreController.ID_controller.value.text.trim());
    final id_info = await coll.findOne(Mongo.where.eq("ID", IDCont))
        as Map<String, dynamic>;
    if (id_info != null) {
      StoreController.ID_found.value = true;
      return id_info;
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

    var PassCont = int.parse(StoreController.Pass_controller.value.text.trim());
    final password = await coll.findOne(Mongo.where.eq("password", PassCont))
        as Map<String, dynamic>;

    if (password != null) {
      StoreController.Pass_found.value = true;
      return password;
    } else {
      return StoreController.ID_controller.update((val) {
        "Password is incorrect";
      }) as Map<String, dynamic>;
    }

    //await db.close();
  }

  static Future<Map<String, dynamic>> getOTP() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    var OTPCont = int.parse(StoreController.OTP_controller.value.text.trim());
    final otp_info = await coll.findOne(Mongo.where.eq("OTP", OTPCont))
        as Map<String, dynamic>;
    if (otp_info != null) {
      StoreController.OTP_found.value = true;
      return otp_info;
    } else {
      return StoreController.OTP_controller.update((val) {
        "OTP is incorrect";
      }) as Map<String, dynamic>;

      //await db.close();
    }
  }

  static Future<bool> Verify_LogIn() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();
    var OTPCont = int.parse(StoreController.OTP_controller.value.text.trim());
    var PassCont = int.parse(StoreController.Pass_controller.value.text.trim());
    var IDCont = int.parse(StoreController.ID_controller.value.text.trim());
    final id_info = await coll.findOne(Mongo.where.eq("ID", IDCont));
    if (id_info != null &&
        id_info['OTP'] == OTPCont &&
        id_info['password'] == PassCont) {
      StoreController.Login_found.value = true;
      return true;
    } else {
      return false;
    }
  }

  static Future<ImageProvider> getProfilePic() async {
    final collection = db.collection(personsCol);
    final document = await collection.findOne(Mongo.where
        .eq("ID", int.parse(StoreController.ID_controller.value.text.trim())));
    final photoData = document!['profilePicture'];

    Uint8List photoBytes = base64Decode(photoData);
    ImageProvider imageProvider = MemoryImage(photoBytes);
    return imageProvider;
  }

  static Future<List<Map<String, dynamic>>> renderReceivers() async {
    final recentChat = db.collection(chatsCol);
    final persons = db.collection(personsCol);
    List<List<int>> users = [];
    List<dynamic> recList = [];

    var usersList = await recentChat.find({'users': 100001}).toList();

    usersList.forEach((item) {
      if (item.containsKey('users')) {
        users.add(List<int>.from(item['users']));
      }
    });

    List<int> flattenedList = [];

    users.forEach((subList) {
      flattenedList.addAll(subList);
    });

    flattenedList.removeWhere((number) =>
        number == int.parse(StoreController.ID_controller.value.text.trim()));
    if (flattenedList.isNotEmpty) {
      for (var receiver in flattenedList) {
        var user = await persons.findOne(where.eq("ID", receiver));
        // print("user");
        //print(user);
        if (user != null) {
          recList.add(user);
        }
      }
      //print(recList);
      return List<Map<String, dynamic>>.from(recList);
    } else {
      return [];
    }
  }

  static void getMsgs() async {
    final msgCol = db.collection(chathistoryCol);
    final messages = await msgCol.get();
    for (var message in messages) {}
  }

  static Future<Map<String, dynamic>> sendMsg(
      int reciver, String content) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(chathistoryCol);
    await db1.open();
    int sender = int.parse(StoreController.ID_controller.value.text.trim());
    Map<String, dynamic> doc = {
      "sender": sender,
      "datetime": DateTime.now(),
      "content": content,
      "reciver": reciver,
    };
    final info = coll.insertOne(doc);
    StoreController.isSendingMessage = false.obs;
    StoreController.Message_controller.value.clear();
    return doc;
  }

  static Future sendEmail() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    var IDCont = int.parse(StoreController.ID_controller.value.text.trim());
    final rec = await coll.findOne(Mongo.where.eq("ID", IDCont));
    final recEmail = rec!['email'];

    final random = Random();
    final otp = random.nextInt(9999).toString().padLeft(4, '0');
    String OTPmessage = 'Your OTP is: $otp';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_tinvhpr';
    const templateId = 'template_wit7sy5';
    const userId = '55Nno5HEZIhwen4fN';
    print("starting email sending");
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {'to_email': recEmail, 'message': OTPmessage}
          }));

      print('Email successfully sent!');
      coll.modernUpdate(where.eq('ID', IDCont),
          ModifierBuilder().set('OTP', {'$Int32': otp}));
      return response.statusCode;
    } catch (error) {
      print('Error sending email: $error');
      return null;
    }
  }

  static Future<Object> searchFor() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    //print(StoreController.searchController.value.text.toLowerCase().trim());
    final name_info = await coll.find({
      'name': {
        '\$regex': StoreController.searchController.value.text.toString()
      }
    })
        //StoreController.searchController.value.text))
        as Map<String, dynamic>;
    print(name_info);
    if (name_info != null) {
      return name_info;
    } else {
      return "" as Map<String, dynamic>;
    }
  }
}
  /*static Future<Map<String, dynamic>> insertDoc(
      int id, String docName, String content) async {
    //final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db.collection(documentsCol);
    //await db1.open();
    final bytes = await File(content).readAsBytes();
    final encoded = base64Encode(bytes);
    Map<String, dynamic> doc = {
      "docID": id,
      "docName": docName,
      "content": encoded
    };
    final info = coll.insertOne(doc);
    print(encoded);
    return doc;
// hr reserved
  }
}*/



