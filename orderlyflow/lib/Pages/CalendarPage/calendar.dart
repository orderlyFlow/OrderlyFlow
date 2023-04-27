import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../Database/db.dart';
import '../../custom_widgets/BlueBg.dart';
import 'package:intl/intl.dart';

class calendar extends StatefulWidget {
  const calendar({super.key});

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  DateTime today = DateTime.now();
  List events = [];

  //late double ScreenWidth;
  //late double ScreenHeight;

  /*void _DisplayDialog(
      BuildContext context, DateTime selectedDate, List events) async {
   //events = await MongoDB.getEventsOnSelectedDate(selectedDate);
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
  }*/

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        const BlueBg(),
        Row(
          children: [
            SideBar(),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Paletter.logInBg,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.fromLTRB(0 * screenWidth,
                      0 * screenHeight, 0 * screenWidth, 0 * screenHeight),
                  margin: EdgeInsets.fromLTRB(
                      0.01 * screenWidth,
                      0.02 * screenHeight,
                      0.01 * screenWidth,
                      0 * screenHeight),
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.91,
                  child: SizedBox.expand(
                    //size: Size(screenWidth * 0.9, screenHeight * 0.04),
                    child: TableCalendar(
                      shouldFillViewport: true,
                      firstDay: DateTime(2023),
                      lastDay: DateTime(2025),
                      focusedDay: DateTime.now(),
                      calendarStyle: CalendarStyle(
                        cellMargin: EdgeInsets.fromLTRB(
                            screenWidth * 0.0001,
                            screenHeight * 0.0001,
                            screenWidth * 0.0001,
                            screenHeight * 0.0001),
                        todayTextStyle: TextStyle(
                          fontFamily: 'iceland',
                          color: Paletter.blackText,
                          fontSize: screenHeight * 0.03,
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
                          fontSize: screenHeight * 0.03,
                        ),
                        weekendStyle: TextStyle(
                          fontFamily: 'neuropol',
                          color: Paletter.blackText,
                          fontSize: screenHeight * 0.3,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        headerMargin:
                            EdgeInsets.only(bottom: screenHeight * 0.0013),
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          fontFamily: 'neuropol',
                          fontSize: screenHeight * 0.034,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      onDaySelected: (today, focusedDay) {
                        setState(() {
                          today = today;
                        });
                        //int day = today.day;
                        MongoDB.getEventsOnSelectedDate(today);
                        //print(day.toString());
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  width: screenWidth * 0.9102,
                  height: screenHeight * 0.54,
                  decoration: BoxDecoration(
                      color: Paletter.mainBgLight,
                      borderRadius: BorderRadius.circular(10)),
                  /////////////////////////////events/////////////////////////////////////
                  child: FutureBuilder(
                      future: MongoDB.getEvent(),
                      builder: (buildContext, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          var meetings = snapshot.data;
                          return ListView.builder(
                            itemCount: meetings.length,
                            itemBuilder: (BuildContext context, int index) {
                              final meeting = meetings[index];
                              // DateTime dateTime =
                              //   DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                              //     .parse(meeting['startTime']);
                              String startTime = DateFormat('HH:mm a')
                                  .format(meeting['startTime']);
                              String endTime = DateFormat('HH:mm a')
                                  .format(meeting['endTime']);
                              // int day =
                              //   dateTime.day; // extract the day component
                              //int month = dateTime.month;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.02),
                                child: Column(children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Time on left
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0.0879),
                                            child: Text(
                                              '08:00 AM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0.0879),
                                            child: Text(
                                              '09:00 AM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0.0879),
                                            child: Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0.0879),
                                            child: Text(
                                              '11:00 AM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0.0879),
                                            child: Text(
                                              '12:00 PM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0.0879),
                                            child: Text(
                                              '01:00 PM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0.0879),
                                            child: Text(
                                              '02:00 PM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0.0879),
                                            child: Text(
                                              '03:00 PM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.021,
                                                screenHeight * 0.007,
                                                screenWidth * 0.021,
                                                screenHeight * 0),
                                            child: Text(
                                              '04:00 PM',
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                color: Colors.black87,
                                                fontFamily: 'conthrax',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Meeting name and dotted line
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: screenHeight * 0.12,
                                            margin: EdgeInsets.fromLTRB(
                                                screenWidth * 0.01,
                                                screenHeight * 0,
                                                screenWidth * 0,
                                                screenHeight * 0),
                                            width: screenWidth * 0.767,
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * 0.014,
                                                screenHeight * 0.014,
                                                screenWidth * 0.014,
                                                screenHeight * 0.014),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 117, 165, 204),
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 117, 165, 204)),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child:
                                                /////////////////////////////////////////////////////////////////////////
                                                Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                /*Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        screenWidth * 0,
                                                        screenHeight * 0,
                                                        screenWidth * 0,
                                                        screenHeight * 0),
                                                    width: screenWidth * 0.07,
                                                    height: screenHeight * 0.15,
                                                    child: FittedBox(
                                                      fit: BoxFit
                                                          .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                                                      child: Image(
                                                        image: MemoryImage(
                                                            meeting['icon']),
                                                      ),
                                                    ),
                                                  ),*/
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      meeting['title'],
                                                      style: TextStyle(
                                                        fontSize: screenHeight *
                                                            0.025,
                                                        color: Colors.black87,
                                                        fontFamily: 'conthrax',
                                                      ),
                                                    ),
                                                    /*SizedBox(
                                                          height: screenHeight *
                                                              0.015),
                                                      Text(
                                                        meeting[
                                                            'eventDescription'],
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenHeight *
                                                                  0.018,
                                                          color: Colors.black87,
                                                          fontFamily:
                                                              'conthrax',
                                                        ),
                                                      ),*/
                                                    SizedBox(
                                                        height: screenHeight *
                                                            0.015),
                                                    Text(
                                                      startTime +
                                                          " - " +
                                                          endTime,
                                                      style: TextStyle(
                                                        fontSize: screenHeight *
                                                            0.018,
                                                        color: Colors.black87,
                                                        fontFamily: 'conthrax',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.01),

                                          // Dotted line
                                          DottedLine(
                                              dashRadius: 16.0,
                                              dashColor: Colors.grey.shade800,
                                              dashGapLength:
                                                  screenWidth * 0.002,
                                              lineLength: screenWidth * 0.788,
                                              lineThickness:
                                                  screenHeight * 0.0038),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
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
