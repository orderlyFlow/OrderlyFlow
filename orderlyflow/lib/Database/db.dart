import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    //print(status);
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
  }

// get doc name
  static Future<List<String>> getDocNames() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(documentsCol);
    await db1.open();
    final docs = await coll.find().toList();
    final docNames = docs.map((doc) => doc['docName'] as String).toList();
    return docNames;
  }

// get base 64 content
  static Future<List<String>> getDocContent() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(documentsCol);
    await db1.open();
    final docs = await coll.find().toList();
    final docContent = docs.map((doc) => doc['content'] as String).toList();
    return docContent;
  }

  static Future<List<Tasks>> getTask() async {
    var id = int.parse(StoreController.ID_controller.value.text.trim());
    final col1 = db.collection(tasksCol);
    if (StoreController.renderedTasks.isEmpty) {
      final getuser = await col1
          .find(where.eq('Employees', {
            '\$elemMatch': {'\$eq': id}
          }))
          .toList();
      //print("In task fct");
      var tasksList = getuser
          .map<Tasks>((e) =>
              Tasks(ID: e['TaskID'], name: e['taskName'], status: e['status']))
          .toList();
      StoreController.renderedTasks = tasksList;
      return tasksList;
    } else {
      return [];
    }
  }

  static Future<Map<String, dynamic>> getTeams() async {
    var id = await getInfo();
    var directorID = id['ID'];
    final db = await Mongo.Db.create(mongoDB_URL);
    final coll = db.collection(teamsCol);
    await db.open();
    final info = await coll.findOne(Mongo.where.eq('director', directorID))
        as Map<String, dynamic>;
    return info;
  }

  static Future<List<int>> getIdsFordirector() async {
    var userID = StoreController.currentUser!['ID'];
    var membersIDs = [];
    String nStr = userID.toString();
    String firstDigit = nStr[0];
    String id = firstDigit + ('00000');
    final coll = db.collection(teamsCol);
    final team = await coll.findOne(Mongo.where.eq("director", int.parse(id)));
    final teamMembers = (team["members"] as List<dynamic>).cast<int>().toList();
    StoreController.teamMemberIDs = teamMembers;
    //print('team members');
    //print(teamMembers.toString());
    return teamMembers;
  }

  static Future<List<String>> fetchNamesForIds() async {
    if (StoreController.teamMembersName.isEmpty) {
      var idlist = await getIdsFordirector();
      final collection = db.collection(personsCol);
      List<String> names = <String>[];
      Map<String, dynamic> document;
      for (int i = 0; i < idlist.length; i++) {
        document = await collection.findOne(Mongo.where.eq("ID", idlist[i]))
            as Map<String, dynamic>;
        StoreController.teamMembers.add(document);
        //print(StoreController.teamMembers.length);
        StoreController.teamMembersName.add(document['name']);
      }
      return StoreController.teamMembersName;
    } else {
      return StoreController.teamMembersName;
    }
  }

  static Future<Map<String, dynamic>> getTasks() async {
    var id = StoreController.currentUser!['ID'];
    var taskID = id["ID"];
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(tasksCol);
    await db1.open();

    final information = await coll.findOne(Mongo.where.eq("_id", taskID))
        as Map<String, dynamic>;

    return information;
  }

  static Future<Map<String, dynamic>> getTeamInfo() async {
    var id = StoreController.currentUser!['ID'];
    final coll = db.collection(teamsCol);
    var document = await coll.findOne({'members': id});
    var info = document as Map<String, dynamic>;
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
      StoreController.isDirector = isDirectorLogin(IDCont).obs;
      StoreController.isHR = isHR_atLogin(IDCont).obs;
      StoreController.Login_found.value = true;
      StoreController.currentUser = id_info;
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
      int receiver, String content) async {
    final coll = db.collection(chathistoryCol);
    int sender = int.parse(StoreController.ID_controller.value.text.trim());
    Map<String, dynamic> doc = {
      "sender": sender,
      "receiver": receiver,
      "datetime": DateTime.now().toLocal(),
      "content": content
    };
    final info = coll.insertOne(doc);
    //print(doc);
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

  static Future<dynamic> requestDocument(String docName) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(documentsCol);
    await db1.open();
    Map<String, dynamic> document = await collection
        .findOne(where.eq("docName", docName)) as Map<String, dynamic>;
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

  static Future<bool> getChats() async {
    final recentChat = db.collection(chatsCol);
    final persons = db.collection(personsCol);
    List<List<int>> users = [];
    List<dynamic> recList = [];
    List<dynamic> groups = [];
    var usersList = await recentChat.find({
      'users': int.parse(StoreController.ID_controller.value.text.trim())
    }).toList();
    usersList.forEach((item) {
      if (item['isGroup'] == false) {
        users.add(List<int>.from(item['users']));
      } else {
        StoreController.groups.add(item);
      }
    });

    users.forEach((subList) {
      StoreController.individualRecIDs.addAll(subList);
    });
    StoreController.individualRecIDs.removeWhere((number) =>
        number == int.parse(StoreController.ID_controller.value.text.trim()));
    if (StoreController.individualRecIDs.isNotEmpty ||
        StoreController.groups.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getIndRec() async {
    if (StoreController.AllChats.isEmpty) {
      bool foundChats = await MongoDB.getChats();
      final persons = db.collection(personsCol);
      List<dynamic> recList = [];
      if (StoreController.individualRecIDs.isNotEmpty && foundChats == true) {
        for (var receiver in StoreController.individualRecIDs) {
          var user = await persons.findOne(where.eq("ID", receiver));
          if (user != null) {
            recList.add(user);
          }
        }
        StoreController.AllChats = List<Map<String, dynamic>>.from(recList);
      }
      StoreController.AllChats.add(StoreController.groups[0]);
      return StoreController.AllChats;
    } else {
      return StoreController.AllChats;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAll() async {
    if (StoreController.allUsers.isEmpty) {
      final coll = db.collection(personsCol);
      final pers_info = await coll.find().toList();
      if (pers_info != null) {
        StoreController.allUsers = pers_info;
        return StoreController.allUsers;
      } else {
        return [];
      }
    } else {
      return StoreController.allUsers;
    }
  }

  static Future<Map<String, dynamic>> getNotes() async {
    var id = StoreController.currentUser!['ID'];
    final coll = db.collection(notesCol);
    final info = await coll.findOne(Mongo.where.eq("noteID", id))
        as Map<String, dynamic>;

    return info;
  }

  static Future<Map<String, dynamic>> logDocumentRequest(String docName) async {
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

  static Future<List<dynamic>> getEmployeesByTeamId(int teamId) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(teamsCol);
    await db1.open();
    try {
      final teams = db.collection('Teams');
      final result = await collection.findOne(where.eq('teamID', teamId));
      if (result == null) {
        //print('No document found with teamID: $teamId');
        return [];
      }
      final employees = result['members'] ?? [];
      //print('Employees found: $employees');
      return employees;
    } catch (e) {
      //print('Error retrieving employees: $e');
      return [];
    }
  }

  static String getEmployeeTeam(int employeeId) {
    String team;
    int firstDigit = employeeId ~/ 100000;

    switch (firstDigit) {
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

  static void addMeeting(String subject) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    int counter1 = prefs1.getInt('counter') ?? 0;

    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(meetingsCol);
    await db1.open();
    final directorID =
        int.parse(StoreController.ID_controller.value.text.trim());
    final document = {
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

  static Future<void> addTask(
      int TaskID, String taskname, List<int> employees) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(tasksCol);
    await db1.open();

    final document = {
      "TaskID": TaskID,
      "taskname": taskname,
      "Employees": employees,
      "status": false
    };

    collection.insertOne(document);
  }

  static void addSearchedUserToDB() {
    final coll = db.collection(chatsCol);
    int sender = int.parse(StoreController.ID_controller.value.text.trim());
    int searchedU = StoreController.Searched_ID.value;
    Map<String, dynamic> doc = {
      "users": [sender, searchedU],
      "isGroup": false,
      "Lastupdated": DateTime.now(),
    };
    coll.insertOne(doc);
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
    if (name_info != null) {
      return name_info;
    } else {
      //print('not found');
      return "" as List<Map<String, dynamic>>;
    }
  }

  static Future<dynamic> getSalary() async {
    //final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db.collection(payrollCol);
    //await db1.open();
    int user = int.parse(StoreController.ID_controller.value.text.trim());
    final sal_info =
        await coll.findOne(Mongo.where.eq("ID", user)) as Map<String, dynamic>;
    return sal_info;
  }

  static Stream<List<Map<String, dynamic>>> getEventsOnSelectedDate(
      DateTime selectedDate) async* {
    final eventsCollection = db.collection(eventsCol);
    final startDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
            .toUtc();
    final endDate = startDate.add(Duration(days: 1));
    final events = await eventsCollection
        .find(where.gte('startTime', startDate).lt('startTime', endDate))
        .toList();
    Stream<List<Map<String, dynamic>>> eventsStream =
        Stream.fromIterable([events]);

    yield* eventsStream;
  }

  static bool isDirectorLogin(int n) {
    String nStr = n.toString();
    for (int i = 1; i < nStr.length; i++) {
      if (nStr[i] != "0") {
        return false;
      }
    }
    return true;
  }

  static bool isHR_atLogin(int n) {
    String nStr = n.toString();
    if (nStr[0] == "2") {
      return true;
    }
    return false;
  }

  static List<int> getParticipants(String text) {
    List<int> participants = [];
    List<String> participantStrings = text.split(',');
    for (String participantString in participantStrings) {
      String participant = participantString.trim();
      if (participant.isNotEmpty) {
        participants.add(int.parse(participant));
      }
    }
    return participants;
  }

  static void addEventToDB(String event_title, String event_location,
      String desc, String part, DateTime start, DateTime end) {
    final coll = db.collection(eventsCol);
    List<int> participants = getParticipants(part);

    Map<String, dynamic> doc = {
      "title": event_title,
      "location": event_location,
      "startTime": start,
      "endTime": end,
      "participants": participants,
      "eventDescription": desc,
    };
    List<Map<String, dynamic>> list = [];
    final info = coll.insertOne(doc);
  }

  static Future<dynamic> getSalaryhr(int IDUser) async {
    final coll = db.collection(payrollCol);
    final sal_info = await coll.findOne(Mongo.where.eq("ID", IDUser))
        as Map<String, dynamic>;
    return sal_info;
  }

  static Future<Map<String, dynamic>> requestDocumentfile(int uploderID) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(documentsFiled);
    // final await db1.open();
    final document =
        await collection.findOne((Mongo.where.eq("uploderID", uploderID)))
            as Map<String, dynamic>;
    dynamic content = document["base64"];
    downloadDocument(content);
    print("success");
    return document;
  }

  static Future<List<dynamic>> getIndividualForms() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection('DocumentsFiled');
    await db1.open();

    final documents = await coll
        .find(where.eq("uploaderID", StoreController.selectedUser!['ID']))
        .toList();
    return documents;
  }

  static changeAttribute(attribute, value) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(personsCol);
    await db1.open();

    final document = await collection
        .findOne(Mongo.where.eq("ID", StoreController.selectedUser!['ID']));
    //print(attribute);
    //print(value);
    collection.updateOne(document, Mongo.modify.set(attribute, value));
  }

  static Future<List<dynamic>> getIndividualForms1() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection('DocumentsFiled');
    await db1.open();
    final documents = await coll.find().toList();
    return documents;
  }

  static changeAttributeInt(attribute, value) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(personsCol);
    await db1.open();

    final document = await collection
        .findOne(Mongo.where.eq("ID", StoreController.selectedUser!['ID']));

    collection.updateOne(
        document, Mongo.modify.set(attribute, int.parse(value)));
  }
}
