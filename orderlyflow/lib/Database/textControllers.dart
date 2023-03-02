import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  static Rx<TextEditingController> ID_controller = TextEditingController().obs;
  static Rx<TextEditingController> Pass_controller =
      TextEditingController().obs;
  static Rx<TextEditingController> OTP_controller = TextEditingController().obs;
  static Rx<dynamic> ID_found = false.obs;
  static Rx<dynamic> Pass_found = false.obs;
  static Rx<dynamic> OTP_found = false.obs;
}
