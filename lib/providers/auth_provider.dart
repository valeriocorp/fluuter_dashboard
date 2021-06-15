import 'package:dashboard/api/CafeApi.dart';
import 'package:dashboard/models/http/auth_response.dart';
import 'package:dashboard/models/usuario.dart';
import 'package:dashboard/router/pages.dart';
import 'package:dashboard/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends GetxController {
  var _token = ''.obs;
  var authStatus = AuthStatus.checking.obs;
  Usuario? user;

  AuthProvider() {
    this.isAuthenticated();
  }

  login(String email, String password) {
    final data = {'correo': email, 'password': password};
    CafeApi.post('/auth/login', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      this.user = authResponse.usuario;
      LocalStorage.prefs.write('token', authResponse.token);
      authStatus.value = AuthStatus.authenticated;
      Get.toNamed(Routes.DASBOARDROUTE);
      CafeApi.configureDio();
      update();
    }).catchError((e) {
      Get.snackbar(
        "",
        "",
        messageText: Text(
          "Usuario / Password no validos",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.red.withOpacity(0.9),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  register(String email, String password, String name) {
    final data = {'nombre': name, 'correo': email, 'password': password};

    CafeApi.post('/usuarios', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      this.user = authResponse.usuario;
      authStatus.value = AuthStatus.authenticated;
      LocalStorage.prefs.write('token', authResponse.token);
      Get.toNamed(Routes.DASBOARDROUTE);
      CafeApi.configureDio();
      update();
    }).catchError((e) {
      Get.snackbar(
        "",
        "",
        messageText: Text(
          "Usuario / Password no validos",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.red.withOpacity(0.9),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus.value = AuthStatus.notAuthenticated;
    Get.offNamed(Routes.LOGINROUTE);
    Get.back();
    update();
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.read('token');
    if (token == null) {
      authStatus.value = AuthStatus.notAuthenticated;
      update();
      return false;
    }

    try {
      final resp = await CafeApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(resp);
      this.user = authResponse.usuario;
      authStatus.value = AuthStatus.authenticated;
      LocalStorage.prefs.write('token', authResponse.token);
      update();
      return true;
    } catch (e) {
      authStatus.value = AuthStatus.notAuthenticated;
      update();
      return false;
    }
  }
}
