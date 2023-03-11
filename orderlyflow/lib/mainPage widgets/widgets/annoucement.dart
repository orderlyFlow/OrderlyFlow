import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:orderlyflow/palette.dart';

class announcement extends StatefulWidget {
  final List<AnnouncementData> announcements;

  const announcement({required this.announcements});
  @override
  State<announcement> createState() => _announcementState();
}

class AnnouncementData {
  final String userName;
  final String image;
  final String msg;
  AnnouncementData(
      {required this.userName, required this.image, required this.msg});
  @override
  String toString() {
    return 'stop this';
  }
}

class _announcementState extends State<announcement> {
  List<AnnouncementData> announceDefault = [
    AnnouncementData(
        userName: 'Rai',
        image: 'assets/images/logo.png',
        msg: 'Welcome to OrderlyFlow your new companion in this journey...')
  ];
  late List<AnnouncementData> filteredAnnouncements;
  bool _isFiltering = false;
  bool _isHovered = false;

  @override
  void initState() {
    filteredAnnouncements = widget.announcements;
    super.initState();
  }

  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: ScreenWidth * 0.40,
      height: 320,
      decoration: BoxDecoration(
          color: Paletter.containerDark,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  if (filteredAnnouncements.isEmpty) {}
                });
              },
              onHover: (isHovered) => setState(() => _isHovered = isHovered),
              child: Column(children: [
                Image.asset(
                  _isHovered
                      ? 'assets/images/filterHover.png'
                      : 'assets/images/filter.png',
                  height: 50,
                  width: 50,
                ),
              ])),
          Expanded(
            child: SingleChildScrollView(
              child: Container(),
            ),
          )
        ],
      ),
    );
  }
}
