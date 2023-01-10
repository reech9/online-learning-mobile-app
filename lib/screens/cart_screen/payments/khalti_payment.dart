

import 'package:flutter/cupertino.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void pay(BuildContext context){
  final config = PaymentConfig(
    amount: 1000,
    productIdentity: "Test",
    productName: "Purchased from Gyapu",
    productUrl: "https://www.gyapu.com",
  );

  WidgetsBinding.instance.addPostFrameCallback((_) {
    KhaltiScope.of(context).pay(
      config: config,
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  });

}

void onSuccess(PaymentSuccessModel success) {
  print("SUCCESS ::" + success.toString());

}

void onFailure(PaymentFailureModel failure) {

}

void onCancel() {

}