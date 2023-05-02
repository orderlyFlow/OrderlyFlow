import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';

import '../../custom_widgets/BlueBg.dart';

class helpManual extends StatefulWidget {
  const helpManual({super.key});

  @override
  State<helpManual> createState() => _helpManualState();
}

class _helpManualState extends State<helpManual> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        const BlueBg(),
        Row(children: [
          SideBar(),
          Column(children: [
            Container(
                margin: EdgeInsets.fromLTRB(0.03 * screenWidth,
                    0.025 * screenHeight, 0.02 * screenWidth, 0),
                height: screenHeight * 0.935,
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
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              screenWidth * 0.02,
                              screenHeight * 0.04,
                              screenWidth * 0,
                              screenHeight * 0),
                          child: Text(
                            "User Manual",
                            style: TextStyle(
                              fontFamily: 'neuropol',
                              fontSize: screenHeight * 0.03,
                              color: Color.fromRGBO(20, 70, 103, 1),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.0201,
                            ),
                            DottedLine(
                              dashColor: Color.fromRGBO(20, 70, 103, 1),
                              lineLength: screenWidth * 0.112,
                            )
                          ],
                        ),
                        Container(
                            width: screenWidth * 0.85,
                            margin: EdgeInsets.fromLTRB(
                                screenWidth * 0.013,
                                screenHeight * 0.024,
                                screenWidth * 0,
                                screenHeight * 0),
                            child: Column(
                              children: [
                                Text(
                                  "OrderlyFlow aims to facilitate your workflow and by offering you an all-rounded application that offers one dashboard for all your critical tasks, on the left part of your dashboard you can find an easy access side bar that enables you to smoothly transition to and from different sections of our application.\n\nAt the top you'll find a circular avatar that contains your submitted photo and on pressed it guides you to your personal page where you'll find all your information.\n\n",
                                  style: TextStyle(
                                      fontFamily: 'iceland',
                                      fontSize: screenHeight * 0.03,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/images/home.png',
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.067),
                                    Container(
                                        width: screenWidth * 0.75,
                                        child: Text(
                                          "This will lead you to the home section of the app where you'll find a mini-view calendar, a welcome widget and a mini-view task section to check-off those pesky work things, you'll also have a joke generator to have a little laugh between meetings\n",
                                          style: TextStyle(
                                              fontFamily: 'iceland',
                                              fontSize: screenHeight * 0.03,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/images/chat.png',
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.067),
                                    Container(
                                        width: screenWidth * 0.75,
                                        child: Text(
                                          "This will lead you to our chat system where you can communicate with your fellow teammates and speak with other employees in your company\n",
                                          style: TextStyle(
                                              fontFamily: 'iceland',
                                              fontSize: screenHeight * 0.03,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/images/calendar.png',
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.067),
                                    Container(
                                        width: screenWidth * 0.75,
                                        child: Text(
                                          "This will lead you to your personalized calendar where you'll see all your events and meetings for the day or for upcoming days (For directors you can create new meetings by pressing the floating button at the bottom and filling-in the necessary information)\n",
                                          style: TextStyle(
                                              fontFamily: 'iceland',
                                              fontSize: screenHeight * 0.03,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/images/tasks.png',
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.067),
                                    Container(
                                        width: screenWidth * 0.75,
                                        child: Text(
                                          "This will lead you to your personalized task page where you can find your assigned tasks by your supervisor along with a notepad to keep all your great ideas in one place\n",
                                          style: TextStyle(
                                              fontFamily: 'iceland',
                                              fontSize: screenHeight * 0.03,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/images/requests.png',
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.067),
                                    Container(
                                        width: screenWidth * 0.75,
                                        child: Text(
                                          "This will lead you to the reports page where you can download built-in reports to fill-in and then re-upload it to be transferred to the HR team to be processed\n",
                                          style: TextStyle(
                                              fontFamily: 'iceland',
                                              fontSize: screenHeight * 0.03,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/images/help.png',
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.067),
                                    Container(
                                        width: screenWidth * 0.75,
                                        child: Text(
                                          "This will lead you to our help manual that you are reading right now!\n",
                                          style: TextStyle(
                                              fontFamily: 'iceland',
                                              fontSize: screenHeight * 0.03,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ],
                                ),
                              ],
                            )),
                      ])
                ]))
          ])
        ])
      ]),
    );
  }
}
