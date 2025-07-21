import 'package:flutter_credit_card/flutter_credit_card.dart';

class ClientPaymentsCreateController {
  void onCreditCardModelChanged(CreditCardModel creditCardModel) {
    print('Número de tarjeta: ${creditCardModel.cardNumber}');
    print('Nombre del titular: ${creditCardModel.cardHolderName}');
    print('Fecha de expiración: ${creditCardModel.expiryDate}');
    print('Código CVV: ${creditCardModel.cvvCode}');
  }
}
