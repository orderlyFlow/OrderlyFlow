import 'package:flutter/material.dart';
import 'package:orderlyflow/announcement.dart';
import 'package:orderlyflow/calendar.dart';
import 'package:orderlyflow/chatPage.dart';
import 'package:orderlyflow/main_page.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/requests.dart';
import 'package:orderlyflow/tasks.dart';
import 'package:page_transition/page_transition.dart';

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
    return Drawer(
      elevation: 0,
      child: Container(
        color: Paletter.mainBgLight,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.69),
                    borderRadius: BorderRadius.circular(80)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                onHover: (isHovered) =>
                    setState(() => _isHoveredHome = isHovered),
                child: Image.asset(
                  _isHoveredHome
                      ? 'assets/images/homeHover.png'
                      : 'assets/images/home.png',
                  height: 50,
                  width: 50,
                ),
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
            const SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                onHover: (isHovered) => setState(() => _isHoveredChat = isHovered),
                child: Image.asset(
                  _isHoveredChat
                      ? 'assets/images/chatHover.png'
                      : 'assets/images/chat.png',
                  height: 50,
                  width: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          childCurrent: const chatPage(),
                          child: mainPage(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                onHover: (isHovered) => setState(() => _isHoveredCalendar = isHovered),
                child: Image.asset(
                  _isHoveredCalendar
                      ? 'assets/images/calendarHover.png'
                      : 'assets/images/calendar.png',
                  height: 50,
                  width: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          childCurrent: const calendar(),
                          child: mainPage(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              )
            ),
            const SizedBox(height: 30,),
             Center(
              child: InkWell(
                onHover: (isHovered) => setState(() => _isHoveredTask = isHovered),
                child: Image.asset(
                  _isHoveredTask
                      ? 'assets/images/tasksHover.png'
                      : 'assets/images/tasks.png',
                  height: 50,
                  width: 50,
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
              )
            ),
            const SizedBox(height: 30,),
             Center(
              child: InkWell(
                onHover: (isHovered) => setState(() => _isHoveredAnnoucement = isHovered),
                child: Image.asset(
                  _isHoveredAnnoucement
                      ? 'assets/images/announcementHover.png'
                      : 'assets/images/announcement.png',
                  height: 50,
                  width: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          childCurrent: const theAnnoucement(),
                          child: mainPage(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              )
            ),
                const SizedBox(height: 30,),
             Center(
              child: InkWell(
                onHover: (isHovered) => setState(() => _isHoveredRequests = isHovered),
                child: Image.asset(
                  _isHoveredRequests
                      ? 'assets/images/requestsHover.png'
                      : 'assets/images/requests.png',
                  height: 50,
                  width: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          childCurrent: const requests(),
                          child: mainPage(),
                          type: PageTransitionType.theme,
                          duration: const Duration(seconds: 2)));
                },
              )
            ),
            const SizedBox(height: 60,),
             Center(
              child: InkWell(
                onHover: (isHovered) => setState(() => _isHoveredManual = isHovered),
                child: Image.asset(
                  _isHoveredManual
                      ? 'assets/images/helpHover.png'
                      : 'assets/images/help.png',
                  height: 50,
                  width: 50,
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
              )
            ),
              
          ]),
        ),
      ),
    );
  }
}
