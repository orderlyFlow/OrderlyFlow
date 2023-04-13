// ignore_for_file: prefer_const_constructors, deprecated_member_use
//import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Database/constant.dart';
import '../../../Database/textControllers.dart';
import '../../../custom_widgets/palette.dart';
import 'package:orderlyflow/Pages/MainPage/main_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogIn Page',
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final StoreController textControllers = Get.put(StoreController());
  bool _isLoading = false;
  bool isSendigOTP = false;
  late String password;
  late String user;
  late String otp;
  late AnimationController _controller;
  double otp_size = 14;
  var response = 0;

  void handleSending() async {
    setState(() {
      isSendigOTP = true;
    });
    try {
      if (StoreController.ID_controller.value.text.isNotEmpty) {
        response = await MongoDB.sendEmail();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Ooops ... Enter id',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Neuropol',
                fontSize: otp_size,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 101, 174,
                233), // Set the background color of the snackbar here
          ),
        );
      }
    } catch (e) {
    } finally {
      setState(() {
        isSendigOTP = false;
      });
    }
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await MongoDB.Verify_LogIn();
      // Perform some action for logged in user
    } catch (e) {
      // Perform some action for non-logged in user
    } finally {
      setState(() {
        _isLoading = false;
      });
      if (StoreController.Login_found.isTrue) {
        Navigator.push(
            context,
            PageTransition(
                childCurrent: mainPage(),
                child: mainPage(),
                type: PageTransitionType.theme,
                duration: const Duration(seconds: 2)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please check your credentials'),
        ));
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    otp_size = screenHeight * 0.023;
    return Scaffold(
      backgroundColor: Paletter.logInBg,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            // ignore: prefer_const_constructors
            margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 500,
                        child: Center(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: StoreController.ID_controller.value,
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    color: Paletter.blackText,
                                    fontFamily: 'Neuropol'),
                                decoration: InputDecoration(
                                    // ignore: prefer_const_constructors
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Paletter.logInText,
                                    ),
                                    hintText: 'Enter Your ID',
                                    // ignore: prefer_const_constructors
                                    hintStyle:
                                        TextStyle(color: Paletter.logInText),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        // ignore: prefer_const_constructors
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                199, 215, 225, 0.56))),
                                    filled: true,
                                    fillColor: const Color.fromRGBO(
                                        199, 215, 225, 0.56),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                199, 215, 225, 0.56)))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter your ID';
                                  }
                                  return null;
                                },
                                onSaved: (value) => user = value!,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                controller:
                                    StoreController.Pass_controller.value,
                                obscureText: true,
                                style: const TextStyle(
                                    color: Paletter.blackText,
                                    fontFamily: 'Neuropol'),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: Paletter.logInText,
                                    ),
                                    hintText: 'Enter Your Password',
                                    hintStyle: const TextStyle(
                                        color: Paletter.logInText),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                199, 215, 225, 0.56))),
                                    filled: true,
                                    fillColor: const Color.fromRGBO(
                                        199, 215, 225, 0.56),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                199, 215, 225, 0.56)))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Password';
                                  }
                                  return null;
                                },
                                onSaved: (value) => password = value!,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                controller:
                                    StoreController.OTP_controller.value,
                                obscureText: true,
                                style: const TextStyle(
                                    color: Paletter.blackText,
                                    fontFamily: 'Neuropol'),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.key_outlined,
                                      color: Paletter.logInText,
                                    ),
                                    hintText: 'Enter Your OTP',
                                    hintStyle: const TextStyle(
                                        color: Paletter.logInText),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                199, 215, 225, 0.56))),
                                    filled: true,
                                    fillColor: const Color.fromRGBO(
                                        199, 215, 225, 0.56),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                199, 215, 225, 0.56)))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Pleaser Enter Your given OTP';
                                  }
                                  return null;
                                },
                                onSaved: (value) => otp = value!,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        width: 300,
                        height: 50,
                        child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[700]),
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.hovered))
                                        return Paletter.logInText;
                                      return null;
                                    }),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ))),
                                onPressed: _isLoading ? null : _handleLogin,
                                child: _isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : Text(
                                        'Log In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Neuropol',
                                        ),
                                      ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor: null,
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return Paletter.logInBg;
                              return null;
                            }),
                          ),
                          onPressed: () async {
                            handleSending();
                            if (response == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Message Sent!'),
                                      backgroundColor:
                                          Color.fromARGB(255, 129, 215, 132)));
                            } else {
                              if (response != 200 && response != 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Failed to send message!'),
                                        backgroundColor: Color.fromARGB(
                                            255, 217, 123, 116)));
                              }
                            }
                          },
                          child: isSendigOTP
                              ? Container(
                                  width: screenWidth,
                                  height: screenHeight * 0.043,
                                  color: Paletter.logInBg,
                                  child: SpinKitChasingDots(
                                    color: Paletter.gradiant3,
                                    size: screenHeight * 0.033,
                                  ))
                              : Text(
                                  'forgot otp?',
                                  style: TextStyle(
                                      color: Paletter.logInText,
                                      fontFamily: 'Neuropol',
                                      fontSize: screenHeight * 0.023),
                                ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
