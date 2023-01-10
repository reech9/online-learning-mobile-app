import 'dart:convert';

import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/repository/achievement_repository.dart';
import 'package:digi_school/api/response/achievement_response.dart';
import 'package:flutter/material.dart';

import '../../api/response/certificate_generate_response.dart';

class AchievementCheckViewModel extends ChangeNotifier {
  ApiResponse _achievementCertificateApiResponse =
      ApiResponse.initial("Empty Data");
  ApiResponse get achievementCertificateApiResponse =>
      _achievementCertificateApiResponse;
  dynamic _achievementCertificateData;
  dynamic get achievementCertificateData => _achievementCertificateData;

  Future<void> fetchcheckCertificate(String value) async {
    _achievementCertificateApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      AchievementCourseResponse res =
          await AchievementRepository().checkCertificate(value);
      if (res.success == true) {
        print("CHECK" + jsonEncode(res.data!));
        _achievementCertificateData = res.data!;
        _achievementCertificateApiResponse =
            ApiResponse.completed(res.msg.toString());
      } else {
        _achievementCertificateApiResponse =
            ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR hhhhhhh:: " + e.toString());
      _achievementCertificateApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  // Future<void> postCertificate(String id) async  {
  //
  // }

  // Future<void> addToWishList(String id) async {
  //   _wishlistUpdateApiResponse = ApiResponse.loading("Loading");
  //   _isLoading = true;
  //   notifyListeners();
  //   try
  //     CommonResponse res = await CommonRepository().addToWishlist(jsonEncode({
  //       "course": id,
  //     }));
  //     if (res.success == true) {
  //       print("RAW DATA :: " + res.data.toString());
  //       getWishlist();
  //       _wishlistUpdateApiResponse = ApiResponse.completed(res.msg.toString());
  //     } else {
  //       _wishlistUpdateApiResponse = ApiResponse.error(res.msg.toString());
  //     }
  //   } catch (e) {
  //     print("VM CATCH ERR :: " + e.toString());
  //     _wishlistUpdateApiResponse = ApiResponse.error(e.toString());
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }

}
