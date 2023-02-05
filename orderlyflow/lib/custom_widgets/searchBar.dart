import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';

class SearchInput extends StatefulWidget {
  @override
  State<SearchInput> createState() => _SearchInputState();
}

// ignore: prefer_const_constructors
class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      width: 500,
      child: Column(
        children: [
          Row(children: [
            Flexible(
              flex: 1,
              child: TextField(
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Iceland',
                  fontSize: 20,
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
                        fontSize: 20,
                        fontFamily: 'Iceland'),
                    prefixIcon: Container(
                      padding: EdgeInsets.all(15),
                      child: Image.asset('assets/images/search.png'),
                      width: 18,
                    )),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
