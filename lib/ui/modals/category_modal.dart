import 'package:dashboard/models/category.dart';
import 'package:dashboard/providers/categories_provider.dart';
import 'package:dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:dashboard/ui/inputs/custom_inputs.dart';
import 'package:dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryModal extends StatefulWidget {
  final Categoria? categoria;
  const CategoryModal({Key? key, this.categoria}) : super(key: key);

  @override
  _CategoryModalState createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String nombre = '';
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.categoria?.id;
    nombre = widget.categoria?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Get.find<CategoriesProvider>();
    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      width: 300,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.categoria?.nombre ?? 'Nueva Categoria',
                style: CustomLabel.h1.copyWith(
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.3),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: widget.categoria?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.authInputDecoration(
              hint: 'Nombre de la categoria',
              label: "Categoria",
              icon: Icons.new_releases_outlined,
            ),
            style: TextStyle(color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              text: 'Guardar',
              color: Colors.white,
              onPressed: () async {
                try {
                  if (id == null) {
                    await categoryProvider.newCategorie(nombre);
                    Get.back();

                    Get.snackbar(
                      "",
                      "",
                      backgroundColor: Colors.black38,
                      messageText: Text(
                        '$nombre creada',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    await categoryProvider.updateCategorie(nombre, id!);
                    Get.back();

                    Get.snackbar(
                      "",
                      "",
                      backgroundColor: Colors.black38,
                      messageText: Text(
                        '$nombre actualizado',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                } catch (e) {
                  Get.back();

                  Get.snackbar(
                    "",
                    "",
                    messageText: Text(
                      "No se pudo guardar la categoria",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    backgroundColor: Colors.red.withOpacity(0.9),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xff0F2041),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
            ),
          ]);
}
