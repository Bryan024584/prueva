import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/mercado_pago_payment.dart';

class ClientPaymentsStatusController extends GetxController {

  MercadoPagoPayment mercadoPagoPayment = MercadoPagoPayment.fromJson(Get.arguments['mercado_pago_payment']);
  var errorMessage = ''.obs;


  ClientPaymentsStatusController() {
    if (mercadoPagoPayment.status == 'rejected') {
      createErrorMessage();
    }
  }

  void finishShopping() {
    Get.offNamedUntil('/client/home', (route) => false);
  }

  void  createErrorMessage() {
    if (mercadoPagoPayment.statusDetail == 'cc_rejected_bad_filled_card_number') {
      errorMessage.value = 'Revisa el número de tarjeta';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_bad_filled_date') {
      errorMessage.value = 'Revisa la fecha de vencimiento';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_bad_filled_other') {
      errorMessage.value = 'Revisa los datos de la tarjeta';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_bad_filled_security_code') {
      errorMessage.value = 'Revisa el código de seguridad de la tarjeta';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_blacklist') {
      errorMessage.value = 'No pudimos procesar tu pago';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_call_for_authorize') {
      errorMessage.value = 'Debes autorizar ante ${mercadoPagoPayment.paymentMethodId} el pago de este monto.';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_card_disabled') {
      errorMessage.value = 'Llama a ${mercadoPagoPayment.paymentMethodId} para activar tu tarjeta o usa otro medio de pago';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_card_error') {
      errorMessage.value = 'No pudimos procesar tu pago';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_card_error') {
      errorMessage.value = 'No pudimos procesar tu pago';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_duplicated_payment') {
      errorMessage.value = 'Ya hiciste un pago por ese valor';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_high_risk') {
      errorMessage.value = 'Elige otro de los medios de pago, te recomendamos con medios en efectivo';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_insufficient_amount') {
      errorMessage.value = 'Tu ${mercadoPagoPayment.paymentMethodId} no tiene fondos suficientes';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_invalid_installments') {
      errorMessage.value = '${mercadoPagoPayment.paymentMethodId} no procesa pagos en ${mercadoPagoPayment.installments} cuotas.';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_max_attempts') {
      errorMessage.value = 'Llegaste al límite de intentos permitidos';
    }
    else if (mercadoPagoPayment.statusDetail == 'cc_rejected_other_reason') {
      errorMessage.value = 'Elige otra tarjeta u otro medio de pago';
    }
  }

}