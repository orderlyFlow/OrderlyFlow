// ignore_for_file: prefer_const_constructors
import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../Database/db.dart';

class calendarMain extends StatefulWidget {
  const calendarMain({super.key});

  @override
  State<calendarMain> createState() => _calendarMainState();
}

class _calendarMainState extends State<calendarMain> {
  DateTime today = DateTime.now();
  List events = [];
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  late Stream<List<Map<String, dynamic>>> _eventsStream =
      MongoDB.getEventsOnSelectedDate(today);
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
              child: GlassmorphicContainer(
                width: screenWidth * 0.40,
                height: screenWidth * 0.2,
                blur: 10,
                borderRadius: 15,
                border: 2,
                alignment: Alignment.bottomCenter,
                borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [
                      Color(0x33F6F6F6),
                      Color(0x5FBFCAE2),
                      Color(0x9E778FC7),
                      Color(0xC14968AF)
                    ]),
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF95ABB9),
                    Color(0x6695ABB9),
                  ],
                ),
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
                      margin: EdgeInsets.only(left: screenWidth * 0.01),
                      child: Text(
                        DateFormat.yMMMMd("en_US").format(selectedDate),
                        style: TextStyle(
                          fontFamily: 'iceland',
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Paletter.blackText.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.0032,
                    ),
                    Container(
                      width: screenWidth * 0.40,
                      height: screenWidth * 0.1,
                      child: StreamBuilder<List<Map<String, dynamic>>>(
                          stream: _eventsStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.blue.shade300
                                          .withOpacity(0.5)),
                                );
                              } else {
                                var meetings = snapshot.data!.toList();
                                if (meetings.isEmpty) {
                                  return Center(
                                    child: Text(
                                      '<<<No events>>>',
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.023,
                                        color:
                                            Paletter.blackText.withOpacity(0.4),
                                        fontFamily: 'conthrax',
                                      ),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: meetings.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final meeting = meetings[index];
                                      Duration offset =
                                          DateTime.now().timeZoneOffset;
                                      DateTime startUTC = meeting['startTime'];
                                      DateTime endUTC = meeting['endTime'];
                                      DateTime localStartTime =
                                          startUTC.add(offset);
                                      DateTime localEndTime =
                                          endUTC.add(offset);
                                      String startTime = DateFormat('HH:mm a')
                                          .format(localStartTime);
                                      String endTime = DateFormat('HH:mm a')
                                          .format(localEndTime);
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.01),
                                        child: Column(children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Meeting name and dotted line
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: screenHeight * 0.08,
                                                    margin: EdgeInsets.fromLTRB(
                                                        screenWidth * 0.01,
                                                        screenHeight * 0,
                                                        screenWidth * 0,
                                                        screenHeight * 0),
                                                    width: screenWidth * 0.38,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            screenWidth * 0.014,
                                                            screenHeight * 0.01,
                                                            screenWidth * 0.014,
                                                            screenHeight *
                                                                0.014),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 117, 165, 204),
                                                      border: Border.all(
                                                          color: Color.fromARGB(
                                                              255,
                                                              117,
                                                              165,
                                                              204)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              meeting['title'],
                                                              style: TextStyle(
                                                                fontSize:
                                                                    screenHeight *
                                                                        0.02,
                                                                color: Paletter
                                                                    .blackText
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontFamily:
                                                                    'conthrax',
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    screenHeight *
                                                                        0.0015),
                                                            Text(
                                                              startTime +
                                                                  " - " +
                                                                  endTime,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    screenHeight *
                                                                        0.02,
                                                                color: Paletter
                                                                    .blackText
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontFamily:
                                                                    'conthrax',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.001),
                                                  Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              screenWidth *
                                                                  0.014,
                                                              screenHeight *
                                                                  0.004,
                                                              screenWidth * 0,
                                                              screenHeight * 0),
                                                      child: DottedLine(
                                                          dashRadius: 16.0,
                                                          dashColor: Colors
                                                              .grey.shade800
                                                              .withOpacity(0.4),
                                                          dashGapLength:
                                                              screenWidth *
                                                                  0.002,
                                                          lineLength:
                                                              screenWidth *
                                                                  0.37,
                                                          lineThickness:
                                                              screenHeight *
                                                                  0.0038)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ]),
                                      );
                                    },
                                  );
                                }
                              }
                            }
                          }),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Paletter.containerLight,
          borderRadius: BorderRadius.circular(15)),
      width: ScreenWidth * 0.5,
      height: ScreenHeight * 0.6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              calendarStyle: CalendarStyle(
                todayTextStyle: TextStyle(
                  fontFamily: 'iceland',
                  color: Paletter.blackText,
                  fontSize: screenHeight * 0.010,
                ),
                selectedTextStyle: TextStyle(
                  fontFamily: 'iceland',
                  color: Paletter.blackText,
                  fontSize: screenHeight * 0.03,
                ),
                defaultTextStyle: TextStyle(
                  fontFamily: 'iceland',
                  color: Paletter.blackText,
                  fontSize: screenHeight * 0.03,
                ),
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(
                  fontFamily: 'iceland',
                  color: Paletter.blackText,
                  fontSize: screenHeight * 0.03,
                ),
                holidayTextStyle: TextStyle(
                  fontFamily: 'iceland',
                  color: Paletter.blackText,
                  fontSize: screenHeight * 0.03,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  fontFamily: 'neuropol',
                  color: Paletter.blackText,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.022,
                ),
                weekendStyle: TextStyle(
                  fontFamily: 'neuropol',
                  color: Paletter.blackText,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.022,
                ),
              ),
              headerStyle: HeaderStyle(
                headerMargin: EdgeInsets.only(bottom: ScreenHeight * 0.0152),
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontFamily: 'neuropol',
                  fontSize: screenHeight * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              focusedDay: today,
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2030, 1, 1),
              selectedDayPredicate: (day) => isSameDay(day, today),
              onDaySelected: (today, event) {
                _DisplayDialog(context, today, events);
                _eventsStream = MongoDB.getEventsOnSelectedDate(today);
              },
            )
          ],
        ),
      ),
    );
  }
}
