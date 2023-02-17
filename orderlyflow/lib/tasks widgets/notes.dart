import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:orderlyflow/palette.dart';

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  final TextEditingController notesController = TextEditingController();
  int lineNbr = 20;

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(0.02 * ScreenWidth, 0.03 * ScreenHeight,
          0.02 * ScreenWidth, 0.02 * ScreenHeight),
      height: ScreenHeight * 0.599,
      width: ScreenWidth * 0.4,
      decoration: BoxDecoration(
          color: Paletter.containerLight,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: TextStyle(
              fontFamily: 'conthrax',
              fontSize: 25,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: ScreenHeight * 0.5,
                child: Indexer(children: [
                  Indexed(
                    index: 2,
                    child: TextFormField(
                      style: TextStyle(
                        // height: ScreenHeight * 0.0002,
                        fontFamily: 'iceland',
                        fontSize: 20
                      ),
                      maxLines: null,
                      onChanged: (text){
                        int numLines = (text.length / 25).ceil();
                        if(numLines > lineNbr){
                          setState(() {
                            lineNbr = numLines;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'yes',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                Indexed(
                  index: 1,
                  child: Container(
                    width: ScreenWidth * double.infinity,
                    height: ScreenHeight * double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 18,),
                          for (int i = 0; i < lineNbr; i++)
                            Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black,
                                          width: ScreenWidth * 0.001))),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
             
              ]),
            ),
          ))
        ],
      ),
    );
  }
}
