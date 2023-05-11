import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class requestList extends StatefulWidget {
  List<String> docNames;
  requestList({super.key, required this.docNames});

  @override
  State<requestList> createState() => _requestListState();
}

class _requestListState extends State<requestList> {
  // static Future<Map<String, dynamic>> logDocumentRequest(String docName) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int counter = prefs.getInt('counter') ?? 0;

  //   final db1 = await Mongo.Db.create(mongoDB_URL);
  //   final collection = db1.collection(documentRequestCol);
  //   await db1.open();

  //   final document = {
  //     "requestID": counter,
  //     "userID": int.parse(StoreController.ID_controller.value.text.trim()),
  //     "documentName": docName,
  //     "DateTime": DateTime.now()
  //   };
  //   counter++;
  //   prefs.setInt('counter', counter);
  //   collection.insertOne(document);

  //   return document;
  // }

  static Future<void> requestDocument(String docName) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(documentsCol);
    await db1.open();
    Map<String, dynamic> document = await collection
        .findOne(Mongo.where.eq("docName", docName)) as Map<String, dynamic>;
    dynamic content = document["content"];
    downloadDocument(content);
    // logDocumentRequest(docName);
    print("success");
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

  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        height: ScreenHeight * 0.7,
        margin: EdgeInsets.only(left: ScreenWidth* 0.01, right: ScreenWidth * 0.01),
        child: ListView.builder(
          itemCount: widget.docNames.length,
          itemBuilder: (BuildContext, int index) {
            String docName = widget.docNames[index];
            return Container(
              height: ScreenHeight * 0.15,
              width: ScreenWidth * 0.4,
              decoration: BoxDecoration(
                color: Paletter.containerLight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/doc.png',
                    width: ScreenHeight * 0.1,
                  ),
                  SizedBox(
                    width: ScreenWidth * 0.01,
                  ),
                  Text(
                    docName,
                    style: TextStyle(
                      color: Paletter.blackText,
                      fontSize: ScreenHeight * 0.02,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'conthrax',
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      requestDocument(docName);
                    },
                    icon: Icon(
                      Icons.download,
                      color: Paletter.blackText,
                      size: ScreenHeight * 0.03,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
