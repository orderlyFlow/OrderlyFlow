
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orderlyflow/custom_widgets/BlueBg.dart';
import 'package:orderlyflow/palette.dart';
import 'package:orderlyflow/side_bar.dart';

class requests extends StatefulWidget {
  const requests({super.key});

  @override
  State<requests> createState() => _requestsState();
}

class _requestsState extends State<requests> {
  final String fileName = 'word1.docx';
  int downloadCount = 1;

   Future<void> _downloadFile(BuildContext context) async {
    // Get the app's documents directory
    Directory documentsDir = await getApplicationDocumentsDirectory();

    // Get the path to the asset file
    String assetsPath = 'assets/' + fileName;
    ByteData assetData = await rootBundle.load(assetsPath);

   // Generate a unique filename based on the download count
  String uniqueFileName = '$fileName-$downloadCount.docx';

  // Increment the download count
  downloadCount++;

  // Write the asset file to the app's documents directory
  File file = File('${documentsDir.path}/$uniqueFileName');
  await file.writeAsBytes(assetData.buffer.asUint8List());
    // Show a snackbar to indicate that the download is complete
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Download complete!'),
      ),
    );
  }
 
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
                              SizedBox(height: ScreenHeight * 0.02,),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                   
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: ScreenWidth * 0.02, right: ScreenWidth*0.02),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: ScreenHeight*0.15,
                                          width: ScreenWidth * 0.4,
                                          decoration: BoxDecoration(
                                            color: Paletter.containerLight,
                                            borderRadius: BorderRadius.circular(13),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: ScreenWidth * 0.006, vertical: ScreenHeight * 0.03),
                                            child: Row(
                                              children: [
                                                Image.asset('assets/images/doc.png',
                                                width: ScreenHeight * 0.1,),
                                                SizedBox(width: ScreenWidth * 0.01,),
                                                Text('${fileName}',
                                                style: TextStyle(
                                                  fontSize: ScreenHeight * 0.03,
                                                  fontFamily: 'conthrax',
                                                  color: Paletter.blackText
                                                ),),
                                                SizedBox(width: ScreenWidth * 0.13,),
                                                IconButton(
                                                  onPressed:() {
                                                    _downloadFile(context);
                                                  },
                                                   icon: Icon(Icons.download)
                                                  
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: ScreenHeight * 0.02,),
                                      Padding(
                                        padding: EdgeInsets.only(left: ScreenWidth * 0.02, right: ScreenWidth*0.02),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: ScreenHeight*0.15,
                                          width: ScreenWidth * 0.4,
                                          decoration: BoxDecoration(
                                            color: Paletter.containerLight,
                                            borderRadius: BorderRadius.circular(13),
                                          ),
                                        ),
                                      ),
                                       SizedBox(height: ScreenHeight * 0.02,),
                                      Padding(
                                        padding: EdgeInsets.only(left: ScreenWidth * 0.02, right: ScreenWidth*0.02),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: ScreenHeight*0.15,
                                          width: ScreenWidth * 0.4,
                                          decoration: BoxDecoration(
                                            color: Paletter.containerLight,
                                            borderRadius: BorderRadius.circular(13),
                                          ),
                                        ),
                                      ), SizedBox(height: ScreenHeight * 0.02,),
                                      Padding(
                                        padding: EdgeInsets.only(left: ScreenWidth * 0.02, right: ScreenWidth*0.02),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: ScreenHeight*0.15,
                                          width: ScreenWidth * 0.4,
                                          decoration: BoxDecoration(
                                            color: Paletter.containerLight,
                                            borderRadius: BorderRadius.circular(13),
                                          ),
                                        ),
                                      ),
                                       SizedBox(height: ScreenHeight * 0.02,),
                                      Padding(
                                        padding: EdgeInsets.only(left: ScreenWidth * 0.02, right: ScreenWidth*0.02),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: ScreenHeight*0.15,
                                          width: ScreenWidth * 0.4,
                                          decoration: BoxDecoration(
                                            color: Paletter.containerLight,
                                            borderRadius: BorderRadius.circular(13),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenWidth * 0.01,),
                        Column(
                          children: [
                            Container(
                              height: ScreenHeight * 0.53,
                              width: ScreenWidth * 0.5,
                              decoration: BoxDecoration(
                                color: Paletter.containerLight,
                                borderRadius: BorderRadius.circular(13)
                              ),
                            ),
                            SizedBox(height: ScreenHeight * 0.024,),
                            Container(
                              height: ScreenHeight * 0.4,
                              width: ScreenWidth * 0.5,
                              decoration: BoxDecoration(
                                color: Paletter.containerLight,
                                borderRadius: BorderRadius.circular(13)
                              ),
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
