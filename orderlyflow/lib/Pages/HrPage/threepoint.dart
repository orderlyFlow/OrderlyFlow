import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orderlyflow/Pages/hrpage/HRpage.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/searchBar.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import '../../Database/constant.dart';
import '../../Database/db.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import '../../Database/textControllers.dart';
import '../../custom_widgets/BlueBg.dart';
import 'package:orderlyflow/Database/db.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class threepoint extends StatefulWidget {
  const threepoint({super.key});

  @override
  threepointState createState() => threepointState();
}

class threepointState extends State<threepoint> {
  Future? _future;
  bool isEnable = false;
  bool isEditing = false;
  final statusController = TextEditingController(text: "Default1");
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final OTPController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final titleController = TextEditingController();
  final payrollController = TextEditingController();
  final HOWController = TextEditingController();
  final bounsController = TextEditingController();
  final DaysOffController = TextEditingController();

  static Future<void> downloadDocument(
      String base64String, String docName, int ID) async {
    try {
      List<int> bytes = base64.decode(base64String);

      final directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}' +
          '/' +
          '${docName}' +
          '${ID.toString()}' +
          '.docx';

      final file = File(path);
      await file.writeAsBytes(bytes);

      await Process.run('explorer', [path]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getPersonInfo();
  }

  void getPersonInfo() async {
    statusController.text = StoreController.selectedUser!['status'];
    idController.text = StoreController.selectedUser!['ID'].toString();
    nameController.text = StoreController.selectedUser!['name'];
    passwordController.text =
        StoreController.selectedUser!['password'].toString();
    OTPController.text = StoreController.selectedUser!['OTP'].toString();
    emailController.text = StoreController.selectedUser!['email'];
    phoneController.text = StoreController.selectedUser!['phone'];
    titleController.text = StoreController.selectedUser!['title'];
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      const BlueBg(),
      Row(children: [
        const SideBar(),
        Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(ScreenWidth * 0.02,
                    ScreenHeight * 0.04, ScreenWidth * 0, ScreenHeight * 0),
                width: ScreenWidth * 0.48,
                height: ScreenHeight * 0.92,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 46, 64, 83),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 30.0, top: 20, right: 30.0, bottom: 20),
                    child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: ScreenWidth * 0.0,
                              top: ScreenHeight * 0.020,
                              right: ScreenWidth * 0.29,
                              bottom: ScreenHeight * 0.02),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HRpage()));
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                        ),
                        Container(
                          child: TextButton(
                              onPressed: () {
                                if (isEditing == false)
                                  setState(() {
                                    isEditing = true;
                                    isEnable = true;
                                  });
                                else if (isEditing == true) {
                                  setState(() {
                                    isEditing = false;
                                    isEnable = false;

                                    MongoDB.changeAttribute(
                                        "status", statusController.text);
                                    MongoDB.changeAttribute(
                                        "name", nameController.text);
                                    MongoDB.changeAttribute(
                                        "phone", phoneController.text);
                                    MongoDB.changeAttribute(
                                        "title", titleController.text);
                                    MongoDB.changeAttribute(
                                        "email", emailController.text);
                                  });
                                }
                              },
                              child: Text(
                                "EDIT&SAVE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenHeight * 0.033,
                                  fontFamily: "neuropol",
                                ),
                              )),
                        ),
                      ]),
                      Column(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenWidth * 0.02,
                              ScreenHeight * 0.04,
                              ScreenWidth * 0,
                              ScreenHeight * 0),
                          width: ScreenWidth * 0.05,
                          height: ScreenHeight * 0.10,
                          child: CircleAvatar(
                            backgroundImage: MemoryImage(base64Decode(
                                StoreController
                                    .selectedUser!['profilePicture'])),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.0,
                                ScreenHeight * 0.0,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            width: ScreenWidth * 0.75,
                            height: ScreenHeight * 0.05,
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(205, 92, 92, 92),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              enabled: isEnable,
                              controller: nameController,
                              style: TextStyle(
                                color: Paletter.containerLight,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.028,
                              ),
                              onSubmitted: (value) {
                                String enteredText = nameController.text;
                                String textFieldName = "name";
                                MongoDB.changeAttribute(
                                    textFieldName, enteredText);

                                //ThemeStyles1.containerText;
                              },
                            )),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.0,
                                ScreenHeight * 0.0,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            width: ScreenWidth * 0.75,
                            height: ScreenHeight * 0.05,
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(205, 92, 92, 92),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: idController,
                              style: TextStyle(
                                color: Paletter.containerLight,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.028,
                              ),
                              onSubmitted: (value) {
                                String enteredText = idController.text;
                                String textFieldName = "ID";
                                MongoDB.changeAttribute(
                                    textFieldName, enteredText);
                                //ThemeStyles1.containerText;
                              },
                            )),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.0,
                                ScreenHeight * 0.0,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            width: ScreenWidth * 0.75,
                            height: ScreenHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: OTPController,
                              style: TextStyle(
                                color: Paletter.containerLight,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.028,
                              ),
                              onSubmitted: (value) {
                                String enteredText = OTPController.text;
                                String textFieldName = "OTP";
                                MongoDB.changeAttribute(
                                    textFieldName, enteredText);
                              },
                            )),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.0,
                                ScreenHeight * 0.0,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            width: ScreenWidth * 0.75,
                            height: ScreenHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: phoneController,
                              style: TextStyle(
                                color: Paletter.containerLight,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.028,
                              ),
                              onSubmitted: (value) {
                                String enteredText = phoneController.text;
                                String textFieldName = "phone";
                                MongoDB.changeAttribute(
                                    textFieldName, enteredText);
                              },
                            )),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.0,
                                ScreenHeight * 0.0,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            width: ScreenWidth * 0.75,
                            height: ScreenHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: emailController,
                              style: TextStyle(
                                color: Paletter.containerLight,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.028,
                              ),
                              onSubmitted: (value) {
                                String enteredText = emailController.text;
                                String textFieldName = "email";
                                MongoDB.changeAttribute(
                                    textFieldName, enteredText);
                              },
                            )),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.0,
                                ScreenHeight * 0.0,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            width: ScreenWidth * 0.75,
                            height: ScreenHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: passwordController,
                              style: TextStyle(
                                color: Paletter.containerLight,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.028,
                              ),
                              onSubmitted: (value) {
                                String enteredText = passwordController.text;
                                String textFieldName = "password";
                                MongoDB.changeAttribute(
                                    textFieldName, enteredText);
                              },
                            )),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.0,
                                ScreenHeight * 0.0,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            width: ScreenWidth * 0.75,
                            height: ScreenHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: titleController,
                              style: TextStyle(
                                color: Paletter.containerLight,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.028,
                              ),
                              onSubmitted: (value) {
                                String enteredText = titleController.text;
                                String textFieldName = "password";
                                MongoDB.changeAttribute(
                                    textFieldName, enteredText);
                              },
                            )),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenWidth * 0.0,
                                ScreenHeight * 0.0,
                                ScreenWidth * 0,
                                ScreenHeight * 0),
                            width: ScreenWidth * 0.75,
                            height: ScreenHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: statusController,
                              style: TextStyle(
                                color: Paletter.containerLight,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.028,
                              ),
                              onSubmitted: (value) {
                                String enteredText = statusController.text;
                                String textFieldName = "status";
                                MongoDB.changeAttribute(
                                    textFieldName, enteredText);
                              },
                            )),
                      ])
                    ]))),
          ],
        ),

        ///////////////////////////end of employee container//////////////////////////
        Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(ScreenWidth * 0.05,
                    ScreenHeight * 0.04, ScreenWidth * 0.02, ScreenHeight * 0),
                width: ScreenWidth * 0.36,
                height: ScreenHeight * 0.59,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 191, 201, 202),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
                    child: const Text(
                      "FORMS",
                      style: ThemeStylestitle.containerText,
                    ),
                  ),
                  Container(
                      width: ScreenWidth * 0.36,
                      height: ScreenHeight * 0.39,
                      child: FutureBuilder<List<dynamic>>(
                        future: MongoDB.getIndividualForms(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                DateTime dateUTC =
                                    snapshot.data![index]['Date'];
                                Duration offset = DateTime.now().timeZoneOffset;
                                DateTime localTime = dateUTC.add(offset);
                                String localReqTime =
                                    DateFormat('HH:mm:a').format(localTime);
                                String date = dateUTC.weekday.toString() +
                                    '/' +
                                    dateUTC.month.toString() +
                                    '/' +
                                    dateUTC.year.toString();
                                return Container(
                                    width: ScreenWidth * 0.34,
                                    height: ScreenHeight * 0.13,
                                    child: ListTile(
                                      title: TextButton(
                                        onPressed: () {
                                          downloadDocument(
                                              snapshot.data![index]['base64'],
                                              snapshot.data![index]['title'],
                                              snapshot.data![index]
                                                  ['uploaderID']);
                                        },
                                        child: Text(
                                          snapshot.data![index]['title'],
                                          style: ThemeStyles.containerText,
                                        ),
                                      ),
                                      subtitle: Text(
                                        localReqTime + " - " + date,
                                        style: ThemeStyles.containerText,
                                      ),
                                    ));
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Container(
                                width: ScreenWidth * 0.16,
                                height: ScreenHeight * 0.24,
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          }
                        },
                      )),
                ])),
            Container(
                margin: EdgeInsets.fromLTRB(ScreenWidth * 0.05,
                    ScreenHeight * 0.04, ScreenWidth * 0.02, ScreenHeight * 0),
                width: ScreenWidth * 0.36,
                height: ScreenHeight * 0.29,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(226, 140, 148, 240),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenWidth * 0.0030,
                        top: ScreenHeight * 0.020,
                        right: ScreenWidth * 0.030,
                        bottom: ScreenHeight * 0.020),
                    child: const Text(
                      "PAYROLL",
                      style: ThemeStylestitle.containerText,
                    ),
                  ),
                  Container(
                      //  scrollDirection: Axis.vertical,
                      width: ScreenWidth * 0.34,
                      height: ScreenHeight * 0.15,
                      child: FutureBuilder<dynamic>(
                        future: MongoDB.getSalaryhr(
                            StoreController.selectedUser!['ID']),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            DaysOffController.text =
                                snapshot.data['daysOff'].toString();
                            payrollController.text =
                                snapshot.data['basepay'].toString();
                            HOWController.text =
                                snapshot.data['hoursOW'].toString();
                            bounsController.text =
                                snapshot.data['bonus'].toString();
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      child: TextField(
                                    controller: payrollController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'neuropol',
                                      fontSize: ScreenHeight * 0.032,
                                    ),
                                    onSubmitted: (value) {
                                      String enteredText =
                                          payrollController.text;
                                      String textFieldName = "Basepay";
                                      MongoDB.changeAttributeInt(
                                          textFieldName, enteredText);
                                    },
                                  )),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: HOWController,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'neuropol',
                                          fontSize: ScreenHeight * 0.032,
                                        ),
                                        onSubmitted: (value) {
                                          String enteredText =
                                              HOWController.text;
                                          String textFieldName =
                                              "Hours Of Work";
                                          MongoDB.changeAttributeInt(
                                              textFieldName, enteredText);
                                        },
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: bounsController,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'neuropol',
                                          fontSize: ScreenHeight * 0.032,
                                        ),
                                        onSubmitted: (value) {
                                          String enteredText =
                                              bounsController.text;
                                          String textFieldName = "Bonus";
                                          MongoDB.changeAttributeInt(
                                              textFieldName, enteredText);
                                        },
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: DaysOffController,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'neuropol',
                                          fontSize: ScreenHeight * 0.032,
                                        ),
                                        onSubmitted: (value) {
                                          String enteredText =
                                              DaysOffController.text;
                                          String textFieldName = "Days Off";
                                          MongoDB.changeAttributeInt(
                                              textFieldName, enteredText);
                                        },
                                      ))
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              'OOoopss! Error while fetching',
                              style: TextStyle(
                                color: Paletter.gradiant3,
                                fontFamily: 'neuropol',
                                fontSize: ScreenHeight * 0.032,
                              ),
                            );
                          } else {
                            DaysOffController.text = "Loading";
                            payrollController.text = "Loading";
                            HOWController.text = "Loading";
                            bounsController.text = "Loading";
                            return Container(
                                width: ScreenWidth * 0.16,
                                height: ScreenHeight * 0.24,
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          }
                        },
                      )),
                ])),
          ],
        ),
      ])
    ]));
  }
}

class ThemeStyles {
  static const TextStyle containerText = TextStyle(
    fontSize: 22.0,
    decoration: TextDecoration.none,
    fontFamily: 'neuropol',
    color: Paletter.gradiant1,
  );
}

class ThemeStylestitle {
  static const TextStyle containerText = TextStyle(
    fontSize: 29.0,
    decoration: TextDecoration.none,
    fontFamily: 'neuropol',
    color: Paletter.gradiant3,
  );
}

class ThemeStyles1 {
  static const TextStyle containerText = TextStyle(
    fontSize: 22.0,
    decoration: TextDecoration.none,
    fontFamily: 'neuropol',
    color: Color.fromRGBO(18, 20, 30, 10),
  );
}
