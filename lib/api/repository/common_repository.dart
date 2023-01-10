
import 'package:digi_school/api/api.dart';
import 'package:digi_school/api/endpoints.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/my_learning_response.dart';
import 'package:digi_school/api/response/notification_response.dart';
import 'package:digi_school/api/response/wishlist_response.dart';

class CommonRepository {
  API api = API();

  Future<WishlistResponse> getWishlist() async {
    dynamic response;
    WishlistResponse res;
    try {
      response = await api.getWithToken(CustomerEndpoints.wishlist);
      print("RAW RESPONSE:: " + response.toString());
      res = WishlistResponse.fromJson(response);
    } catch (e) {
      print("REPO ERR :: "+ e.toString());
      res = WishlistResponse.fromJson(response);
    }
    return res;
  }

  Future<MyLearningResponse> getLearnings() async {
    dynamic response;
    MyLearningResponse res;
    try {
      response = await api.getWithToken(CustomerEndpoints.myLearnings);
      res = MyLearningResponse.fromJson(response);
    } catch (e) {
      res = MyLearningResponse.fromJson(response);
    }
    return res;
  }


  Future<NotificationResponse> getNotifications() async {
    dynamic response;
    NotificationResponse res;
    try {
      response = await api.getWithToken(CustomerEndpoints.notification);
      print("RAW :: "+ response.toString());
      res = NotificationResponse.fromJson(response);
    } catch (e) {
      print("REPO ERR :: "+ e.toString());
      res = NotificationResponse.fromJson(response);
    }
    return res;
  }


  Future<CommonResponse> markAsRead(dynamic data, {bool all= false}) async {
    dynamic response;
    CommonResponse res;
    try{
      response = await api.putDataWithToken(data, CustomerEndpoints.markRead);
      print("RESPONSE :: " + response.toString());
      res = CommonResponse.fromJson(response);
    } catch (e) {
      print("REPO ERR :: "+ e.toString());
      res = CommonResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> removeFromWishlist(dynamic data) async {
    dynamic response;
    CommonResponse res;
    try {
      response = await api.patchDataWithToken(data, CustomerEndpoints.wishlistRemove);
      print("RAW RESPONSE :: " + response.toString());
      res = CommonResponse.fromJson(response);
    } catch (e) {
      print("REPO ERR :: "+ e.toString());
      res = CommonResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> addToWishlist(dynamic data) async {
    dynamic response;
    CommonResponse res;
    try {
      response = await api.postDataWithToken(data, CustomerEndpoints.wishlist);
      print("RAW RESPONSE :: " + response.toString());
      res = CommonResponse.fromJson(response);
    } catch (e) {
      print("REPO ERR :: "+ e.toString());
      res = CommonResponse.fromJson(response);
    }
    return res;
  }

}