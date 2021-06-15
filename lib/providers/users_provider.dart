import 'package:dashboard/api/CafeApi.dart';
import 'package:dashboard/models/http/users_response.dart';
import 'package:dashboard/models/usuario.dart';
import 'package:get/get.dart';

class UsersProvider extends GetxController {
  var users = <Usuario>[].obs;
  var isLoading = true.obs;
  var ascendin = true.obs;
  int? sortColumnIndex;

  UsersProvider() {
    this.getPaginatedUsers();
  }

  getPaginatedUsers() async {
    final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResp = UsersResponse.fromMap(resp);
    this.users.value = [...usersResp.usuarios];
    isLoading.value = false;
  }

  Future<Usuario?> getUserByID(String uid) async {
    try {
      final resp = await CafeApi.httpGet('/usuarios/$uid');
      final user = Usuario.fromMap(resp);
      return user;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Usuario user) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascendin.value
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascendin.value = !ascendin.value;
  }

  void refreshUser(Usuario newuser) {
    this.users.value = this.users.map((user) {
      if (user.uid == newuser.uid) {
        user = newuser;
      }
      return user;
    }).toList();
  }
}
