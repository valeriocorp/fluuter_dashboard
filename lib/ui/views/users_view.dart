import 'package:dashboard/datatables/users_datasouerce.dart';
import 'package:dashboard/providers/users_provider.dart';
import 'package:dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProviders = Get.find<UsersProvider>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Users View",
            style: CustomLabel.h1,
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() => PaginatedDataTable(
                sortAscending: usersProviders.ascendin.value,
                sortColumnIndex: usersProviders.sortColumnIndex,
                columns: [
                  DataColumn(label: Text('Avatar')),
                  DataColumn(
                      label: Text('Nombre'),
                      onSort: (index, _) {
                        usersProviders.sortColumnIndex = index;
                        usersProviders.sort<String>((user) => user.nombre);
                      }),
                  DataColumn(
                      label: Text('Email'),
                      onSort: (index, _) {
                        usersProviders.sortColumnIndex = index;
                        usersProviders.sort((user) => user.correo);
                      }),
                  DataColumn(label: Text('UID')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: UsersDTS(usersProviders.users.value),
                onPageChanged: (page) {},
              )),
        ],
      ),
    );
  }
}
