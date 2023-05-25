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
import 'package:shimmer/shimmer.dart';

import '../../custom_widgets/BlueBg.dart';
import '../../custom_widgets/palette.dart';
import '../../custom_widgets/side_bar.dart';
import 'package:speech_to_text/speech_to_text.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => chatPageState();
}

class chatPageState extends State<chatPage> {
  bool isHovered = false;
  bool isVisible = false;
  bool isSearch = StoreController.isSearching.value;
  bool isListening = false;
  final photoData = StoreController.currentUser!['profilePicture'];
  var newMessage;
  Future? _future;
  late StreamController<List<Map<String, dynamic>>> _streamController =
      StreamController<List<Map<String, dynamic>>>();
  var searchedUser;
  SpeechToText _speech = SpeechToText();
  String text = '';
  late List<dynamic> chatInfo;

  void sendData(int Rec_ID) {
    var data1;
    for (var person in StoreController.indRec) {
      if (person['ID'] == Rec_ID) {
        data1 = person;
      }
    }
    final data2 = StoreController.currentUser;
    final data3 = MongoDB.getMembersName();
    if (data1 != null &&
        data2 != null &&
        StoreController.GroupMembers.isNotEmpty) {
      chatInfo = [data1, data2, StoreController.GroupMembers];
    }
  }

  Stream<List<Map<String, dynamic>>> getMessageStream() async* {
    db = await Mongo.Db.create(mongoDB_URL);
    int id = int.parse(StoreController.ID_controller.value.text.trim());
    await db.open();
    final messages = await db
        .collection('ChatsHistory')
        .find(Mongo.where.eq("sender", id).or(Mongo.where.eq("receiver", id)))
        .toList();

    Stream<List<Map<String, dynamic>>> messageStream =
        Stream.fromIterable([messages]);
    try {
      messageStream.listen((messages) {
        if (StoreController.isSendingMessage.isTrue && newMessage != null) {
          messages.add(newMessage);
          _streamController.add(messages);
          StoreController.isSendingMessage.value = false;
        }
      });
      yield* messageStream;
    } catch (e) {
      _streamController.addError(e);
    }
  }

  @override
  void initState() {
    super.initState();
    isHovered = false;
    if (StoreController.AllChats.isEmpty) {
      StoreController.receiversList = MongoDB.getIndRec();
    }
  }

