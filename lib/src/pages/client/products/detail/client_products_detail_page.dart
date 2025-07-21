import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/product.dart';
import 'package:udemy_flutter_delivery/src/pages/client/products/detail/client_products_detail_controller.dart';

class ClientProductsDetailPage extends StatelessWidget {

  Product? product;
  late ClientProductsDetailController con;
  var counter = 0.obs;
  var price = 0.0.obs;

  ClientProductsDetailPage({super.key, @required this.product}) {
    con = Get.put(ClientProductsDetailController());
  }

  @override
  Widget build(BuildContext context) {

    con.checkIfProductsWasAdded(product!, price, counter);
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
          color: const Color.fromRGBO(245, 245, 245, 1.0),
          height: 100,
          child: _buttonsAddToBag()
      ),
      body: Column(
        children: [
          _imageSlideshow(context),
          _textNameProduct(),
          _textDescriptionProduct(),
          _textPriceProduct()
        ],
      ),
    ));
  }

  Widget _textNameProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textDescriptionProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buttonsAddToBag() {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => con.removeItem(product!, price, counter),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(45, 37),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        )
                    )
                ),
                child: Text(
                  '-',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(40, 37),
                ),
                child: Text(
                  '${counter.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => con.addItem(product!, price, counter),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(45, 37),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )
                    )
                ),
                child: Text(
                  '+',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => con.addToBag(product!, price, counter),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                    ),
                ),
                child: Text(
                  'Agregar   \$${price.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        )

      ],
    );
  }

  Widget _textPriceProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        '\$${product?.price.toString() ?? ''}',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _imageSlideshow(BuildContext context) {
    return ImageSlideshow(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        initialPage: 0,
        indicatorColor: Colors.amber,
        indicatorBackgroundColor: Colors.grey,
        children: [
          FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: const AssetImage('assets/img/no-image.png'),
              image: product!.image1 != null
                  ? NetworkImage(product!.image1!)
                  : const AssetImage('assets/img/no-image.png') as ImageProvider
          ),
          FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: const AssetImage('assets/img/no-image.png'),
              image: product!.image2 != null
                  ? NetworkImage(product!.image2!)
                  : const AssetImage('assets/img/no-image.png') as ImageProvider
          ),
          FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: const AssetImage('assets/img/no-image.png'),
              image: product!.image3 != null
                  ? NetworkImage(product!.image3!)
                  : const AssetImage('assets/img/no-image.png') as ImageProvider
          ),
        ]
    );
  }
}
