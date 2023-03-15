import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:orderlyflow/announcement.dart';
import 'package:orderlyflow/calendar.dart';
import 'package:orderlyflow/Pages/chatPage.dart';
import 'package:orderlyflow/main_page.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/requests.dart';
import 'package:bson/bson.dart';
import 'package:orderlyflow/tasks.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:page_transition/page_transition.dart';

import 'employeeData.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool _isHoveredHome = false;
  bool _isHoveredChat = false;
  bool _isHoveredAnnoucement = false;
  bool _isHoveredRequests = false;
  bool _isHoveredCalendar = false;
  bool _isHoveredManual = false;
  bool _isHoveredTask = false;

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;

    return Drawer(
        width: ScreenWidth * 0.07,
        elevation: 0,
        child: SingleChildScrollView(
          child: Container(
            height: ScreenHeight,
            color: Paletter.mainBgLight,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: FutureBuilder(
                    future: MongoDB.getProfilePic(),
                    builder: (buildContext, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Column(children: [
                          InkWell(
                            child: Image(
                              image: snapshot.data,
                              height: ScreenHeight * 0.055,
                              width: ScreenWidth * 0.03,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      childCurrent: const employeeData(),
                                      child: employeeData(),
                                      type: PageTransitionType.theme,
                                      duration: const Duration(seconds: 2)));
                            },
                          )
                        ]);
                      } else {
                        return Container(
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    }),
                /*Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, ScreenHeight * 0.055, 0, 0),
                  height: ScreenHeight * 0.055,
                  width: ScreenWidth * 0.03,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 0.69),
                      borderRadius: BorderRadius.circular(80)),
                ),
              ),*/
              ),
              SizedBox(
                height: ScreenHeight * 0.07,
              ),
              Center(
                child: InkWell(
                  onHover: (isHovered) =>
                      setState(() => _isHoveredHome = isHovered),
                  child: Image.asset(
                      _isHoveredHome
                          ? 'assets/images/homeHover.png'
                          : 'assets/images/home.png',
                      height: ScreenHeight * 0.07,
                      width: ScreenWidth * 0.08),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            childCurrent: const SideBar(),
                            child: mainPage(),
                            type: PageTransitionType.theme,
                            duration: const Duration(seconds: 2)));
                  },
                ),
              ),
              SizedBox(
                height: ScreenHeight * 0.035,
              ),
              Center(
                child: InkWell(
                  onHover: (isHovered) =>
                      setState(() => _isHoveredChat = isHovered),
                  child: Image.asset(
                      _isHoveredChat
                          ? 'assets/images/chatHover.png'
                          : 'assets/images/chat.png',
                      height: ScreenHeight * 0.07,
                      width: ScreenWidth * 0.08),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            childCurrent: const chatPage(),
                            child: const chatPage(),
                            type: PageTransitionType.theme,
                            duration: const Duration(seconds: 2)));
                  },
                ),
              ),
              SizedBox(
                height: ScreenHeight * 0.035,
              ),
              Center(
                  child: InkWell(
                onHover: (isHovered) =>
                    setState(() => _isHoveredCalendar = isHovered),
                child: Image.asset(
                    _isHoveredCalendar
                        ? 'assets/images/calendarHover.png'
                        : 'assets/images/calendar.png',
                    height: ScreenHeight * 0.07,
                    width: ScreenWidth * 0.08),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          childCurrent: const calendar(),
                          child: calendar(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              )),
              SizedBox(
                height: ScreenHeight * 0.035,
              ),
              Center(
                  child: InkWell(
                onHover: (isHovered) =>
                    setState(() => _isHoveredTask = isHovered),
                child: Image.asset(
                    _isHoveredTask
                        ? 'assets/images/tasksHover.png'
                        : 'assets/images/tasks.png',
                    height: ScreenHeight * 0.07,
                    width: ScreenWidth * 0.08),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          childCurrent: const myTasks(),
                          child: myTasks(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              )),
              SizedBox(
                height: ScreenHeight * 0.035,
              ),
              Center(
                  child: InkWell(
                onHover: (isHovered) =>
                    setState(() => _isHoveredRequests = isHovered),
                child: Image.asset(
                  _isHoveredRequests
                      ? 'assets/images/requestsHover.png'
                      : 'assets/images/requests.png',
                  height: ScreenHeight * 0.07,
                  width: ScreenWidth * 0.084,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          childCurrent: const requests(),
                          child: requests(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              )),
              SizedBox(
                height: ScreenHeight * 0.2,
              ),
              Center(
                  child: InkWell(
                onHover: (isHovered) =>
                    setState(() => _isHoveredManual = isHovered),
                child: Image.asset(
                  _isHoveredManual
                      ? 'assets/images/helpHover.png'
                      : 'assets/images/help.png',
                  height: ScreenHeight * 0.07,
                  width: ScreenWidth * 0.08,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          childCurrent: const myTasks(),
                          child: mainPage(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              )),
            ]),
          ),
        ));
  }
}
