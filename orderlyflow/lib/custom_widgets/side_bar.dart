import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:orderlyflow/Pages/CalendarPage/calendar.dart';
import 'package:orderlyflow/Pages/ChatPage/chatPage.dart';
import 'package:orderlyflow/Pages/HrPage/HRpage.dart';
import 'package:orderlyflow/Pages/MainPage/main_page.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/Pages/RequestPage/requests.dart';
import 'package:bson/bson.dart';
import 'package:orderlyflow/Pages/TaskPage/tasks.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:page_transition/page_transition.dart';

import '../Database/textControllers.dart';
import '../Pages/ManualPage/HelpManual.dart';
import '../Pages/UserInfoPage/employeeData.dart';

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
  bool _isHoverdHR = false;
  final photoData = StoreController.currentUser!['profilePicture'];

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    Uint8List photoBytes = base64Decode(photoData);
    ImageProvider imageProvider = MemoryImage(photoBytes);

    return Drawer(
      width: ScreenWidth * 0.07,
      elevation: 0,
      child: SingleChildScrollView(
        child: Container(
          height: ScreenHeight,
          color: Paletter.mainBgLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenHeight * 0.04,
              ),
              Center(
                  child: Column(children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => employeeData(),
                      maintainState: true,
                    ));
                  },
                  child: Container(
                      margin:
                          EdgeInsets.fromLTRB(0, ScreenHeight * 0.045, 0, 0),
                      width: ScreenWidth * 0.078,
                      height: ScreenHeight * 0.078,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: FittedBox(
                          fit: BoxFit
                              .contain, // Set the fit property to BoxFit.contain to scale the image proportionally to fit inside the container
                          child: CircleAvatar(
                            backgroundImage: imageProvider,
                          ))),
                )
              ])),
              SizedBox(
                height: ScreenHeight * 0.06,
              ),
              Column(
                children: [
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
                                child: mainPage(),
                                type: PageTransitionType.theme,
                                duration: const Duration(seconds: 2)));
                      },
                    ),
                  ),
                  SizedBox(
                    height: ScreenHeight * 0.02,
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
                                child: const chatPage(),
                                type: PageTransitionType.theme,
                                duration: const Duration(seconds: 2)));
                      },
                    ),
                  ),
                  SizedBox(
                    height: ScreenHeight * 0.02,
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
                              child: calendar(),
                              type: PageTransitionType.theme,
                              duration: const Duration(seconds: 2)));
                    },
                  )),
                  SizedBox(
                    height: ScreenHeight * 0.02,
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
                              child: myTasks(),
                              type: PageTransitionType.theme,
                              duration: const Duration(seconds: 2)));
                    },
                  )),
                  SizedBox(
                    height: ScreenHeight * 0.02,
                  ),
                  Center(
                      child: Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenWidth * 0.01, ScreenHeight * 0.01, 0, 0),
                    child: InkWell(
                      onHover: (isHovered) =>
                          setState(() => _isHoveredRequests = isHovered),
                      child: Image.asset(
                        _isHoveredRequests
                            ? 'assets/images/requestsHover.png'
                            : 'assets/images/requests.png',
                        height: ScreenHeight * 0.07,
                        width: ScreenWidth * 0.08,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: requests(),
                                type: PageTransitionType.theme,
                                duration: const Duration(seconds: 2)));
                      },
                    ),
                  )),
                  SizedBox(
                    height: ScreenHeight * 0.02,
                  ),
                  Visibility(
                    visible: StoreController.isHR.value,
                    child: Center(
                        child: Container(
                      child: InkWell(
                        onHover: (isHovered) =>
                            setState(() => _isHoverdHR = isHovered),
                        child: Image.asset(
                          _isHoverdHR
                              ? 'assets/images/customer-careHover.png'
                              : 'assets/images/customer-care.png',
                          height: ScreenHeight * 0.07,
                          width: ScreenWidth * 0.08,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: HRpage(),
                                  type: PageTransitionType.theme,
                                  duration: const Duration(seconds: 2)));
                        },
                      ),
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenHeight * 0.16,
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
                          child: helpManual(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
