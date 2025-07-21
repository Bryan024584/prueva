import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/client/payments/status/client_payments_status_controller.dart';

class ClientPaymentsStatusPage extends StatelessWidget {

  ClientPaymentsStatusController con = Get.put(ClientPaymentsStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // POSICIONAR ELEMENTOS UNO ENCIMA DEL OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textFinishTransaction(context),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: Column(
        children: [
          _textTransactionDetail(),
          _textTransactionStatus(),
          Spacer(),
          _buttonCreate(context)
        ],
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
          onPressed: () {
            con.finishShopping();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'FINALIZAR COMPRA',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _textFinishTransaction(BuildContext context) {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            con.mercadoPagoPayment.status == 'approved'
            ? Icon(Icons.check_circle, size: 100, color: Colors.white)
            : Icon(Icons.cancel, size: 100, color: Colors.red),
            Text(
              'TRANSACCION TERMINADA',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textTransactionDetail() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30, left: 25, right: 25),
      child: Text(
        con.mercadoPagoPayment.status == 'approved'
        ? 'Tu orden fue procesada exitosamente usando (${con.mercadoPagoPayment.paymentMethodId?.toUpperCase()} **** ${con.mercadoPagoPayment.card?.lastFourDigits})'
        : 'Tu pago fue rechazado',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textTransactionStatus() {
    return Container(
      margin: EdgeInsets.only(bottom: 30, left: 25, right: 25),
      child: Text(
        con.mercadoPagoPayment.status == 'approved'
        ? 'Mira el estado de tu compra en la seccion de mis pedidos'
        : con.errorMessage.value,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
