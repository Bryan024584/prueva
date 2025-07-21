import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter_delivery/src/models/order.dart';
import 'package:udemy_flutter_delivery/src/models/user.dart';
import 'package:udemy_flutter_delivery/src/providers/orders_provider.dart';

class ClientOrdersListController extends GetxController {

  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status = <String>['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByClientAndStatus(user.id ?? '0', status);
  }

  void goToOrderDetail (Order order) {
    Get.toNamed('/client/orders/detail', arguments: {
      'order': order.toJson()
    });
  }
}