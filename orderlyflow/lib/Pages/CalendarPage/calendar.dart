import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../Database/db.dart';
import '../../Database/textControllers.dart';
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
  late Stream<List<Map<String, dynamic>>> _eventsStream =
      MongoDB.getEventsOnSelectedDate(today);
  final _formKey = GlobalKey<FormState>();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2023, 06, 05),
    end: DateTime(2023, 06, 30),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    TextEditingController title_controller = new TextEditingController();
    TextEditingController loc_controller = new TextEditingController();
    TextEditingController part_controller = new TextEditingController();
    TextEditingController desc_controller = new TextEditingController();
    //Future? _future = MongoDB.getEventsOnSelectedDate(today);
    final start = dateRange.start;
    final end = dateRange.end;
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
                          fontSize: screenHeight * 0.024,
                        ),
                        weekendStyle: TextStyle(
                          fontFamily: 'neuropol',
                          color: Paletter.blackText,
                          fontSize: screenHeight * 0.024,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        headerMargin:
                            EdgeInsets.only(bottom: screenHeight * 0.00001),
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          fontFamily: 'neuropol',
                          fontSize: screenHeight * 0.034,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      focusedDay: today,
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      onDaySelected: (today, focusedDay) {
                        setState(() {
                          today = focusedDay;
                          _eventsStream =
                              MongoDB.getEventsOnSelectedDate(today);
                        });
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
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            var meetings = snapshot.data!.toList();
                            if (meetings.isEmpty) {
                              return Center(
                                child: Text(
                                  '<<<No events>>>',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.018,
                                    color: Colors.black87,
                                    fontFamily: 'conthrax',
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: meetings.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final meeting = meetings[index];
                                  Duration offset =
                                      DateTime.now().timeZoneOffset;
                                  DateTime startUTC = meeting['startTime'];
                                  DateTime endUTC = meeting['endTime'];
                                  DateTime localStartTime =
                                      startUTC.add(offset);
                                  DateTime localEndTime = endUTC.add(offset);
                                  String startTime = DateFormat('HH:mm a')
                                      .format(localStartTime);
                                  String endTime = DateFormat('HH:mm a')
                                      .format(localEndTime);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.02),
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
                                                height: screenHeight * 0.12,
                                                margin: EdgeInsets.fromLTRB(
                                                    screenWidth * 0.018,
                                                    screenHeight * 0,
                                                    screenWidth * 0,
                                                    screenHeight * 0),
                                                width: screenWidth * 0.87,
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
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                                    0.025,
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'conthrax',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.015),
                                                        Text(
                                                          startTime +
                                                              " - " +
                                                              endTime,
                                                          style: TextStyle(
                                                            fontSize:
                                                                screenHeight *
                                                                    0.018,
                                                            color:
                                                                Colors.black87,
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
                                                  height: screenHeight * 0.018),

                                              // Dotted line
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      screenWidth * 0.014,
                                                      screenHeight * 0,
                                                      screenWidth * 0,
                                                      screenHeight * 0),
                                                  child: DottedLine(
                                                      dashRadius: 16.0,
                                                      dashColor:
                                                          Colors.grey.shade800,
                                                      dashGapLength:
                                                          screenWidth * 0.002,
                                                      lineLength:
                                                          screenWidth * 0.885,
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
          ],
        ),
        Visibility(
          visible: StoreController.isDirector.value,
          child: Container(
              margin: EdgeInsets.fromLTRB(screenWidth * 0, screenHeight * 0,
                  screenWidth * 0.005, screenHeight * 0.01),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox.fromSize(
                    size: Size(screenWidth * 0.0495, screenHeight * 0.065),
                    child: ClipOval(
                      child: Material(
                        color: Colors.green.shade300,
                        child: InkWell(
                          splashColor: Colors.indigoAccent.shade400,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: title_controller,
                                                  style: TextStyle(
                                                      color: Paletter.blackText,
                                                      fontFamily: 'Neuropol'),
                                                  decoration: InputDecoration(
                                                      // ignore: prefer_const_constructors
                                                      prefixIcon: Icon(
                                                        Icons.title_rounded,
                                                        color:
                                                            Paletter.logInText,
                                                      ),
                                                      hintText: 'Event Title',
                                                      // ignore: prefer_const_constructors
                                                      hintStyle: TextStyle(
                                                          color: Paletter
                                                              .logInText),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      40.0),
                                                              // ignore: prefer_const_constructors
                                                              borderSide: BorderSide(
                                                                  color: Color.fromRGBO(
                                                                      199,
                                                                      215,
                                                                      225,
                                                                      0.56))),
                                                      filled: true,
                                                      fillColor: const Color.fromRGBO(
                                                          199, 215, 225, 0.56),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  40.0),
                                                          borderSide: const BorderSide(
                                                              color: Color.fromRGBO(
                                                                  199, 215, 225, 0.56)))),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter the title';
                                                    }
                                                    return null;
                                                  },
                                                  //onSaved: (value) => user = value!,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: loc_controller,
                                                  style: TextStyle(
                                                      color: Paletter.blackText,
                                                      fontFamily: 'Neuropol'),
                                                  decoration: InputDecoration(
                                                      // ignore: prefer_const_constructors
                                                      prefixIcon: Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Paletter.logInText,
                                                      ),
                                                      hintText:
                                                          'Enter Event Location',
                                                      // ignore: prefer_const_constructors
                                                      hintStyle: TextStyle(
                                                          color: Paletter
                                                              .logInText),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      40.0),
                                                              // ignore: prefer_const_constructors
                                                              borderSide: BorderSide(
                                                                  color: Color.fromRGBO(
                                                                      199,
                                                                      215,
                                                                      225,
                                                                      0.56))),
                                                      filled: true,
                                                      fillColor: const Color.fromRGBO(
                                                          199, 215, 225, 0.56),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  40.0),
                                                          borderSide: const BorderSide(
                                                              color: Color.fromRGBO(
                                                                  199, 215, 225, 0.56)))),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your Location';
                                                    }
                                                    return null;
                                                  },
                                                  //onSaved: (value) => user = value!,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: part_controller,
                                                  style: TextStyle(
                                                      color: Paletter.blackText,
                                                      fontFamily: 'Neuropol'),
                                                  decoration: InputDecoration(
                                                      // ignore: prefer_const_constructors
                                                      prefixIcon: Icon(
                                                        Icons.person_outline,
                                                        color:
                                                            Paletter.logInText,
                                                      ),
                                                      hintText:
                                                          '{Participant1 Id,P2 Id...}',
                                                      // ignore: prefer_const_constructors
                                                      hintStyle: TextStyle(
                                                          color: Paletter
                                                              .logInText),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      40.0),
                                                              // ignore: prefer_const_constructors
                                                              borderSide: BorderSide(
                                                                  color: Color.fromRGBO(
                                                                      199,
                                                                      215,
                                                                      225,
                                                                      0.56))),
                                                      filled: true,
                                                      fillColor: const Color.fromRGBO(
                                                          199, 215, 225, 0.56),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  40.0),
                                                          borderSide: const BorderSide(
                                                              color: Color.fromRGBO(
                                                                  199, 215, 225, 0.56)))),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your participants';
                                                    }
                                                    return null;
                                                  },
                                                  //onSaved: (value) => user = value!,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: desc_controller,
                                                  style: TextStyle(
                                                      color: Paletter.blackText,
                                                      fontFamily: 'Neuropol'),
                                                  decoration: InputDecoration(
                                                      // ignore: prefer_const_constructors
                                                      prefixIcon: Icon(
                                                        Icons.description,
                                                        color:
                                                            Paletter.logInText,
                                                      ),
                                                      hintText:
                                                          'Enter Event Description',
                                                      // ignore: prefer_const_constructors
                                                      hintStyle: TextStyle(
                                                          color: Paletter
                                                              .logInText),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      40.0),
                                                              // ignore: prefer_const_constructors
                                                              borderSide: BorderSide(
                                                                  color: Color.fromRGBO(
                                                                      199,
                                                                      215,
                                                                      225,
                                                                      0.56))),
                                                      filled: true,
                                                      fillColor: const Color.fromRGBO(
                                                          199, 215, 225, 0.56),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  40.0),
                                                          borderSide: const BorderSide(
                                                              color: Color.fromRGBO(
                                                                  199, 215, 225, 0.56)))),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your description';
                                                    }
                                                    return null;
                                                  },
                                                  //onSaved: (value) => user = value!,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: ElevatedButton(
                                                            onPressed:
                                                                pickDateRange,
                                                            child: Text(
                                                                '${start.year}/${start.month}/${start.day}'))),
                                                    SizedBox(
                                                      width: screenWidth * 0.01,
                                                    ),
                                                    Expanded(
                                                        child: ElevatedButton(
                                                            onPressed:
                                                                pickDateRange,
                                                            child: Text(
                                                                '${end.year}/${end.month}/${end.day}'))),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  child: Text("Add Event"),
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      MongoDB.addEventToDB(
                                                          title_controller
                                                              .value.text,
                                                          loc_controller
                                                              .value.text,
                                                          desc_controller
                                                              .value.text,
                                                          part_controller
                                                              .value.text,
                                                          dateRange.start,
                                                          dateRange.end);
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ), // <-- Icon
                              Text(
                                "Add event",
                                style: TextStyle(
                                  fontFamily: "conthrax",
                                  fontSize: screenHeight * 0.0002,
                                  color: Colors.white,
                                ),
                              ), // <-- Text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))),
        ),
      ]),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateTimeRange;
    DateTime initialStartDate = dateRange.start;
    DateTime initialEndDate = dateRange.end;
    DateTime? newStartDate;

    // Show the start date picker
    do {
      newStartDate = await showDatePicker(
        context: context,
        initialDate: initialStartDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2030),
      );
    } while (newStartDate == null);

    //print(newStartDate!.day);
    if (newStartDate != null) {
      TimeOfDay? newStartTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialStartDate),
      );
      if (newStartTime != null) {
        newStartDate = DateTime(
          newStartDate.year,
          newStartDate.month,
          newStartDate.day,
          newStartTime.hour,
          newStartTime.minute,
        );
      }

      // Show the end date picker
      DateTime? newEndDate = await showDatePicker(
        context: context,
        initialDate: initialEndDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2030),
      );
      if (newEndDate != null) {
        // Show the end time picker
        TimeOfDay? newEndTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialEndDate),
        );
        if (newEndTime != null) {
          newEndDate = DateTime(
            newEndDate.year,
            newEndDate.month,
            newEndDate.day,
            newEndTime.hour,
            newEndTime.minute,
          );
        }

        // Update the date range if both start and end dates are valid
        if (newStartDate != null && newEndDate != null) {
          newDateTimeRange =
              DateTimeRange(start: newStartDate, end: newEndDate);
          setState(() => dateRange = newDateTimeRange!);
        }
      }
    }

    return newDateTimeRange;
  }
}
