// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:orderlyflow/Database/textControllers.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';

import '../../custom_widgets/BlueBg.dart';
import '../../custom_widgets/palette.dart';
import '../../custom_widgets/side_bar.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => chatPageState();
}

class chatPageState extends State<chatPage> {
  bool isHovered = false;
  bool isVisible = false;
  final StoreController textControllers = Get.put(StoreController());
  //var db;
  Future? _future;

  Future<dynamic> sendData(int Rec_ID) async {
    final data1 = await MongoDB.getPersonByID(Rec_ID);
    final data2 = await MongoDB.getInfo();
    if (data1 != null && data2 != null) {
      return [data1, data2];
    }
  }

  /*Stream<List<Map<String, dynamic>>> getMessageStream() async* {
    db = await Mongo.Db.create(mongoDB_URL);
    int id = int.parse(StoreController.ID_controller.value.text.trim());
    await db.open();
    final messages = await db
        .collection('ChatsHistory')
        .find(Mongo.where.eq("sender", id).or(Mongo.where.eq("receiver", id)))
        .toList();
    var newMessage = MongoDB.sendMsg();
    if (StoreController.isSendingMessage == true) {
      messages.add(newMessage);
    }
    Stream<List<Map<String, dynamic>>> messageStream =
        Stream.fromIterable([messages]);
    yield* messageStream;
  }*/
  late StreamController<List<Map<String, dynamic>>> _streamController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> getMessageStream() async* {
    db = await Mongo.Db.create(mongoDB_URL);
    int id = int.parse(StoreController.ID_controller.value.text.trim());
    await db.open();
    final messages = await db
        .collection('ChatsHistory')
        .find(Mongo.where.eq("sender", id).or(Mongo.where.eq("receiver", id)))
        .toList();
    var newMessage = MongoDB.sendMsg(StoreController.Rec_ID.value,
        StoreController.Message_controller.value.text);
    if (StoreController.isSendingMessage.isTrue) {
      messages.add(newMessage);
    }
    _streamController.add(messages);

    yield* _streamController.stream;
  }

  void disposeOfStream() {
    _streamController.close();
  }

  @override
  void initState() {
    super.initState();
    isHovered = false;
  }

