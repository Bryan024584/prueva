import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/mercado_pago_installment.dart';
import 'package:udemy_flutter_delivery/src/pages/client/payments/installments/client_payments_installments_controller.dart';

class ClientPaymentsInstallmentsPage extends StatelessWidget {

  ClientPaymentsInstallmentsController con = Get.put(ClientPaymentsInstallmentsController());

  ClientPaymentsInstallmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
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
          'Coutas',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textDescription(),
          _dropDownWidget(con.installmentsList)
        ],
      ),
    ));
  }

  Widget _textDescription() {
    return Container(
      margin: const EdgeInsets.all(30),
      child: const Text(
        'En cuantas coutas?',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _dropDownWidget(List<MercadoPagoInstallment> installments) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),

      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: const Text(
          'Seleccionar numero de coutas',
          style: TextStyle(
              fontSize: 15
          ),
        ),
        items: _dropDownItems(installments),
        value: con.installments.value == '' ? null : con.installments.value,
        onChanged: (option) {
          print('Opcion seleccionada $option');
          con.installments.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<MercadoPagoInstallment> installments) {
    List<DropdownMenuItem<String>> list = [];
    for (var installment in installments) {
      list.add(DropdownMenuItem(
        value: '${installment.installments}',
        child: Text('${installment.installments}'),
      ));
    }

    return list;
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
                    onPressed: () => con.createPayment(),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)
                    ),
                    child: const Text(
                      'CONFIRMAR PAGO',
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

}
