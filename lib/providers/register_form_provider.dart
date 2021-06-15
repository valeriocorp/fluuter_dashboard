import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterFormController extends GetxController {
  var email = '';
  var password = '';
  var name = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
