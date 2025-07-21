import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/category.dart';
import 'package:udemy_flutter_delivery/src/models/response_api.dart';
import 'package:udemy_flutter_delivery/src/providers/categories_provider.dart';

class RestaurantCategoriesCreateController extends GetxController {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  void createCategory() async {

    String name = nameController.text;
    String description = descriptionController.text;
    print('NAME: ${name}');
    print('DESCRIPTION: ${description}');

    if (name.isNotEmpty && description.isNotEmpty) {
      Category category = Category(
        name: name,
        description: description
      );

      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Proceso terminado', responseApi.message ?? '');

      if (responseApi.success == true) {
        clearForm();
      }

    }
    else {
      Get.snackbar('Formulario no valido', 'Ingresa todos los campos para crear la categoria');
    }

  }

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
  }

}