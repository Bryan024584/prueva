import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter_delivery/src/models/address.dart';
import 'package:udemy_flutter_delivery/src/models/order.dart';
import 'package:udemy_flutter_delivery/src/models/product.dart';
import 'package:udemy_flutter_delivery/src/models/response_api.dart';
import 'package:udemy_flutter_delivery/src/models/user.dart';
import 'package:udemy_flutter_delivery/src/providers/address_provider.dart';
import 'package:udemy_flutter_delivery/src/providers/orders_provider.dart';

class ClientAddressListController extends GetxController {

  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  var radioValue = 0.obs;

  ClientAddressListController() {
    print('LA DIRECCION DE SESION ${GetStorage().read('address')}');
  }

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');
    print('Address ${address}');
    Address a = Address.fromJson(GetStorage().read('address') ?? {}) ; // DIRECCION SELECCIONADA POR EL USUARIO
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) { // LA DIRECCION DE SESION COINCIDE CON UN DATOS DE LA LISTA DE DIRECCIONES
      radioValue.value = index;
    }

    return address;
  }

  void createOrder() async {
    Get.toNamed('/client/payments/create');


  }

  void handleRadioValueChange(int? value) {
    radioValue.value = value!;
    print('VALOR SELECCIONADO ${value}');
    GetStorage().write('address', address[value].toJson());
    update();
  }

  void goToAddressCreate() {
    Get.toNamed('/client/address/create');
  }

}