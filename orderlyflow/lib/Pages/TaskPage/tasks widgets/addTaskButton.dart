import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:orderlyflow/Database/constant.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:orderlyflow/Pages/TaskPage/tasks.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';

class addTaskButton extends StatefulWidget {
  int ID;
  List<int> ids;
  List<String> names = [];
  addTaskButton(
      {super.key, required this.ID, required this.ids, required this.names});

  @override
  State<addTaskButton> createState() => _addTaskButtonState();
}

class _addTaskButtonState extends State<addTaskButton> {
  late int id;
  bool _isUpper = false;
  late TextEditingController tasksController = TextEditingController();

  List<int> pickedIds = [];

  void toggleId(int id) {
    setState(() {
      if (pickedIds.contains(id)) {
        pickedIds.remove(id);
      } else {
        pickedIds.add(id);
      }
    });
  }

  void checkID() async {
    final db = await Mongo.Db.create(mongoDB_URL);
    await db.open();
    final coll = db.collection(tasksCol);
    final idList = await coll.find().map((task) => task['TaskID']).toList();
    int ID = 1000;
    while (idList.contains(ID)) {
      ID++;
    }
    late String? taskName = tasksController.text;
    addTask(ID, taskName, pickedIds);
    Navigator.of(context).pop(pickedIds);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => myTasks(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  static Future<void> addTask(
      int TaskID, String taskname, List<int> employees) async {
    final db1 = await Mongo.Db.create(mongoDB_URL);
    final collection = db1.collection(tasksCol);
    await db1.open();

    final document = {
      "TaskID": TaskID,
      "taskName": taskname,
      "Employees": employees,
      "status": false
    };

    collection.insertOne(document);
  }

  @override
  void initState() {
    super.initState();
    id = widget.ID;

    if (id == 100000 ||
        id == 200000 ||
        id == 300000 ||
        id == 400000 ||
        id == 500000 ||
        id == 600000 ||
        id == 700000 ||
        id == 800000 ||
        id == 90000) {
      _isUpper = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    if (_isUpper) {
      return Column(
        children: [
          CircleAvatar(
            backgroundColor: Paletter.mainBg,
            child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return SingleChildScrollView(
                            child: Container(
                              height: ScreenHeight * 0.5,
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: ScreenWidth * 0.001),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Create Task',
                                      style: TextStyle(
                                          fontFamily: 'conthrax',
                                          fontSize: ScreenHeight * 0.03,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: ScreenHeight * 0.05),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenWidth * 0.0001),
                                              margin: EdgeInsets.only(left: ScreenWidth * 0.01),
                                          width: ScreenWidth * 0.4,
                                          child: TextField(
                                            controller: tasksController,
                                            decoration: InputDecoration(
                                              hintText: 'Add task name here',
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ScreenWidth * 0.03),
                                        Container(
                                          height: ScreenHeight * 0.1,
                                          width: ScreenWidth * 0.2,
                                          child: Expanded(
                                            child: ListView.builder(
                                              itemCount: widget.names.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  child: ListTile(
                                                    title: Text(
                                                        widget.names[index]),
                                                    subtitle: Text(
                                                        'ID: ${widget.ids[index]}'),
                                                    leading: Checkbox(
                                                      value: pickedIds.contains(
                                                          widget.ids[index]),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          toggleId(widget
                                                              .ids[index]);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: ScreenWidth * 0.01),
                                        Container(
                                          height: ScreenHeight * 0.08,
                                          margin: EdgeInsets.only(right: ScreenWidth * 0.01),
                                          child: ElevatedButton(
                                            onPressed: checkID,
                                            child: Icon(Icons.check),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Paletter.logInBg,
                                                shape: CircleBorder()),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: ScreenHeight * 0.03),
                                    Text('Picked IDs: ${pickedIds.join(', ')}'),
                                    SizedBox(
                                      height: ScreenHeight * 0.02,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(pickedIds);
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ),
        ],
      );
    } else {
      return Container(
        child: Text(''),
      );
    }
  }
}
