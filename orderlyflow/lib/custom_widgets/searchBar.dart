import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SearchInput extends StatefulWidget {
  @override
  State<SearchInput> createState() => _SearchInputState();
}

// ignore: prefer_const_constructors
class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(children: [
              Flexible(
                flex: 1,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Iceland',
                    fontSize: 0.027 * ScreenHeight,
                  ),
                  cursorColor: Paletter.mainBg,
                  decoration: InputDecoration(
                      fillColor: Colors.grey[350],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 0.027 * ScreenHeight,
                          fontFamily: 'Iceland'),
                      prefixIcon: Container(
                        width: ScreenWidth / 50 * 0.00001,
                        height: ScreenHeight / 50 * 0.00001,
                        child: Image.asset('assets/images/search.png',
                            alignment: Alignment.center, fit: BoxFit.scaleDown),
                      )),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
