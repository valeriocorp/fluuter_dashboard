import 'package:dashboard/api/CafeApi.dart';
import 'package:dashboard/models/category.dart';
import 'package:dashboard/models/http/categories_response.dart';
import 'package:get/get.dart';

class CategoriesProvider extends GetxController {
  var categories = <Categoria>[].obs;

  getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResponse = CategoriesResponse.fromMap(resp);
    this.categories.value = [...categoriesResponse.categorias];
  }

  Future newCategorie(String name) async {
    final data = {'nombre': name};

    try {
      final json = await CafeApi.post('/categorias', data);
      final newCategory = Categoria.fromMap(json);
      categories.add(newCategory);
    } catch (e) {
      throw 'Error al crear la categoria';
    }
  }

  Future updateCategorie(String name, String id) async {
    final data = {'nombre': name};

    try {
      await CafeApi.put('/categorias/$id', data);
      this.categories.value = this.categories.map((category) {
        if (category.id != id) return category;
        category.nombre = name;
        return category;
      }).toList();
    } catch (e) {
      throw 'Error al crear la categoria';
    }
  }

  Future deleteCategorie(String id) async {
    try {
      await CafeApi.delete('/categorias/$id', {});
      categories.removeWhere((categoria) => categoria.id == id);
    } catch (e) {}
  }
}
