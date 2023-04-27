import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:orderlyflow/Pages/RequestPage/ListofRequest.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orderlyflow/custom_widgets/BlueBg.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:orderlyflow/custom_widgets/side_bar.dart';

class requests extends StatefulWidget {
  const requests({super.key});

  @override
  State<requests> createState() => _requestsState();
}

class _requestsState extends State<requests> {
  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: ScreenWidth * 0.4,
                          height: ScreenHeight * 0.96,
                          decoration: BoxDecoration(
                              color: Paletter.containerDark,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Container(
                                  width: ScreenWidth * 0.6,
                                  height: ScreenHeight * 0.05,
                                  alignment: Alignment.topCenter,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(97, 127, 187, 1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  )),
                              SizedBox(
                                height: ScreenHeight * 0.02,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: ScreenWidth * 0.02),
                                  child: Text(
                                    "Forms",
                                    style: TextStyle(
                                      color: Paletter.blackText,
                                      fontFamily: 'iceland',
                                      fontSize: ScreenHeight * 0.07,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenHeight * 0.02,
                              ),
                              Container(
                                child: FutureBuilder(
                                    future: Future.wait([
                                      MongoDB.getDocNames(),
                                     
                                    ]),
                                    builder: (buildContext,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        List<String> docNames =
                                            snapshot.data[0];                               
                                        return requestList(docNames: docNames);
                                      } else {
                                        return CircularProgressIndicator(
                                          color: Colors.white,
                                          
                                        );
                                      }
                                    }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: ScreenWidth * 0.01,
                        ),
                        Column(
                          children: [
                            Container(
                              height: ScreenHeight * 0.53,
                              width: ScreenWidth * 0.5,
                              decoration: BoxDecoration(
                                  color: Paletter.containerLight,
                                  borderRadius: BorderRadius.circular(13)),
                            ),
                            SizedBox(
                              height: ScreenHeight * 0.024,
                            ),
                            Container(
                              height: ScreenHeight * 0.4,
                              width: ScreenWidth * 0.5,
                              decoration: BoxDecoration(
                                  color: Paletter.containerLight,
                                  borderRadius: BorderRadius.circular(13)),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
