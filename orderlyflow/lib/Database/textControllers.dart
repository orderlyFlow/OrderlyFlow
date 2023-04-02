import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  static Rx<TextEditingController> ID_controller = TextEditingController().obs;
  static Rx<TextEditingController> Pass_controller =
      TextEditingController().obs;
  static Rx<TextEditingController> OTP_controller = TextEditingController().obs;
  static Rx<TextEditingController> Message_controller =
      TextEditingController().obs;
  static Rx<TextEditingController> searchController =
      TextEditingController().obs;
  static RxInt Rec_ID = 0.obs;
  static RxBool ID_found = false.obs;
  static RxBool Pass_found = false.obs;
  static RxBool OTP_found = false.obs;
  static RxBool Login_found = false.obs;
  static RxBool isSendingMessage = false.obs;
}
