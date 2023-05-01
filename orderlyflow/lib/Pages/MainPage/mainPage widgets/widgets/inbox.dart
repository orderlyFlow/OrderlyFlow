import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderlyflow/custom_widgets/palette.dart';

class inbox extends StatefulWidget {
  const inbox({super.key});

  @override
  State<inbox> createState() => _inboxState();
}

class _inboxState extends State<inbox> {
  String _joke = '';
  void _fetchJoke() async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final setup = json['setup'] as String;
      final punchline = json['punchline'] as String;
      setState(() {
        _joke = '$setup\n\n$punchline';
      });
    } else {
      setState(() {
        _joke = 'Failed to fetch joke';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Paletter.containerDark,
          borderRadius: BorderRadius.circular(15)),
      width: ScreenWidth * 0.5,
      height: ScreenHeight * 0.34,
      child: Column(
        children: [
          Container(
            width: ScreenWidth * 0.6,
            height: ScreenHeight * 0.05,
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(149, 171, 185, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: ScreenHeight * 0.01, left: ScreenWidth * 0.01),
              child: Text(
                "Random Joke",
                style: TextStyle(
                    fontFamily: 'neuropol',
                    fontSize: ScreenHeight * 0.03,
                    color: Color.fromRGBO(20, 70, 103, 1),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(0.8, 2.0),
                          blurRadius: 3,
                          color: Color.fromARGB(122, 35, 35, 35))
                    ]),
              ),
            ),
          ),
          Container(
            width: ScreenWidth * 0.6,
            height: ScreenHeight * 0.18,
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: ScreenHeight * 0.02, left: ScreenWidth * 0.01),
              child: Text(
                _joke,
                style: TextStyle(
                    fontFamily: 'neuropol',
                    fontSize: ScreenHeight * 0.033,
                    color: Color.fromRGBO(20, 70, 103, 1),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(0.8, 2.0),
                          blurRadius: 3,
                          color: Color.fromARGB(122, 35, 35, 35))
                    ]),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: _fetchJoke,
            backgroundColor: Color.fromARGB(255, 119, 132, 152),
            splashColor: Paletter.containerDark,
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
