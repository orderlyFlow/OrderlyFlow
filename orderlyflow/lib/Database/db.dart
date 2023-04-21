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
import 'package:orderlyflow/Pages/MainPage/tasks.dart';
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

  static Future<Map<String, dynamic>> getPersonByID(int Rec_ID) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();
    final othersInformation = await coll.findOne(Mongo.where.eq("ID", Rec_ID))
        as Map<String, dynamic>;
    if (othersInformation != null) {
      return othersInformation;
    } else {
      return null as Map<String, dynamic>;
    }

    //await db.close();
  }

  static Future<List<Tasks>> getTask() async {
    var id = await getInfo();
    var getId = id["ID"];
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final col1 = db1.collection(tasksCol);
    await db1.open();
    final getuser = await col1
        .find(where.eq('Employees', {
          '\$elemMatch': {'\$eq': getId}
        }))
        .toList();

    return getuser
        .map((e) =>
            Tasks(ID: e['TaskID'], name: e['taskName'], status: e['status']))
        .toList();
  }

  static Future<Map<String,dynamic>> getTeams() async{
    var id = await getInfo();
    var directorID = id['ID'];
    final db = await Mongo.Db.create(mongoDB_URL);
    final coll = db.collection(teamsCol);
    await db.open();
    final info = await coll.findOne(Mongo.where.eq('director', directorID)) as Map<String, dynamic>;
    return info;
  }

    static Future<List<String>> fetchNamesForIds() async {
    var idlist = await getIds(); 
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(personsCol);
    await db1.open();
    List<String> names = <String>[];
    Map<String, dynamic> document;
    for (int i = 0; i < idlist.length; i++) {
      document = await collection.findOne(Mongo.where.eq("ID", idlist[i]))
          as Map<String, dynamic>;
      names.add(document["name"]);
    }

    return names;
  }


  static Future<List<int>> getIds() async {
    var ID = await getInfo();
    var id = ID['ID'];
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db.collection(teamsCol);
    await db1.open();
    final team = await coll.findOne(Mongo.where.eq("director", id));
    final teamMembers = (team["members"] as List<dynamic>).cast<int>().toList();
    return teamMembers;
  }

  static Future<Map<String, dynamic>> getNotes() async {
    var id = await getInfo();
    var notesId = id['ID'];
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(notesCol);
    await db1.open();

    final info = await coll.findOne(Mongo.where.eq("employeeID", notesId))
        as Map<String, dynamic>;

    return info;
  }

  static Future<Map <String,dynamic>> getTeamName() async{
    var id = await getInfo();
    int team = id['ID'];
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(teamsCol);
    await db1.open();

    if(team.toString().startsWith('1')){
      team = 100000;
    } else if(team.toString().startsWith('2')){
      team = 200000;
    } else if(team.toString().startsWith('3')){
      team = 300000;
    } else if (team.toString().startsWith('4')){
      team = 400000;
    } else if(team.toString().startsWith('5')){
      team = 500000;
    } else if(team.toString().startsWith('6')){
      team = 600000;
    } else if(team.toString().startsWith('7')){
      team = 700000;
    } else if(team.toString().startsWith('8')){
      team = 800000;
    } else {
      team = 900000;
    }

  final info =await coll.findOne(Mongo.where.eq("director", team)) as Map<String, dynamic>;
  return info;

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
        if (user != null) {
          recList.add(user);
        }
      }
      return List<Map<String, dynamic>>.from(recList);
    } else {
      return [];
    }
  }

  /*static void getMsgs() async {
    final msgCol = db.collection(chathistoryCol);
    final messages = await msgCol.get();
    for (var message in messages) {}
  }*/

  static Future<List<Map<String, dynamic>>> sendMsg(
      int rec, String content) async {
    final coll = db.collection(chathistoryCol);
    int sender = int.parse(StoreController.ID_controller.value.text.trim());

    Map<String, dynamic> doc = {
      "sender": sender,
      "datetime": DateTime.now(),
      "content": content,
      "receiver": rec,
    };
    List<Map<String, dynamic>> list = [];
    final info = coll.insertOne(doc);
    list.add(doc);
    StoreController.isSendingMessage = false.obs;
    StoreController.Message_controller.value.clear();
    return list;
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
    //print("starting email sending");
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
      int intOTP = int.parse(otp);
      coll.modernUpdate(
          where.eq('ID', IDCont), ModifierBuilder().set('OTP', intOTP));
      return response.statusCode;
    } catch (error) {
      print('Error sending email: $error');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> searchFor() async {
    //final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db.collection(personsCol);
    //await db1.open();

    final name_info = await coll.find({
      'name': {
        '\$regex': StoreController.searchController.value.text.trim(),
        '\$options': 'i'
      }
    }).toList();
    for (var name in name_info) {
      print(name['ID'].toString());
    }
    if (name_info != null) {
      print('found');
      return name_info;
    } else {
      print('not found');
      return "" as List<Map<String, dynamic>>;
    }
  }

  static Future<dynamic> getSalary() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(payrollCol);
    await db1.open();
    int user = int.parse(StoreController.ID_controller.value.text.trim());
    final sal_info =
        await coll.findOne(Mongo.where.eq("ID", user)) as Map<String, dynamic>;
    return sal_info;
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



