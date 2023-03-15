// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
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

  static Future<List<int>> getProfilePic() async {
    final collection = db.collection("fs.chunks");
    final document = await collection.findOne(Mongo.where.eq("n", 0));
    final photoData = document['data'];
    List<int> imageBytes = photoData.readAsBytesSync();
    //Uint8List bsonBytes = base64Decode(photoData);
    Uint8List bsonData = Uint8List.fromList(imageBytes);
    Map<String, dynamic> bson = BSON().deserialize(BsonBinary.from(bsonData));
    String jsonString = jsonEncode(bson);
    List<int> bytes = jsonString.codeUnits;
    /*var bsonData = BSON().deserialize(BsonBinary.from(bsonBytes));
    BsonBinary bsonBinary = BsonBinary.from(bsonData['data']);
    Uint8List bytes = Uint8List.fromList(bsonBinary.byteList!);
    //return MemoryImage(bytes);*/
    return bytes;
  }
}

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