  void searchHandler() {
    if (StoreController.isSearching == true) {
      StoreController.searchedEmployee = MongoDB.searchFor();
    } else {
      StoreController.searchedEmployee =
          ConnectionState.waiting as Future<List<Map<String, dynamic>>>?;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Uint8List photoBytes = base64Decode(photoData);
    ImageProvider imageProvider = MemoryImage(photoBytes);
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
                      //FutureBuilder(
                      //  future: StoreController.currentUser,
                      //builder: (buildContext, AsyncSnapshot snapshot) {
                      //if (snapshot.hasError) {
                      //return Column(
                      //children: [
                      //Container(
                      //  margin: EdgeInsets.fromLTRB(
                      //    0, screenHeight * 0.054, 0, 0),
                      //width: screenWidth * 0.08,
                      //height: screenHeight * 0.08,
                      //decoration: BoxDecoration(
                      //  shape: BoxShape.circle,
                      //),
                      //child: FittedBox(
                      //fit: BoxFit
                      //  .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                      //child: CircleAvatar(
                      //  backgroundColor: Colors.black,
                      //  ))),
                      //],
                      //);
                      //} else if (snapshot.hasData) {
                      //return
                      Column(children: [
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
                                  backgroundImage: imageProvider,
                                ))),
                      ] //,
                          //);
                          /*   } else {
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
                          }),*/
                          )
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
                              future: StoreController.receiversList,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  StoreController.input = snapshot.data!;
                                  return ListView.builder(
                                      itemCount: StoreController.input.length,
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
                                                            StoreController
                                                                    .input[
                                                                index]['ID'];
                                                        setState(() {
                                                          isVisible =
                                                              !isVisible;
                                                        });
                                                        sendData(id);
                                                      },
                                                      visualDensity:
                                                          VisualDensity(
                                                              vertical: 1),
                                                      leading: CircleAvatar(
                                                        backgroundImage: MemoryImage(
                                                            base64Decode(StoreController
                                                                        .AllChats[
                                                                    index][
                                                                'profilePicture'])),
                                                      ),
                                                      title: Text(
                                                          StoreController
                                                                  .AllChats[
                                                              index]['name'],
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
                                  return Container(
                                      height: screenHeight * 0.002,
                                      width: screenWidth * 0.002,
                                      margin: EdgeInsets.fromLTRB(
                                          screenWidth * 0.0,
                                          0,
                                          screenWidth * 0.12,
                                          0),
                                      child: ListView.builder(
                                          itemCount: 5,
                                          itemExtent: screenHeight * 0.0912,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade300,
                                                  radius: 30,
                                                ),
                                                title: Container(
                                                  height: screenHeight * 0.04,
                                                  width: screenWidth * 0.00009,
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                            );
                                          }));
                                }
                              },
                            )),
                        Obx(
                          () => Visibility(
                              visible: StoreController.isSearching.value,
                              child: Positioned(
                                top: 1,
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: screenWidth * 0.009,
                                        top: screenHeight * 0.085,
                                        bottom: screenHeight * 0.05),
                                    width: screenWidth * 0.285,
                                    height: screenHeight * 0.14,
                                    decoration: BoxDecoration(
                                      color: Colors.white60,
                                    ),
                                    child: FutureBuilder<
                                            List<Map<String, dynamic>>>(
                                        future: MongoDB.searchFor(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return MouseRegion(
                                                      child: Container(
                                                          color: Colors.white,
                                                          child: ListTile(
                                                            onTap: () {
                                                              StoreController
                                                                  .Searched_ID
                                                                  .value = snapshot
                                                                      .data![
                                                                  index]['ID'];
                                                              print(StoreController
                                                                  .Searched_ID
                                                                  .value);
                                                              searchedUser =
                                                                  snapshot.data![
                                                                      index];
                                                              if (StoreController
                                                                      .Searched_ID
                                                                      .value !=
                                                                  0) {
                                                                setState(() {
                                                                  StoreController
                                                                      .input
                                                                      .add(
                                                                          searchedUser);
                                                                  MongoDB
                                                                      .addSearchedUserToDB();
                                                                  StoreController
                                                                      .isSearching
                                                                      .value = false;
                                                                });
                                                              }
                                                            },
                                                            title: Text(
                                                                snapshot.data![
                                                                        index]
                                                                    ['name'],
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'conthrax',
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        screenHeight *
                                                                            0.0162)),
                                                          )));
                                                });
                                          } else if (!snapshot.hasData ||
                                              ConnectionState ==
                                                  ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    SpinKitPouringHourGlassRefined(
                                              color: Paletter.gradiant3,
                                            ));
                                          } else {
                                            return Text(
                                                snapshot.error.toString());
                                          }
                                        })),
                              )),
                          //////////////////////////////////////////////////////////////////////
                        )
                      ]),
                    ),
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
                                  horizontal: screenWidth * 0.02),
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.send_rounded,
                                  color: Paletter.containerDark,
                                ),
                                onPressed: () {
                                  if (StoreController.Rec_ID.value != 0 &&
                                      StoreController
                                              .Message_controller.value.text !=
                                          "") {
                                    setState(() {
                                      newMessage = MongoDB.sendMsg(
                                        StoreController.Rec_ID.value,
                                        StoreController
                                            .Message_controller.value.text,
                                      );
                                      StoreController.isSendingMessage.value =
                                          true;
                                      /* if (StoreController
                                                    .isSendingMessage.isTrue &&
                                                newMessage != null) {
                                              _streamController
                                                  .add([newMessage]);
                                            }*/
                                    });
                                  }
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
