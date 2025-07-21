import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/Rol.dart';
import 'package:udemy_flutter_delivery/src/pages/roles/roles_controller.dart';

class RolesPage extends StatelessWidget {

  RolesController con = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seleccionar el rol',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.12),
        child: ListView(
          children: con.user.roles != null ? con.user.roles!.map((Rol rol) {
            return _cardRol(rol);
          }).toList() : [],
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () => con.goToPageRol(rol),
      child: Column(
        children: [
          Container( // IMAGEN
            margin: EdgeInsets.only(bottom: 15, top: 15),
            height: 100,
            child: FadeInImage(
              image: NetworkImage(rol.image!),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          Text(
            rol.name ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}
