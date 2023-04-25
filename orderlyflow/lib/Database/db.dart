// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
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
import 'dart:io';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  static Future<Map<String, dynamic>> getTasks() async {
    var id = await getInfo();
    var taskID = id["ID"];
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(tasksCol);
    await db1.open();

    final information = await coll.findOne(Mongo.where.eq("_id", taskID))
        as Map<String, dynamic>;

    return information;
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
    print(doc);
    return doc;
// working
  }

  static Future<void> insertImage(id, image) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(personsCol);
    await db1.open();
    final bytes = await File(image).readAsBytes();
    final encoded = base64Encode(bytes) as String;
    //print(encoded);
    coll.updateOne(
        Mongo.where.eq("ID", id), Mongo.modify.set("profilePicture", encoded));
        print("succsess");
  }

  static Future<Map<String, dynamic>> insertDoc(
      int id, String docName, String content) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(documentsCol);
    await db1.open();
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
// working
// hr reserved
  }



   static Future <dynamic> requestDocument(String docName)async{
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(documentsCol);
    await db1.open();
    Map<String, dynamic> document = await collection.findOne(where.eq("docName", docName)) as Map<String, dynamic> ;
     dynamic content = document["content"];
     downloadDocument(content);
     logDocumentRequest(docName);
     print("success");
     return content;

  }

 static Future<void> downloadDocument(String base64String) async {
  try {
    
    List<int> bytes = base64.decode(base64String);

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/document.docx';

  
    final file = File(path);
    await file.writeAsBytes(bytes);

    
    await Process.run('explorer', [path]);
  } catch (e) {
    debugPrint(e.toString());
  }
}


static Future<Map<String,dynamic>> logDocumentRequest(String docName )async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = prefs.getInt('counter') ?? 0;

   final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(documentRequestCol);
    await db1.open();
  
  final document = {
    "requestID": counter,
    "userID": int.parse(StoreController.ID_controller.value.text.trim()),
    "documentName": docName,
    "DateTime": DateTime.now()
  };
  counter++;
  prefs.setInt('counter', counter);
  collection.insertOne(document);

  return document;


}



static Future<List<String>> getDocNames() async {
   final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(documentsCol);
    await db1.open();

  final docs = await collection.find().toList();

  final docNames = docs.map((doc) => doc['docName'] as String).toList();

  print(docNames);

  await db.close();

  return docNames;
}

 /* static void updateStatus(String taskname) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(tasksCol);
    await db1.open();

    coll.updateOne(
        Mongo.where.eq("taskName", taskname), Mongo.modify.set("status", true));
    print("called");
    //not working ( most likely wrong query)
  }*/

  static Future<List<String>> fetchNamesForIds(List<int> idList) async {
  final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(personsCol);
    await db1.open();
   List<String> names = <String>[];
  Map<String,dynamic> document ;
  for (int i = 0; i < idList.length; i++) {
    document = await collection.findOne(where.eq("ID", idList[i])) as  Map<String,dynamic>;
    names.add(document["name"]);
  }


  return names;
}

static Future<List<dynamic>> getEmployeesByTeamId(int teamId) async {
  final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(teamsCol);
    await db1.open();
  try {
    
    print('Database connection opened successfully');
    final teams = db.collection('Teams');
    final result = await collection.findOne(where.eq('teamID', teamId));
    if (result == null) {
      print('No document found with teamID: $teamId');
      return [];
    }
    final employees = result['members'] ?? [];
    print('Employees found: $employees');
    return employees;
  } catch (e) {
    print('Error retrieving employees: $e');
    return [];
  } 
}

static String getEmployeeTeam(int employeeId) {
  String team;
  int firstDigit = employeeId ~/ 100000; // Get the first digit of the employee ID
  
  switch(firstDigit) {
    case 1:
      team = 'Legal Team';
      break;
    case 2:
      team = 'Human Resources Team';
      break;
    case 3:
      team = 'Development Team';
      break;
    case 4:
      team = 'Design Team';
      break;
    case 5:
      team = 'Marketing Team';
      break;
    case 6:
      team = 'Accounting Team';
      break;
    default:
      team = 'Unknown Team';
  }
  
  return team;
}
static void addMeeting(String subject)async{
SharedPreferences prefs1 = await SharedPreferences.getInstance();
  int counter1 = prefs1.getInt('counter') ?? 0;

   final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(meetingsCol);
    await db1.open();
final directorID = int.parse(StoreController.ID_controller.value.text.trim());
final document =  {
 "MeetingID": counter1, 
"Director": directorID,
"TeamName": getEmployeeTeam(directorID),
"subject": subject,
"DateTime": DateTime.now()
};

collection.insertOne(document);
counter1++;
  prefs1.setInt('counter', counter1);

  
}

 


  
  /*static Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

    return filePath;
  }*/

  /*List<int> getEmps(){
  
    List arr
  }*/

  static Future<void> addTask(int TaskID, String taskname,List<int> employees) async{
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(tasksCol);
    await db1.open();

final document = {
  "TaskID":  TaskID,
  "taskname":taskname,
  "Employees": employees,
  "status": false
};
  
  collection.insertOne(document);
  }

  static Future <dynamic> getsalary(int id)async{
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(payrollCol);
    await db1.open();
    Map<String, dynamic> document = await collection.findOne(where.eq("ID", id)) as Map<String, dynamic> ;
     dynamic salary = document["basepay"];
     print(salary);
     return salary;

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
