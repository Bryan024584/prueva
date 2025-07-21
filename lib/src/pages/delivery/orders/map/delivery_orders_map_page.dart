import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:udemy_flutter_delivery/src/pages/client/address/map/client_address_map_controller.dart';
import 'package:udemy_flutter_delivery/src/pages/delivery/orders/map/delivery_orders_map_controller.dart';

class DeliveryOrdersMapPage extends StatelessWidget {

  DeliveryOrdersMapController con = Get.put(DeliveryOrdersMapController());

  DeliveryOrdersMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryOrdersMapController> (
      builder: (value) => Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: _googleMaps()
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonBack(),
                    _iconCenterMyLocation(),
                  ],
                ),
                const Spacer(),
                _cardOrderInfo(context),
              ],
            ),
          ),
          // _buttonAccept(context)
        ],
      ),
    ));
  }

  Widget _buttonBack() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _cardOrderInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: Column(
        children: [
          _listTileAddress(
              con.order.address?.neighborhood ?? '',
              'Barrio',
              Icons.my_location
          ),
          _listTileAddress(
              con.order.address?.address ?? '',
              'Direccion',
              Icons.location_on
          ),
          const Divider(color: Colors.grey, endIndent: 30, indent: 30),
          _clientInfo(),
          _buttonAccept(context)
        ],
      ),
    );
  }

  Widget _clientInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(
        children: [
          _imageClient(),
          const SizedBox(width: 15),
          Text(
            '${con.order.client?.name ?? ''} ${con.order.client?.lastname ?? ''}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            maxLines: 1,
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.grey[200]
            ),
            child: IconButton(
              onPressed: () => con.callNumber(),
              icon: const Icon(Icons.phone, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _imageClient() {
    return SizedBox(
      height: 50,
      width: 50,
      // padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: con.order.client!.image != null
              ? NetworkImage(con.order.client!.image!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder:  const AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _listTileAddress(String title, String subtitle, IconData iconData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
        trailing: Icon(iconData, color: Colors.white,),
      ),
    );
  }

  Widget _iconCenterMyLocation() {
    return GestureDetector(
      onTap: () => con.centerPosition(),
      child: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: const CircleBorder(),
          color: Colors.white,
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonAccept(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: ElevatedButton(
        onPressed: con.isClose == true ? () => con.updateToDelivered() : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          padding: const EdgeInsets.all(15)
        ),
        child: Text(
          'ENTREGAR PEDIDO',
          style: TextStyle(
            color: Colors.black
          ),
        ),

      ),
    );
  }


  Widget _googleMaps() {
    return GoogleMap(
      initialCameraPosition: con.initialPosition,
      mapType: MapType.normal,
      onMapCreated: con.onMapCreate,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: Set<Marker>.of(con.markers.values),
      polylines: con.polylines,
    );
  }
}