  /*void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });*/
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      const BlueBg(),
      Row(
        children: [
          SideBar(),
          Container(
            margin: EdgeInsets.fromLTRB(
                0.03 * screenWidth, 0.02 * screenHeight, 0.02 * screenWidth, 0),
            height: screenHeight * 0.92,
            width: screenWidth * 0.88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Paletter.mainBgLight,
            ),
            child: Row(children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0.018 * screenWidth,
                            0.07 * screenHeight,
                            0.13 * screenWidth,
                            0.02 * screenHeight),
                        child: Text(
                          'Chats',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'conthrax',
                              color: Colors.black,
                              fontSize: 0.066 * screenHeight),
                        ),
                      ),
                      FutureBuilder(
                          future: MongoDB.getProfilePic(),
                          builder: (buildContext, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, screenHeight * 0.054, 0, 0),
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.08,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: FittedBox(
                                          fit: BoxFit
                                              .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                          ))),
                                ],
                              );
                            } else if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, screenHeight * 0.054, 0, 0),
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.08,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: FittedBox(
                                          fit: BoxFit
                                              .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                          child: CircleAvatar(
                                            backgroundImage: snapshot.data,
                                          ))),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, screenHeight * 0.054, 0, 0),
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.08,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: FittedBox(
                                          fit: BoxFit
                                              .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                          ))),
                                ],
                              );
                            }
                          }),
                    ]),
                    Container(
                      margin: EdgeInsets.only(
                          left: screenWidth * 0.012,
                          top: screenHeight * 0.01,
                          bottom: screenHeight * 0.05),
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: screenWidth * 0,
                              top: screenHeight * 0.02,
                              bottom: screenHeight * 0.05),
                          height: screenHeight * 0.064,
                          width: screenWidth * 0.301,
                          decoration: BoxDecoration(
                            color: Paletter.mainBgLight,
                            border: Border.all(
                              color: Paletter.mainBgLight,
                            ),
                          ),
                          child: SearchInput(),
                        ),
                        Container(
                            height: screenHeight * 0.57,
                            width: screenWidth * 0.382,
                            margin: EdgeInsets.fromLTRB(
                                screenWidth * 0.00280,
                                screenHeight * 0.103,
                                screenWidth * 0,
                                screenHeight * 0.003),
                            child: FutureBuilder<List<Map<String, dynamic>>>(
                              future: MongoDB.renderReceivers(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MouseRegion(
                                            child: Container(
                                                color: Paletter.containerDark,
                                                margin: EdgeInsets.fromLTRB(0,
                                                    0, 0, screenHeight * 0.02),
                                                child: Material(
                                                    color:
                                                        Paletter.containerDark,
                                                    child: ListTile(
                                                      enabled: true,
                                                      hoverColor: Paletter
                                                          .containerLight,
                                                      onTap: () {
                                                        int id = StoreController
                                                                .Rec_ID.value =
                                                            snapshot.data![
                                                                index]['ID'];
                                                        setState(() {
                                                          isVisible =
                                                              !isVisible;
                                                        });
                                                        _future = sendData(id);
                                                        //if (isVisible == false) {
                                                        //disposeOfStream();
                                                        //}
                                                      },
                                                      visualDensity:
                                                          VisualDensity(
                                                              vertical: 1),
                                                      leading: CircleAvatar(
                                                        backgroundImage: MemoryImage(
                                                            base64Decode(snapshot
                                                                        .data![
                                                                    index][
                                                                'profilePicture'])),
                                                      ),
                                                      title: Text(
                                                          snapshot.data![index]
                                                              ['name'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'conthrax',
                                                              fontSize:
                                                                  screenHeight *
                                                                      0.0162)),
                                                    ))));
                                      });
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  return Center(
                                      heightFactor: screenHeight * 0.002,
                                      widthFactor: screenWidth * 0.002,
                                      child: CircularProgressIndicator(
                                        color: Paletter.gradiant1,
                                      ));
                                }
                              },
                            )),
                        Visibility(
                            visible: StoreController.isSearching.value,
                            child: Positioned(
                              top: 1,
                              //left: 50,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: screenWidth * 0.009,
                                      top: screenHeight * 0.085,
                                      bottom: screenHeight * 0.05),
                                  width: screenWidth * 0.285,
                                  height: screenHeight * 0.14,
                                  decoration: BoxDecoration(
                                    color: Paletter.containerLight,
                                  ),
                                  child:
                                      FutureBuilder<List<Map<String, dynamic>>>(
                                          future: MongoDB.searchFor(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              StoreController
                                                  .isSearching.value = true;
                                              return ListView.builder(
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return MouseRegion(
                                                        child: Container(
                                                            color: Colors.white,
                                                            /*margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                0,
                                                                0,
                                                                screenHeight *
                                                                    0.02),*/
                                                            child: ListTile(
                                                              onTap: () {
                                                                StoreController
                                                                    .Searched_ID
                                                                    .value = snapshot
                                                                        .data![
                                                                    index]['ID'];
                                                                StoreController
                                                                        .isSearching
                                                                        .value =
                                                                    !StoreController
                                                                        .isSearching
                                                                        .value;
                                                                StoreController
                                                                    .isSearching
                                                                    .value = false;
                                                              },
                                                              title: Text(
                                                                  snapshot.data![
                                                                          index]
                                                                      ['name'],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'conthrax',
                                                                      fontSize:
                                                                          screenHeight *
                                                                              0.0162)),
                                                            )));
                                                  });
                                            } else if (snapshot.hasData) {
                                              return Center(
                                                  child: Text("Rendering..."));
                                            } else {
                                              return Text(
                                                  snapshot.error.toString());
                                            }
                                          })),
                            )),
                      ]),
                    ),

                    // ),
                    /////////////////////////////////////////////////////////
                  ]),
              Visibility(
                  visible: isVisible,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(screenWidth * 0.01,
                        screenHeight * 0, screenWidth * 0, screenHeight * 0),
                    width: screenWidth * 0.001,
                    height: screenHeight * 0.8,
                    color: Colors.black,
                  )),
              Visibility(
                visible: isVisible,
                child: Container(
                    margin: EdgeInsets.fromLTRB(
                        screenWidth * 0.01,
                        screenHeight * 0.078,
                        screenWidth * 0,
                        screenHeight * 0),
                    width: screenWidth * 0.445,
                    height: screenHeight * 0.853,
                    color: Paletter.mainBgLight,
                    child: Column(children: [
                      Container(
                        height: screenHeight * 0.753,
                        width: screenWidth * 0.445,
                        child: StreamBuilder<List<Map<String, dynamic>>>(
                            stream: getMessageStream(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData ||
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: Paletter.gradiant1,
                                ));
                              } else {
                                if (snapshot.hasData) {
                                  final messages = snapshot.data!.toList();
                                  return ListView.builder(
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      final message = messages[index];
                                      final isSender = message['sender'] ==
                                          int.parse(StoreController
                                              .ID_controller.value.text
                                              .trim());
                                      final textAlign = isSender
                                          ? TextAlign.right
                                          : TextAlign.left;
                                      return Container(
                                        margin: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment: isSender
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                          crossAxisAlignment: isSender
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            /* ((message['sender'] ==
                                                      StoreController
                                                          .Rec_ID.value &&
                                                  message['receiver'] ==
                                                      int.parse(StoreController
                                                          .ID_controller
                                                          .value
                                                          .text
                                                          .trim())) ||
                                              (message['receiver'] ==
                                                      StoreController
                                                          .Rec_ID.value &&
                                                  message['sender'] ==
                                                      int.parse(StoreController
                                                          .ID_controller
                                                          .value
                                                          .text
                                                          .trim())))
                                          ? FutureBuilder(
                                              future: _future,
                                              builder: (context,
                                                  AsyncSnapshot<dynamic> snapshot) {
                                                final otherInfo =
                                                    snapshot.data[0];
                                                final userInfo =
                                                    snapshot.data[1];
                                                if (snapshot.connectionState ==
                                                        ConnectionState
                                                            .waiting ||
                                                    !snapshot.hasData) {
                                                  return Text(
                                                    "person",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          screenHeight * 0.018,
                                                      fontFamily: 'iceland',
                                                    ),
                                                  );
                                                } else {
                                                  if (snapshot.hasError) {
                                                    return Text(
                                                        "snapshot.error");
                                                  } else {
                                                    return Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          isSender
                                                              ? screenWidth * 0
                                                              : screenWidth *
                                                                  0.01,
                                                          screenHeight * 0.0001,
                                                          isSender
                                                              ? screenWidth *
                                                                  0.01
                                                              : screenWidth * 0,
                                                          0),
                                                      child: Text(
                                                        isSender
                                                            ? userInfo['name']
                                                            : otherInfo['name'],
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              screenHeight *
                                                                  0.018,
                                                          fontFamily: 'iceland',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              })
                                          : SizedBox.shrink(),*/
                                            SizedBox(height: 4),
                                            ((message['sender'] ==
                                                            StoreController
                                                                .Rec_ID.value &&
                                                        message['receiver'] ==
                                                            int.parse(
                                                                StoreController
                                                                    .ID_controller
                                                                    .value
                                                                    .text
                                                                    .trim())) ||
                                                    (message['receiver'] ==
                                                            StoreController
                                                                .Rec_ID.value &&
                                                        message['sender'] ==
                                                            int.parse(
                                                                StoreController
                                                                    .ID_controller
                                                                    .value
                                                                    .text
                                                                    .trim())))
                                                ? Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        isSender
                                                            ? screenWidth * 0
                                                            : screenWidth *
                                                                0.01,
                                                        screenHeight * 0.0001,
                                                        isSender
                                                            ? screenWidth * 0.01
                                                            : screenWidth * 0,
                                                        0),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            screenWidth *
                                                                0.0083,
                                                            screenHeight *
                                                                0.0143,
                                                            screenWidth *
                                                                0.0083,
                                                            screenHeight *
                                                                0.0143),
                                                    decoration: BoxDecoration(
                                                      color: isSender
                                                          ? Paletter.gradiant1
                                                          : Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                12.0),
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                        bottomLeft: isSender
                                                            ? Radius.circular(
                                                                12.0)
                                                            : Radius.zero,
                                                        bottomRight: isSender
                                                            ? Radius.zero
                                                            : Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      message['content'],
                                                      textAlign: textAlign,
                                                      style: TextStyle(
                                                        color: isSender
                                                            ? Colors.white
                                                            : Colors.black87,
                                                        fontSize: screenHeight *
                                                            0.0167,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            SizedBox(
                                                height: screenHeight * 0.001),
                                            ((message['sender'] ==
                                                            StoreController
                                                                .Rec_ID.value &&
                                                        message['receiver'] ==
                                                            int.parse(
                                                                StoreController
                                                                    .ID_controller
                                                                    .value
                                                                    .text
                                                                    .trim())) ||
                                                    (message['receiver'] ==
                                                            StoreController
                                                                .Rec_ID.value &&
                                                        message['sender'] ==
                                                            int.parse(
                                                                StoreController
                                                                    .ID_controller
                                                                    .value
                                                                    .text
                                                                    .trim())))
                                                ? Text(
                                                    message['datetime']
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          Colors.blueGrey[700],
                                                      fontSize:
                                                          screenHeight * 0.0143,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                      height: screenHeight * 0.05,
                                      width: screenWidth * 0.1,
                                      decoration: BoxDecoration(
                                        color: Colors.red[400],
                                      ),
                                      child: Text(
                                        "Oh snap! \n " +
                                            snapshot.error.toString(),
                                        style: TextStyle(
                                            fontFamily: 'neuropol',
                                            fontSize: screenHeight * 0.12),
                                      ));
                                }
                              }
                            }),
                      ),
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Form(
                          child: TextFormField(
                            enabled: true,
                            readOnly: false,
                            obscureText: false,
                            controller:
                                StoreController.Message_controller.value,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.01,
                                  horizontal: screenWidth * 0.08),
                              hintText: 'Enter text here',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Iceland',
                                  fontSize: 0.027 * screenHeight),
                              helperStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Iceland',
                                  fontSize: 0.027 * screenHeight),
                              fillColor: Colors.grey[350],
                              filled: true,
                              prefixIcon: IconButton(
                                  onPressed: () => MongoDB,
                                  icon: Icon(
                                    Icons.attach_file_rounded,
                                    color: Paletter.containerDark,
                                  )),
                              suffixIcon:
                                  (StoreController.isSendingMessage.value)
                                      ? SpinKitHourGlass(
                                          color: Paletter.containerDark,
                                          size: screenWidth * 0.0019,
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.send_rounded,
                                            color: Paletter.containerDark,
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              StoreController.isSendingMessage
                                                  .value = true;
                                            });
                                            final msg = await MongoDB.sendMsg(
                                              StoreController.Rec_ID.value,
                                              StoreController.Message_controller
                                                  .value.text,
                                            );
                                            _streamController.add(msg);
                                          },
                                        ),
                            ),
                          ),
                        ),
                      )
                    ])),
              ),
            ]),
          )
        ],
      )
    ]));
  }
}
