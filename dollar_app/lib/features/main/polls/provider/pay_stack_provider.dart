import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paystack_for_flutter/paystack_for_flutter.dart';

class PayStackProvider extends AsyncNotifier<Map<String, dynamic>> {
  static Future<void> initilaizePayStake(context) async {
    log('loading');
    PaystackFlutter().pay(
      reference: 'ten_d-c7ca04e6-7d09-4515-942d-ce7f91221f59',
      context: context,
      secretKey:
          'sk_test_01b796804dd3122ca53f5836c9453dcff7cfc583', // Your Paystack secret key gotten from your Paystack dashboard.
      amount:
          200, // The amount to be charged in the smallest currency unit. If amount is 600, multiply by 100(600*100)
      email: 'tee@yopmail.com', // The customer's email address.
      callbackUrl:
          'https://callback.com', // The URL to which Paystack will redirect the user after the transaction.
      showProgressBar:
          true, // If true, it shows progress bar to inform user an action is in progress when getting checkout link from Paystack.
      paymentOptions: [
        PaymentOption.card,
        PaymentOption.bankTransfer,
        PaymentOption.mobileMoney
      ],
      currency: Currency.NGN,
      onSuccess: (paystackCallback) {
        log('Transaction Successful::::${paystackCallback.reference}');
      }, // A callback function to be called when the payment is successful.
      onCancelled: (paystackCallback) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Transaction Failed/Not successful::::${paystackCallback.reference}'),
          backgroundColor: Colors.red,
        ));
      }, // A callback function to be called when the payment is canceled.
    );
    log('finish loading');
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    return {};
  }
}
