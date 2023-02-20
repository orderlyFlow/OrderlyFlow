import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class calendar extends StatefulWidget {
  const calendar({super.key});

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  DateTime today = DateTime.now();
  List events = [];

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
                          fontSize: 35,
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
                                          fontSize: 20,
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
                                        fontSize: 15,
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
    return Container(
      decoration: BoxDecoration(
          color: Paletter.gradiant3, borderRadius: BorderRadius.circular(15)),
      width: 600,
      height: 400,
      child: Column(
        children: [
          TableCalendar(
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(
                fontFamily: 'iceland',
                color: Paletter.blackText,
                fontSize: 20,
              ),
              selectedTextStyle: TextStyle(
                fontFamily: 'iceland',
                color: Paletter.blackText,
                fontSize: 20,
              ),
              defaultTextStyle: TextStyle(
                fontFamily: 'iceland',
                color: Paletter.blackText,
                fontSize: 20,
              ),
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(
                fontFamily: 'iceland',
                color: Paletter.blackText,
                fontSize: 20,
              ),
              holidayTextStyle: TextStyle(
                fontFamily: 'iceland',
                color: Paletter.blackText,
                fontSize: 20,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontFamily: 'neuropol',
                color: Paletter.blackText,
                fontSize: 20,
              ),
              weekendStyle: TextStyle(
                fontFamily: 'neuropol',
                color: Paletter.blackText,
                fontSize: 20,
              ),
            ),
            headerStyle: HeaderStyle(
              headerMargin: EdgeInsets.only(bottom: 20),
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontFamily: 'neuropol',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            focusedDay: today,
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            selectedDayPredicate: (day) => isSameDay(day, today),
            onDaySelected: (today, event) {
              _DisplayDialog(context, today, events);
            },
          )
        ],
      ),
    );
  }
}
