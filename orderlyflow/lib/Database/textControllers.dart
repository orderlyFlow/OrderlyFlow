import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderlyflow/Database/db.dart';

import '../Pages/MainPage/tasks.dart';

class StoreController extends GetxController {
  static Rx<TextEditingController> ID_controller = TextEditingController().obs;
  static Rx<TextEditingController> Pass_controller =
      TextEditingController().obs;
  static Rx<TextEditingController> OTP_controller = TextEditingController().obs;
  static Rx<TextEditingController> Message_controller =
      TextEditingController().obs;
  static Rx<TextEditingController> searchController =
      TextEditingController().obs;
  static StreamController<List<Map<String, dynamic>>> messageStreamController =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  static Future<List<Map<String, dynamic>>>? searchedEmployee;
  static List<Map<String, dynamic>> input = [];
  static List<int> individualRecIDs = [];
  static List<Map<String, dynamic>> groups = [];
  static List<Map<String, dynamic>> indRec = [];
  static Map<String, dynamic>? currentUser;
  static Future<List<Tasks>>? renderedFutureTasks;
  static List<Tasks> renderedTasks = [];
  static Future<List<Map<String, dynamic>>>? receiversList;
  static List<Map<String, dynamic>> AllChats = [];
  static List<String> GroupMembers = [];

  static RxInt Rec_ID = 0.obs;
  static RxInt Searched_ID = 0.obs;
  static RxBool isHR = false.obs;
  static RxBool isDirector = false.obs;

  static RxBool ID_found = false.obs;
  static RxBool Pass_found = false.obs;
  static RxBool OTP_found = false.obs;
  static RxBool Login_found = false.obs;
  static RxBool isSearching = false.obs;
  static RxBool isSendingMessage = false.obs;
  static RxDouble onSiteRatio = 0.0.obs;
  static RxDouble remoteRatio = 0.0.obs;
}
