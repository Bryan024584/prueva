import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/category.dart';
import 'package:udemy_flutter_delivery/src/models/product.dart';
import 'package:udemy_flutter_delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:udemy_flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:udemy_flutter_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:udemy_flutter_delivery/src/pages/register/register_page.dart';
import 'package:udemy_flutter_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:udemy_flutter_delivery/src/utils/custom_animated_bottom_bar.dart';
import 'package:udemy_flutter_delivery/src/widgets/no_data_widget.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController con = Get.put(ClientProductsListController());

  ClientProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(() => DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(115),
          child: AppBar(
            flexibleSpace: Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.topCenter,
              child: Wrap(
                direction: Axis.horizontal,

                children: [
                  _textFieldSearch(context),
                  _iconShoppingBag()
                ],
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.amber,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600],
              tabs: List<Widget>.generate(con.categories.length, (index) {
                return Tab(
                  child: Text(con.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        body: TabBarView(
          children: con.categories.map((Category category) {
            return FutureBuilder(
                future: con.getProducts(category.id ?? '1', con.productName.value),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardProduct(context, snapshot.data![index]);
                          }
                      );
                    }
                    else {
                      return NoDataWidget(text: 'No hay productos');
                    }
                  }
                  else {
                    return NoDataWidget(text: 'No hay productos');
                  }
                }
            );
          }).toList(),
        )
      ),
    ));
  }

  Widget _iconShoppingBag() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: con.items.value > 0
        ? Stack(
          children: [
            IconButton(
                onPressed: () => con.goToOrderCreate(),
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 33,
                )
            ),

            Positioned(
                right: 4,
                top: 12,
                child: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Text(
                    '${con.items.value}',
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                )
            )
          ],
        )
        : IconButton(
            onPressed: () => con.goToOrderCreate(),
            icon: const Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            )
        ),
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width  * 0.75,
        child: TextField(
          onChanged: con.onChangeText,
          decoration: InputDecoration(
            hintText: 'Buscar producto',
            suffixIcon: const Icon(Icons.search, color: Colors.grey),
            hintStyle: const TextStyle(
              fontSize: 17,
              color: Colors.grey
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.grey
              )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: Colors.grey
                )
            ),
            contentPadding: const EdgeInsets.all(15)
          ),
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => con.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              title: Text(product.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 13
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '\$${product.price.toString()}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              trailing: SizedBox(
                height: 70,
                width: 60,
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
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300], indent: 37, endIndent: 37,)
        ],
      ),
    );
  }

}
