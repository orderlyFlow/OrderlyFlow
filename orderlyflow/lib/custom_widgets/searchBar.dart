import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../Database/db.dart';
import '../Database/textControllers.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          color: Paletter.mainBgLight,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: TextField(
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Iceland',
              fontSize: 0.027 * ScreenHeight,
            ),
            controller: StoreController.searchController.value,
            cursorColor: Paletter.mainBg,
            decoration: InputDecoration(
              fillColor: Colors.grey[350],
              hintText: 'Search...',
              helperStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'Iceland',
                fontSize: 0.027 * ScreenHeight,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => StoreController.searchController.value =
                    "" as TextEditingController,
              ),
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  var p = MongoDB.searchFor();
                  print(p);
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
