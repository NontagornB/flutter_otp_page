import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_page/models/numbers_models.dart';
import 'package:otp_page/views/otp_screen.dart';

class NumberViewModel extends GetxController {
  final numberController = TextEditingController();

  bool isNumberValid() {
    String input = numberController.text.trim();
    return input.length == 10 && input[0] == '0';
  }

  void sendNumber() {
    int number = int.tryParse(numberController.text) ?? 0;
    Get.to(OTPScreen(numberModel: NumberModel(number)));
  }
}
