import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;



class notes extends StatefulWidget {
  String content;
  int noteId;
  notes({super.key,  required  this.content, required this.noteId});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  late String textIntro;
  late TextEditingController notesController = TextEditingController();

  Future<void> Save(String data) async{
    var db = await Mongo.Db.create(mongoDB_URL);
    await db.open();
    var col = db.collection(notesCol);
    await col.update(Mongo.where.eq('noteID', widget.noteId), Mongo.modify.set('content', data));

  }

  Future <void> delete() async{
    var db = await Mongo.Db.create(mongoDB_URL);
    await db.open();
    var col = db.collection(notesCol);
    await col.update(Mongo.where.eq('noteID', widget.noteId), Mongo.modify.set('content', ''));
  }

  void handleSave(){
    String txt = notesController.text;
    Save(txt);
  }

  void handleDelete(){
    notesController.clear();
    delete();
  }

  @override
  void initState(){
    super.initState();
    textIntro = widget.content;
    notesController = TextEditingController(text: textIntro);
  }

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  fontFamily: 'conthrax',
                  fontSize: ScreenHeight * 0.04,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(width: ScreenWidth * 0.15,),
              CircleAvatar(
                radius: ScreenHeight * 0.03,
                backgroundColor: Paletter.mainBg,
                child: Center(
                  child: IconButton(
                    onPressed: handleDelete,
                    icon: Icon(
                      Icons.delete,
                      color: Paletter.containerLight,
                    )),
                ),
              ),
              SizedBox(width: ScreenWidth * 0.01,),
              CircleAvatar(
                radius: ScreenHeight * 0.03,
                backgroundColor: Paletter.mainBg,
                child: Center(
                  child: IconButton(onPressed: handleSave,
                   icon: Icon(
                    Icons.save,
                    color: Paletter.containerLight,
                    
                    
                   )
                   ),
                ),
              )
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: SizedBox(
              height: ScreenHeight * 0.5,
              child: Indexer(children: [
                Indexed(
                  index: 2,
                  child: TextFormField(
                    controller: notesController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontFamily: "iceland",
                        fontSize: ScreenHeight * 0.026,
                        color: Paletter.blackText,
                        letterSpacing: ScreenHeight * 0.0025,
                        wordSpacing: 2.0,
                        height: 1.5),
                    decoration: InputDecoration(
                      hintText: widget.content,
                      hintStyle: TextStyle(
                          fontSize: ScreenHeight * 0.016,
                          letterSpacing: ScreenHeight * 0.005),
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