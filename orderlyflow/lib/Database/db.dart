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
import 'db.dart';
import 'dart:developer';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:bson/bson.dart';
import 'package:email_auth/email_auth.dart';

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
    print("List of users");
    print(flattenedList);
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
      "reciver": reciver,
      "datetime": DateTime.now(),
      "content": content
    };
    final info = coll.insertOne(doc);
    StoreController.isSendingMessage = false.obs;
    StoreController.Message_controller.value.clear();
    return doc;
  }

  static Future<Map<String, dynamic>> searchFor() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();

    //print(StoreController.searchController.value.text.toLowerCase().trim());
    final name_info = await coll.findOne(
            Mongo.where.eq('name', StoreController.searchController.value.text))
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

/*EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");
void sendOtp() async {
  bool result = await emailAuth.sendOtp(
      recipientMail: 'mira13.mc@gmail.com', otpLength: 4);
  // recipientMail: _emailcontroller.value.text, otpLength: 4);
}*/
/*static Future<String> sendingSMS(int otp, int nbr) async {
    //final db = await Mongo.Db.create(mongoDB_URL);
    //final coll = db.collection(personsCol);
    //await db.open();

    //final phoneNumber = (await getInfo())['phone_number'] as int;
    const phoneNumber = 96171119085;
    var random = new Random();
    int otpSend = random.nextInt(999999);
    String result = await sendSMS(otpSend, phoneNumber);
    return result;
  }*/

/*static void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }*/

/*static Future<void> sendOTP() async {
    final db = await Mongo.Db.create(mongoDB_URL);
    final coll = db.collection(personsCol);
    await db.open();

    final targetID = await coll.findOne(Mongo.where
            .eq("_id", StoreController.ID_controller.value.text.trim()))
        as Map<int, dynamic>;
    //final phoneNumber = targetID['phone_number'] as String;
    const phoneNumber = '96171119085';
    var random = new Random();
    int otpSend = random.nextInt(999999);

    SmsSender sender = new SmsSender();
    sender.sendSms(new SmsMessage(phoneNumber, 'Your OTP is: $otpSend'));
  }*/
//////////////////////////WORKS BUT CONSIDERS USER AS SENDER/////////////////////////
/*void sendingSMS() async {
  /*var url = Uri.parse("sms:96171119085");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }*/
  final emailAddress = 'mira13.mc@gmail.com';
  final subject = 'This is a test';
  var random = new Random();
  int otpSend = random.nextInt(999999);
  final body = otpSend.toString();

  final Uri mailToUri =
      Uri(scheme: 'mailto', path: 'mira13.mc@gmail.com', queryParameters: {
    'subject': "Your OTP is $otpSend",
    'body': "Test done",
    'from': 'overranter@gmail.com',
  });
  //print(mailToUri.toString());
  if (await canLaunchUrl(mailToUri)) {
    await launchUrl(mailToUri);
  } else {
    throw 'Could not launch $mailToUri';
  }
}*/

