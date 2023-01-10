//
//
// import 'package:digi_school/configs/environment.config.dart';
// import 'package:esewa_pnp/esewa.dart';
// import 'package:esewa_pnp/esewa_pnp.dart';
// import 'package:flutter/cupertino.dart';
//
// void pay(BuildContext context){
//   ESewaConfiguration _configuration = ESewaConfiguration(
//     // clientID: dotenv.env["ENV"].toString() != "production"
//     //     ? dotenv.env["DEV_ESEWA_CLIEND_ID"].toString()
//     //     : dotenv.env["LIVE_ESEWA_CLIEND_ID"].toString(),
//     // secretKey: dotenv.env["ENV"].toString() != "production"
//     //     ? dotenv.env["DEV_ESEWA_SECRET_KEY"].toString()
//     //     : dotenv.env["LIVE_ESEWA_SECRET_KEY"].toString(),
//     // environment: dotenv.env["ENV"].toString() != "production"
//     //     ? ESewaConfiguration.ENVIRONMENT_TEST
//     //     : ESewaConfiguration.ENVIRONMENT_LIVE,
//     clientID: EnvironmentConfig.eSewaClientId,
//     secretKey:EnvironmentConfig.eSewaSecretKey,
//     environment: EnvironmentConfig.environment=="production" ?  ESewaConfiguration.ENVIRONMENT_LIVE  :ESewaConfiguration.ENVIRONMENT_TEST ,
//   );
//
//   ESewaPnp _esewaPnp = ESewaPnp(configuration: _configuration);
//   ESewaPayment _payment = ESewaPayment(
//     amount: 1000,
//     productName: "Test",
//     productID: "123",
//     callBackURL: "https://google.com",
//   );
//
//   try {
//     _esewaPnp.initPayment(payment: _payment).then((value) {
//       List<Map<String, String>> paymentRequest = [
//         {"oid": value.productId.toString()},
//         {"amt": value.totalAmount.toString()},
//         {"refId": value.referenceId.toString()},
//       ];
//
//       print("Success");
//       Navigator.of(context, rootNavigator: true).pop(context);
//     }).onError((error, stackTrace) {
//      print("Error");
//       Navigator.of(context).pop(context);
//     });
//     // Handle success
//   } catch (e) {
//     print("Error");
//     Navigator.of(context).pop(context);
//     // Handle error
//   }
//
//
// }