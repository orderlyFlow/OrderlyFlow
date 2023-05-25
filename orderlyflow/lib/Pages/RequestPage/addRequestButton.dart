// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/Database/constant.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Pages/RequestPage/requests.dart';

import '../../custom_widgets/palette.dart';

class addReq extends StatefulWidget {
  int ID;
  addReq({super.key, required this.ID});

  @override
  State<addReq> createState() => _addReqState();
}

class _addReqState extends State<addReq> {
  late TextEditingController reqController = TextEditingController();
  late int id;
  bool _isHRorHead = false;

  void checkID() async {
    final db = await Mongo.Db.create(mongoDB_URL);
    await db.open();
    final coll = db.collection(tasksCol);
    final idList = await coll.find().map((task) => task['TaskID']).toList();
    int ID = 1000;
    while (idList.contains(ID)) {
      ID++;
    }
    late String? reqName = reqController.text;
    createNewForm(ID, reqName);
  }

  void close(){
        Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => requests(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  static void createNewForm(int docID, String docName) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(documentsCol);
    await db1.open();

    final base64 = await openFilePicker();

    final document = {"docID": docID, "docName": docName, "content": base64};

    coll.insertOne(document);
    print("uploaded");
  }

  static Future<String> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx'],
    );

    if (result == null || result.files.isEmpty) {
      print("user canceled");
      return '';
    }

    File file = File(result.files.single.path!);
    List<int> bytes = await file.readAsBytes();

    String base64String = base64Encode(bytes);

    return base64String;
  }

  @override
  void initState() {
    super.initState();
    id = widget.ID;
    String Stringid= id.toString();
    if (Stringid.startsWith('2')) {
      _isHRorHead = true;
    }
    // if(id >=10){
    //   id~/=10;
    // }

    // if (id == 2) {
    //   _isHRorHead = true;
    // }
    // var firstNumber = int.parse(id.toString()[0]);
    // if(firstNumber == "2" ){
    //   _isHRorHead = true;
    // }
    // _isHRorHead = true;
  }

  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    if (_isHRorHead) {
      return Column(
        children: [
          CircleAvatar(
              backgroundColor: Color.fromRGBO(97, 127, 187, 1),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      // isDismissible: false,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return SingleChildScrollView(
                            child: Container(
                              height: ScreenHeight * 0.5,
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: ScreenWidth * 0.001),
                                child: Column(
                                  children: [
                                    Text(
                                      'Add New Request',
                                      style: TextStyle(
                                          fontFamily: 'conthrax',
                                          fontSize: ScreenHeight * 0.03,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: ScreenHeight * 0.05),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenWidth * 0.0001),
                                              margin: EdgeInsets.only(left: ScreenWidth * 0.01),
                                          width: ScreenWidth * 0.4,
                                          child: TextField(
                                            controller: reqController,
                                            decoration: InputDecoration(
                                              hintText: 'Add task name here',
                                            ),
                                          ),
                                        ),
                                        // SizedBox(height: ScreenWidth * 0.03),
                                            Container(
                                          height: ScreenHeight * 0.08,
                                          margin: EdgeInsets.only(right: ScreenWidth * 0.01),
                                          child: ElevatedButton(
                                            onPressed: checkID,
                                            child: Icon(Icons.add),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Paletter.logInBg,
                                                shape: CircleBorder()),
                                          ),
                                        ),
                                          Container(
                                          height: ScreenHeight * 0.08,
                                          margin: EdgeInsets.only(right: ScreenWidth * 0.01),
                                          child: ElevatedButton(
                                            onPressed: close,
                                            child: Icon(Icons.check),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Paletter.logInBg,
                                                shape: CircleBorder()),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      });
                },
              ))
        ],
      );
    } else {
      return Container(
        child: Text(''),
      );
    }
  }
}
