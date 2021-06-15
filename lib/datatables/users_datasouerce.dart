import 'package:dashboard/models/usuario.dart';
import 'package:dashboard/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersDTS extends DataTableSource {
  final List<Usuario> users;

  UsersDTS(this.users);
  @override
  DataRow getRow(int index) {
    final Usuario user = users[index];
    final image = (user.img == null)
        ? Image(
            image: AssetImage('no-image.jpg'),
            width: 35,
            height: 35,
          )
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif',
            image: user.img!,
            width: 35,
            height: 35,
          );
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          ClipOval(child: image),
        ),
        DataCell(
          Text(user.nombre),
        ),
        DataCell(
          Text(user.correo),
        ),
        DataCell(
          Text(user.uid),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(
                    '${Routes.USERSROUTE}/${user.uid}',
                  );
                },
                icon: Icon(
                  Icons.edit_outlined,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: 'Estas seguro de borrarlo ?',
                      textConfirm: 'Si, borrar',
                      textCancel: 'No',
                      onConfirm: () {
                        Get.back();
                      },
                      onCancel: () {},
                      middleText: 'Borrando definitivamente:}');
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
