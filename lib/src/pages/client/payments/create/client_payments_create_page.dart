import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import '../../../utils/my_colors.dart';

class ClientPaymentsCreatePage extends StatefulWidget {
  @override
  _ClientPaymentsCreatePageState createState() =>
      _ClientPaymentsCreatePageState();
}

class _ClientPaymentsCreatePageState extends State<ClientPaymentsCreatePage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: Text('Pago con tarjeta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
            ),
            CreditCardForm(
              onCreditCardModelChange: (CreditCardModel model) {
                setState(() {
                  cardNumber = model.cardNumber;
                  expiryDate = model.expiryDate;
                  cardHolderName = model.cardHolderName;
                  cvvCode = model.cvvCode;
                  isCvvFocused = model.isCvvFocused;
                });
              },
              themeColor: Colors.blue,
              formKey: GlobalKey<FormState>(),
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              obscureCvv: true,
              obscureNumber: true,
              cardHolderNameDecoration: InputDecoration(
                labelText: 'Nombre del titular',
                hintText: 'Tu nombre',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                print('Confirmar pago');
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
