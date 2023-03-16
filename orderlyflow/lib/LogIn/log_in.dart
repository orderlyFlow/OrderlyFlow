// ignore_for_file: prefer_const_constructors, deprecated_member_use
//import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:orderlyflow/Database/db.dart';
import 'package:page_transition/page_transition.dart';
import '../Database/constant.dart';
import '../Database/textControllers.dart';
import '../palette.dart';
import 'package:orderlyflow/main_page.dart';
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

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final StoreController textControllers = Get.put(StoreController());
// to validate the form
  late String password;
  late String user;
  late String otp;

  // Future<String?> _getUserFullName(String id) async {
  //   final db = await Mongo.Db.create(mongoDB_URL);
  //   await db.open();
  //   final collection = db.collection('Personnel');
  //   final userData = await collection
  //       .findOne(Mongo.where.eq('ID', Mongo.ObjectId.fromHexString(id)));
  //   await db.close();

  //   if (userData == null) {
  //     return null; // User not found
  //   }

  //   return userData['name']
  //       as String; // Replace with the actual field name in your database
  // }

  @override
  Widget build(BuildContext context) {
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
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[700]),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Paletter.logInText;
                                return null;
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ))),
                          onPressed: () {
                            MongoDB.getPassword();
                            MongoDB.getID();
                            MongoDB.getOTP();
                            if (StoreController.ID_found.value == true &&
                                StoreController.Pass_found.value ==
                                    true && StoreController.OTP_found.value == true)
                            }
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      childCurrent: mainPage(),
                                      child: mainPage(),
                                      type: PageTransitionType.theme,
                                      duration: const Duration(seconds: 2)));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Incorrect ID or Password!'),
                              ));
                            }
                            //}
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Neuropol',
                            ),
                          ),
                        ),
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
                          onPressed: () {},
                          child: Text(
                            'forgot password?',
                            style: TextStyle(
                                color: Paletter.logInText,
                                fontFamily: 'Neuropol'),
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
