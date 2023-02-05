// ignore: file_names
import 'package:flutter/material.dart';

class mainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                  child: Icon(Icons.home),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/contact'),
                  child: Icon(Icons.contacts),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/email'),
                  child: Icon(Icons.email),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/password'),
                  child: Icon(Icons.lock),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/help'),
                  child: Icon(Icons.help),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}