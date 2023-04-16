import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import 'package:orderlyflow/Pages/CalendarPage/calendar%20widgets/dates.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../Database/db.dart';
import '../../custom_widgets/BlueBg.dart';

class calendar extends StatefulWidget {
  const calendar({super.key});

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  DateTime today = DateTime.now();
  List events = [];
  late double ScreenWidth;
  late double ScreenHeight;

  void _DisplayDialog(
      BuildContext context, DateTime selectedDate, List events) {
    setState(() {
      today = selectedDate;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 500,
                height: 200,
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        DateFormat.yMMMMd("en_US").format(selectedDate),
                        style: TextStyle(
                          fontFamily: 'iceland',
                          fontSize: ScreenHeight * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Paletter.blackText.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: events.length == 0 ? 1 : events.length,
                            itemBuilder: (context, index) {
                              if (events.length == 0) {
                                return Center(
                                  child: Center(
                                    child: Text(
                                      '<no event>',
                                      style: TextStyle(
                                          fontFamily: 'iceland',
                                          fontSize: ScreenHeight * 0.020,
                                          color: Paletter.blackText
                                              .withOpacity(0.5)),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    events[index],
                                    style: TextStyle(
                                        fontFamily: 'iceland',
                                        fontSize: ScreenHeight * 0.015,
                                        color: Paletter.blackText
                                            .withOpacity(0.5)),
                                  ),
                                );
                              }
                            }))
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenWidth = MediaQuery.of(context).size.width;
    ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        const BlueBg(),
        Row(
          children: [
            SideBar(),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(
                        0.01 * ScreenWidth,
                        0.02 * ScreenHeight,
                        0.01 * ScreenWidth,
                        0.02 * ScreenHeight),
                    child: Column(children: [calendarDate()])),
                Container(
                  width: ScreenWidth * 0.9102,
                  height: ScreenHeight * 0.54,
                  decoration: BoxDecoration(
                      color: Paletter.mainBgLight,
                      borderRadius: BorderRadius.circular(10)),
                  child: FutureBuilder(
                      future: MongoDB.getEvent(), //////////////////////
                      builder: (buildContext, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          var meetings = snapshot.data;
                          return ListView.builder(
                            itemCount: meetings.length,
                            itemBuilder: (BuildContext context, int index) {
                              final meeting = meetings[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Time on left
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Text(
                                        meeting.time,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    // Meeting name and dotted line
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  meeting.name,
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  meeting.description,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8.0),
                                          // Dotted line
                                          DottedLine(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Paletter.gradiant3,
                              ),
                            ),
                          );
                        }
                      }),
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
