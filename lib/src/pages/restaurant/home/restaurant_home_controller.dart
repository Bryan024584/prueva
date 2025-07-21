import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter_delivery/src/models/user.dart';
import 'package:udemy_flutter_delivery/src/providers/push_notifications_provider.dart';

class RestaurantHomeController extends GetxController {

  var indexTab = 0.obs;
  PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  RestaurantHomeController() {
    saveToken();
  }

  void saveToken() {
    if (user.id != null) {
      pushNotificationsProvider.saveToken(user.id!);
    }
  }

  void changeTab(int index) {
    indexTab.value = index;
  }

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false); // ELIMINAR EL HISTORIAL DE PANTALLAS
  }



}