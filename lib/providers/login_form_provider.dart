import 'package:dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
