import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String? message;
  bool? success;

  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = "https://api.stripe.com/v1";

  static String paymentUrl = "${StripeService.apiBase}/payment_intents";

  static String publishableKey =
      "pk_test_51JLvWbSE2NjvkvdFAlF97IZVywXKSL4DfwBKbiMH3JPuoCUlmzCutxJ6i0FOsus1iTQyOIvmbPpjh1g0TSe3jxNG00fu8LlI5X";

  static String secretKey =
      "sk_test_51JLvWbSE2NjvkvdF5ilAu353BddyRpQKgcksBnupbc3poiO1Zs5rcgFfQO85wGz0c6VwP9nliWpJv8GPw63EucsA00mpBVb8xy";

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secretKey}',
    'Content-type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: publishableKey,
        merchantId: 'test',
        androidPayMode: 'test'));
  }

  static Future<Map<String, dynamic>?> createPaymentIntents(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };
      var response =
          await http.post(Uri.parse(paymentUrl), headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (e) {
      print("erros ouccured in the payment intent $e");
    }
    return null;
  }

  static Future<StripeTransactionResponse> payWithCard(
      {required String amount, required String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntents(amount, currency);

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: paymentIntent!['client_secret'],
        paymentMethodId: paymentMethod.id,
      ));

      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: "Transaction Succesfull", success: true);
      } else {
        return StripeTransactionResponse(
            message: "Transaction Failed", success: false);
      }
    } on PlatformException catch (e) {
      return StripeService.getPlatformExceptionError(e);
    } catch (e) {
      return StripeTransactionResponse(
          message: "Transaction Failed : $e", success: false);
    }
  }

  static getPlatformExceptionError(err) {
    String message = "Something went wrong";
    if (err.code == 'cancelled') {
      message = "Transaction Cancelled";
    }
    return new StripeTransactionResponse(message: message, success: false);
  }
}
