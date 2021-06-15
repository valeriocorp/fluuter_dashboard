import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBarProvider extends GetxController {
  static late AnimationController menuController;
  var _currentPage = '/dashboard'.obs;
  String get currentPage {
    return _currentPage.value;
  }

  void setCurrentPageUrl(String routeName) {
    Future.delayed(100.milliseconds, () {
      _currentPage.value = routeName;
    });
  }

  static RxBool isOpen = false.obs;
  static Animation<double> movement = Tween<double>(begin: -200, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));
  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));
  static void openMenu() {
    isOpen.value = true;
    menuController.forward();
  }

  static void closeMenu() {
    isOpen.value = false;
    menuController.reverse();
  }

  static void toggleMenu() {
    (isOpen.value) ? menuController.reverse() : menuController.forward();
    isOpen.value = !isOpen.value;
  }
}
