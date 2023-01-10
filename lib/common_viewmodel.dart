import 'dart:convert';

import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/repository/common_repository.dart';
import 'package:digi_school/api/repository/user_repository.dart';
import 'package:digi_school/api/request/notification_update_request.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/my_learning_response.dart';
import 'package:digi_school/api/response/wishlist_response.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'api/repository/achievement_repository.dart';
import 'api/response/achievement_response.dart';
import 'api/response/certificate_generate_response.dart';
import 'api/response/notification_response.dart';

class CommonViewModel with ChangeNotifier {
  // getTheme() => _themeData;
  //
  // setTheme(ThemeData themeData) async {
  //   _themeData = themeData;
  //   notifyListeners();
  // }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _navigationIndex = 0;
  int get navigationIndex => _navigationIndex;

  PageController _pageController = PageController();
  PageController get pageController => _pageController;
  setNavigationIndex(int index) {
    _navigationIndex = index;
    notifyListeners();
  }

  setLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  setInitial(int index) {
    _pageController = PageController(initialPage: index);
    setNavigationIndex(index);
    notifyListeners();
  }

  itemTapped(int index) {
    setNavigationIndex(index);
    _pageController.jumpToPage(index);
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get homeKey => _homeKey;

  ApiResponse _wishlistApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get wishlistApiResponse => _wishlistApiResponse;
  List<WishlistData> _wishlist = [];
  List<WishlistData> get wishlist => _wishlist;

  Future<void> getWishlist() async {
    _wishlistApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      WishlistResponse res = await CommonRepository().getWishlist();
      if (res.success == true) {
        _wishlist = res.data!;
      } else {
        _wishlistApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _wishlistApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  ApiResponse _wishlistUpdateApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get wishlistUpdateApiResponse => _wishlistUpdateApiResponse;

  Future<void> removeFromWishList(String id) async {
    _wishlistUpdateApiResponse = ApiResponse.loading("Loading");
    _isLoading = true;
    notifyListeners();
    try {
      CommonResponse res =
          await CommonRepository().removeFromWishlist(jsonEncode({
        "course": id,
      }));
      if (res.success == true) {
        getWishlist();
        _wishlistUpdateApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _wishlistUpdateApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _wishlistUpdateApiResponse = ApiResponse.error(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToWishList(String id) async {
    _wishlistUpdateApiResponse = ApiResponse.loading("Loading");
    _isLoading = true;
    notifyListeners();
    try {
      CommonResponse res = await CommonRepository().addToWishlist(jsonEncode({
        "course": id,
      }));
      if (res.success == true) {
        print("RAW DATA :: " + res.data.toString());
        getWishlist();
        _wishlistUpdateApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _wishlistUpdateApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _wishlistUpdateApiResponse = ApiResponse.error(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  ApiResponse _userDetailsApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get userDetailsApiResponse => _userDetailsApiResponse;
  dynamic _userDetail = [];
  dynamic get userDetail => _userDetail;

  Future<void> getMyDetails() async {
    _userDetailsApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommonResponse res = await UserRepository().userDetails();
      if (res.success == true) {
        _userDetail = res.data;
        _userDetailsApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _userDetailsApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _userDetailsApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  ApiResponse _myLearningsApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get myLearningsApiResponse => _myLearningsApiResponse;
  List<MyLearningData> _learningData = [];
  List<MyLearningData> get learningData => _learningData;

  Future<void> getMyLearnings() async {
    _myLearningsApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      MyLearningResponse res = await CommonRepository().getLearnings();
      if (res.success == true) {
        _learningData = res.data!;
        _myLearningsApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _myLearningsApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _myLearningsApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  ///////////////////////// My Achievement ////////////////////////////////

  ApiResponse _myAchievementsApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get myAchievementsApiResponse => _myAchievementsApiResponse;
  List<Datum> _achievementData = [];
  List<Datum> get achievementData => _achievementData;

  Future<void> getCertificate() async {
    _myAchievementsApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CertificateGenerate res = await AchievementRepository().getCertificate();
      if (res.success == true) {
        _achievementData = res.data!;
        _myAchievementsApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _myAchievementsApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _myAchievementsApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  //


  //

  signout() {
    _learningData = [];
    _wishlist = [];
    _notifications = [];
    _achievementData = [];
    notifyListeners();
  }

  signin() {
    getMyLearnings();
    getWishlist();
    getCertificate();
    getMyNotifications();
  }

  ApiResponse _notificationsApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get notificationsApiResponse => _notificationsApiResponse;
  List<NotificationData> _notifications = [];
  List<NotificationData> get notifications => _notifications;
  int _unReadNotifications = 0;
  int get unReadNotifications => _unReadNotifications;

  Future<void> getMyNotifications() async {
    _notificationsApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      NotificationResponse res = await CommonRepository().getNotifications();
      if (res.success == true) {
        _notifications = res.data!.notification!;
        _unReadNotifications = res.data!.unRead!;
        _notificationsApiResponse =
            ApiResponse.completed(res.success.toString());
      } else {
        _notificationsApiResponse = ApiResponse.error(res.success.toString());
      }
    } catch (e) {
      print("ERR:: " + e.toString());
      _notificationsApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  ApiResponse _notificationsUpdateApiResponse =
      ApiResponse.initial("Empty Data");
  ApiResponse get notificationsUpdateApiResponse =>
      _notificationsUpdateApiResponse;
  Future<void> markNotification(
    NotificationUpdateRequest data,
  ) async {
    _notificationsUpdateApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommonResponse res = await CommonRepository()
          .markAsRead(notificationUpdateRequestToJson(data));
      if (res.success == true) {
        try {
          _notifications[
                  _notifications.indexWhere((element) => element.id == data.id)]
              .is_read = 1;
        } catch (e) {}
        _unReadNotifications =
            _unReadNotifications > 0 ? _unReadNotifications - 1 : 0;
        _notificationsUpdateApiResponse =
            ApiResponse.completed(res.success.toString());
      } else {
        _notificationsUpdateApiResponse =
            ApiResponse.error(res.success.toString());
      }
    } catch (e) {
      print("VM ERR:: " + e.toString());
      _notificationsUpdateApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void addNotificationCount() {
    _unReadNotifications += 1;
    notifyListeners();
  }
}




class MyThemes {
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );
}
