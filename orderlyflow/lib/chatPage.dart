import 'package:flutter/material.dart';
import 'package:orderlyflow/resources/colors.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => chatPageState();
}

class chatPageState extends State<chatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryParticipantColor,
      appBar: AppBar(
        title: Text('Chat Page'),
        backgroundColor: Colors.blueAccent[800],
        foregroundColor: Colors.deepPurpleAccent[200],
      ),
      // ignore: prefer_const_constructors
      body: Center(
        child: const Text('Currently dying'),
      ),
    );
  }
}
