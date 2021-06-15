import 'package:dashboard/datatables/categories_datasource.dart';
import 'package:dashboard/providers/categories_provider.dart';
import 'package:dashboard/ui/buttons/custom_icon_button.dart';
import 'package:dashboard/ui/labels/custom_label.dart';
import 'package:dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesView extends StatefulWidget {
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    Get.find<CategoriesProvider>().getCategories();
  }

  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    final categorias = Get.find<CategoriesProvider>().categories;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Categorias View",
            style: CustomLabel.h1,
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() => PaginatedDataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Categoria')),
                  DataColumn(label: Text('Creado por')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: CategoriesDTS(categorias.value),
                header: Text(
                  'Categorias disponibles',
                  maxLines: 2,
                ),
                rowsPerPage: _rowPerPage,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowPerPage = value ?? 10;
                  });
                },
                actions: [
                  CustomiconButton(
                      onPressed: () {
                        Get.bottomSheet(CategoryModal());
                      },
                      text: 'Crear',
                      icon: Icons.add_outlined),
                ],
              )),
        ],
      ),
    );
  }
}
