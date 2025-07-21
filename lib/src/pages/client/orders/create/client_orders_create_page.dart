import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/product.dart';
import 'package:udemy_flutter_delivery/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:udemy_flutter_delivery/src/widgets/no_data_widget.dart';

class ClientOrdersCreatePage extends StatelessWidget {

  ClientOrdersCreateController con = Get.put(ClientOrdersCreateController());

  ClientOrdersCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx (() => Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(245, 245, 245, 1),
        height: 100,
        child: _totalToPay(context),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        title: const Text(
          'Mi Orden',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: con.selectedProducts.isNotEmpty
      ? ListView(
        children: con.selectedProducts.map((Product product) {
          return _cardProduct(product);
        }).toList(),
      )
      : Center(
          child:
          NoDataWidget(text: 'No hay ningun producto agregado aun')
      ),
    ));
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300]),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'TOTAL: \$${con.total.value}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),

                child: ElevatedButton(
                    onPressed: () => con.goToAddressList(),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)
                    ),
                    child: const Text(
                      'CONFIRMAR ORDER',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    )
                ),
              )
            ],
          ),
        )

      ],
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 7),
              _buttonsAddOrRemove(product)
            ],
          ),
          const Spacer(),
          Column(
            children: [
              _textPrice(product),
              _iconDelete(product)
            ],
          )
        ],
      ),
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
        onPressed: () => con.deleteItem(product),
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        )
    );
  }

  Widget _textPrice(Product product) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        '\$${ product.price! * product.quantity!}',
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buttonsAddOrRemove(Product product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => con.removeItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
            ),

            child: const Text('-'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child: Text('${product.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () => con.addItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
            ),
            child: const Text('+'),
          ),
        ),
      ],
    );
  }

  Widget _imageProduct(Product product) {
    return SizedBox(
      height: 70,
      width: 70,
      // padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder:  const AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }
}
