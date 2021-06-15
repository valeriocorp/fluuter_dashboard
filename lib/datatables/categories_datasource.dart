import 'package:dashboard/models/category.dart';
import 'package:dashboard/providers/categories_provider.dart';
import 'package:dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesDTS extends DataTableSource {
  final List<Categoria> categorias;

  CategoriesDTS(this.categorias);
  @override
  DataRow getRow(int index) {
    final categoria = this.categorias[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text(categoria.id),
        ),
        DataCell(
          Text(categoria.nombre),
        ),
        DataCell(
          Text(categoria.usuario.nombre),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.bottomSheet(CategoryModal(
                    categoria: categoria,
                  ));
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
                      onConfirm: () async {
                        await Get.find<CategoriesProvider>()
                            .deleteCategorie(categoria.id);
                        Get.back();
                      },
                      onCancel: () {},
                      middleText:
                          'Borrando definitivamente: ${categoria.nombre}');
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
  int get rowCount => categorias.length;

  @override
  int get selectedRowCount => 0;
}
