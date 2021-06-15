import 'dart:typed_data';

import 'package:dashboard/api/CafeApi.dart';
import 'package:dashboard/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserFormProvider extends GetxController {
  late GlobalKey<FormState> formKey;
  final user = Usuario(
    rol: '',
    estado: false,
    google: false,
    nombre: '',
    correo: '',
    uid: '',
    img: '',
  ).obs;

  copyUserWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }) {
    user.value = new Usuario(
      rol: rol ?? this.user.value.rol,
      estado: estado ?? this.user.value.estado,
      google: google ?? this.user.value.google,
      nombre: nombre ?? this.user.value.nombre,
      correo: correo ?? this.user.value.correo,
      uid: uid ?? this.user.value.uid,
      img: img ?? this.user.value.img,
    );
    update();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser() async {
    if (!this._validForm()) return false;
    final data = {'nombre': user.value.nombre, 'correo': user.value.correo};
    try {
      final resp = await CafeApi.put('/usuarios/${user.value.uid}', data);
      print(resp);
      return true;
    } catch (e) {
      print('Error en update user $e');
      return false;
    }
  }

  Future<Usuario> uploadImage(String path, Uint8List bytes) async {
    try {
      final resp = await CafeApi.uploadFile(path, bytes);
      user.value = Usuario.fromMap(resp);
      update();
      return user.value;
    } catch (e) {
      print(e);
      throw 'Error en file upload';
    }
  }
}
