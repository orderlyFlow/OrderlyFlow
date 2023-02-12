import 'package:flutter/material.dart';
import 'package:orderlyflow/palette.dart';

class inbox extends StatefulWidget {
  const inbox({super.key});

  @override
  State<inbox> createState() => _inboxState();
}

class _inboxState extends State<inbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
          color: Paletter.containerDark,
          borderRadius: BorderRadius.circular(15)),
      width: 700,
      height: 250,
      child: Column(
        children: [
          Container(
            width: 700,
            height: 50,
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(149, 171, 185, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              ),
            
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'Inbox',
                style: TextStyle(
                  fontFamily: 'neuropol',
                  fontSize: 24,
                  color: Color.fromRGBO(20, 70, 103, 1),
                  shadows: <Shadow> [
                    Shadow(
                      offset: Offset(0.8, 2.0),
                      blurRadius: 3,
                      color: Color.fromARGB(122, 35, 35, 35)
                    )
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}