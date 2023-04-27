import 'dart:convert';
import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path_provider/path_provider.dart';

class requestList extends StatefulWidget {
  List<String> docNames;
  List<String> docContent; //should be an int
  requestList({super.key, required this.docContent, required this.docNames});

  @override
  State<requestList> createState() => _requestListState();
}

class _requestListState extends State<requestList> {
  Future<void> downloadDoc(base64String) async {
    try {
      List<int> bytes = base64.decode(base64String);
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/docs.docx';
      final file = File(path);
      await file.writeAsBytes(bytes);
      await Process.run('explorer', [path]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
