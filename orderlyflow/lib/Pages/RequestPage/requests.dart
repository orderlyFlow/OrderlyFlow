import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/Pages/RequestPage/ListofRequest.dart';
import 'package:orderlyflow/Pages/RequestPage/addRequestButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orderlyflow/custom_widgets/BlueBg.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;

class requests extends StatefulWidget {
  const requests({super.key});

  @override
  State<requests> createState() => _requestsState();
}

class _requestsState extends State<requests> {
  bool _isUpload = false;

  static void uploadFiledDocs() async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final coll = db1.collection(documentsFiled);
    await db1.open();

    final base64 = await openFilePicker();

    final document = {
      "uploaderID": int.parse(StoreController.ID_controller.value.text.trim()),
      "base64": base64,
      "Date": DateTime.now()
    };

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
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          const BlueBg(),
          Row(
            children: [
              SideBar(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0.01 * ScreenWidth,
                    0.02 * ScreenHeight,
                    0.01 * ScreenWidth,
                    0.02 * ScreenHeight),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: ScreenWidth * 0.4,
                          height: ScreenHeight * 0.96,
                          decoration: BoxDecoration(
                              color: Paletter.containerDark,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Container(
                                  width: ScreenWidth * 0.6,
                                  height: ScreenHeight * 0.05,
                                  alignment: Alignment.topCenter,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(97, 127, 187, 1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  )),
                              SizedBox(
                                height: ScreenHeight * 0.02,
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenWidth * 0.02),
                                      child: Text(
                                        "Forms",
                                        style: TextStyle(
                                          color: Paletter.blackText,
                                          fontFamily: 'iceland',
                                          fontSize: ScreenHeight * 0.07,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenWidth * 0.03,
                                  ),
                                  FutureBuilder(
                                      future: MongoDB.getInfo(),
                                      builder: (buildContext,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasError) {
                                          return Text('${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          var userID = snapshot.data["ID"];
                                          return addReq(ID: userID);
                                        } else {
                                          return CircularProgressIndicator(
                                            color: Colors.white,
                                          );
                                        }
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: ScreenHeight * 0.02,
                              ),
                              Container(
                                child: FutureBuilder(
                                    future: Future.wait([
                                      MongoDB.getDocNames(),
                                    ]),
                                    builder:
                                        (buildContext, AsyncSnapshot snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        List<String> docNames =
                                            snapshot.data[0];
                                        return requestList(docNames: docNames);
                                      } else {
                                        return CircularProgressIndicator(
                                          color: Colors.white,
                                        );
                                      }
                                    }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: ScreenWidth * 0.01,
                        ),
                        Column(
                          children: [
                            Container(
                              height: ScreenHeight * 0.96,
                              width: ScreenWidth * 0.5,
                              decoration: BoxDecoration(
                                  color: Paletter.containerLight,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Center(
                                child: InkWell(
                                  onHover: (isHovered) =>
                                      setState(() => _isUpload = isHovered),
                                  child: Image.asset(
                                    _isUpload
                                        ? 'assets/images/cloud-computingHover.png'
                                        : 'assets/images/cloud-computing.png',
                                    height: ScreenHeight * 0.1,
                                    width: ScreenWidth * 0.23,
                                  ),
                                  onTap: () {
                                    uploadFiledDocs();
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
