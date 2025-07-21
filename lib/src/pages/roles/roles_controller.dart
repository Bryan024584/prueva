import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter_delivery/src/models/user.dart';
import 'package:udemy_flutter_delivery/src/models/Rol.dart';

class RolesController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  void goToPageRol(Rol rol) {
    Get.offNamedUntil(rol.route ?? '', (route) => false);
  }

}