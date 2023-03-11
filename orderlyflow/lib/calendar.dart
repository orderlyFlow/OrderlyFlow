import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/side_bar.dart';
import 'package:orderlyflow/calendar widgets/dates.dart';

import 'custom_widgets/BlueBg.dart';

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
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
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
                child: Column(children: [calendarDate()]))
          ],
        )
      ]),
    );
  }
}
