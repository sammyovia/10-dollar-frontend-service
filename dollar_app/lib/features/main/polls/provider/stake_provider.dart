import 'dart:async';
import 'dart:developer';
import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/main/polls/provider/stake_videos_notifier.dart';
import 'package:dollar_app/features/main/profile/providers/get_profile_provider.dart';
import 'package:dollar_app/features/shared/widgets/toast.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paystack_for_flutter/paystack_for_flutter.dart';

import '../../profile/providers/ticket_provider.dart';

class StakeProvider extends AsyncNotifier<Map<String, dynamic>> {
  Future<void> getReference(context, {required String refernce}) async {
    try {
      state = const AsyncLoading();
      final res = await ref
          .read(networkProvider)
          .getRequest(path: '/payments/$refernce');
      state = AsyncData(res);
      Toast.showSuccessToast(context, "Payment Successful");
      ref.invalidate(getPollsProvider);
      ref.invalidate(stakeVideoNotifierProvider);
      ref.read(ticketProvider.notifier).getTickets();
      ref.invalidateSelf();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      log(e.toString());
    }
  }

  Future<void> initilaizePayStake(context,
      {required String reference, required String email}) async {
    PaystackFlutter().pay(
      reference: reference,
      context: context,
      secretKey:
          'sk_test_01b796804dd3122ca53f5836c9453dcff7cfc583', // Your Paystack secret key gotten from your Paystack dashboard.
      amount:
          20000, // The amount to be charged in the smallest currency unit. If amount is 600, multiply by 100(600*100)
      email: email, // The customer's email address.
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
        getReference(context, refernce: reference);
      }, // A callback function to be called when the payment is successful.
      onCancelled: (paystackCallback) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Transaction Failed/Not successful::::'),
          backgroundColor: Colors.red,
        ));
      }, // A callback function to be called when the payment is canceled.
    );
  }

  Future<void> sendStakeToServer(context) async {
    try {
      state = const AsyncLoading();
      final stakedVideosNotifier =
          ref.read(stakeVideoNotifierProvider.notifier);
      final stakedVideos = stakedVideosNotifier.getStakedVideos();
      final requestBody = {
        "amount": 200,
        "videos": stakedVideos,
      };
      final email =
          ref.read(getProfileProvider).value?.email ?? 'adminuser@app.com';
      final response = await ref
          .read(networkProvider)
          .postRequest(path: '/polls/stake', body: requestBody);
      if (response['status'] == true) {
        Navigator.pop(context);
        initilaizePayStake(
          context,
          reference: response['data']['transactionRef'],
          email: email,
        );
      }

      state = AsyncData(response);

      await future;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      Toast.showErrorToast(context, e.toString());
    }
  }

  @override
  FutureOr<Map<String, dynamic>> build() {
    state = const AsyncLoading();
    return {};
  }
}

final stakeProvider =
    AsyncNotifierProvider<StakeProvider, Map<String, dynamic>>(
        StakeProvider.new);
