/*import 'dart:convert';

import 'package:http/http.dart' as http;

void sendEmail() async {
  final apiKey = 'md-OavixCJKVC_aJVOPdoKb8Q';
  final endpointUrl = 'https://api.chipmunkapp.com/send';

  final headers = {
    'Content-Type': 'application/json',
    'X-API-KEY': 'amd-OavixCJKVC_aJVOPdoKb8Q',
  };

  var body = {
    'to': [
      {
        'email': 'recipient@example.com',
        'name': 'Recipient Name',
      }
    ],
    'from': {
      'email': 'sender@example.com',
      'name': 'Sender Name',
    },
    'subject': 'Test email',
    'html': '<p>This is a test email sent from Flutter using Chipmunk API.</p>',
  };

  var response = await http.post(Uri.parse(endpointUrl),
      headers: headers, body: jsonEncode(body));

  if (response.statusCode == 200) {
    print('Email sent successfully.');
  } else {
    print('Error sending email: ${response.body}');
  }
}
*/ ////////////////////NEED DOMAIN//////////////////////////////////

/*import 'package:flutter/material.dart';
import 'package:flutter_termii/flutter_termii.dart';

final termii = Termii(
  url: 'https://api.ng.termii.com',
  apiKey: 'YOUR API KEY',
  senderId: 'OrderlyFlow',
);
Future<void> sendSMS() async {
  final responseData = await termii.sendSms(
    destination: '961119085',
    message: "This is a test message",
  );
}*/
