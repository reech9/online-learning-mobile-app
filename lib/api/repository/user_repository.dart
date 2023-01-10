import 'package:digi_school/api/api.dart';
import 'package:digi_school/api/endpoints.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/forget_password_response.dart';
import 'package:digi_school/api/response/login_response.dart';
import 'package:digi_school/configs/preference.config.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  API api = API();

  Future<CommonResponse> signup(data) async {
    dynamic response = await api.postData(data, CustomerEndpoints.signup);
    CommonResponse res = CommonResponse.fromJson(response);
    return res;
  }

  Future<ForgetPasswordResponse> forgetPassword(data) async {
    dynamic response = await api.postData(data, CustomerEndpoints.forget_password);
    ForgetPasswordResponse res = ForgetPasswordResponse.fromJson(response);
    return res;
  }

  Future<bool> checkLogin() async {
    bool check = false;
    try {
      await api.refreshToken().then((value) {
        var _res = CommonResponse.fromJson(value);
        PreferenceUtils.instance.setString("TOKEN", _res.data["accessToken"]);
        PreferenceUtils.instance
            .setString("REFRESH_TOKEN", _res.data["refreshToken"]);
        check = true;
      });
    } catch (e) {
      print("ERR::" + e.toString());
    }
    return check;
  }

  Future<CommonResponse> passwordReset(data) async {
    dynamic response =
        await api.patchDataWithToken(data, CustomerEndpoints.passwordReset);
    print("RESPONSE :: " + response.toString());
    CommonResponse res = CommonResponse.fromJson(response);
    return res;
  }

  Future<LoginResponse> login(data) async {
    print("LOGIN REQUIRE :: "+data.toString());
    dynamic response = await api.postData(data, CustomerEndpoints.signin);
    LoginResponse res = LoginResponse.fromJson(response);
    return res;
  }

  Future<CommonResponse> updateProfile(data) async {
    dynamic response =
        await api.putDataWithToken(data, CustomerEndpoints.updateDetails);
    CommonResponse res = CommonResponse.fromJson(response);
    return res;
  }

  Future<CommonResponse> updatedisplaypicture(PickedFile? pickedFile) async {
    dynamic response = await api.putDataWithTokenAndpickedimage(
        CustomerEndpoints.changeDisplayPicture, pickedFile!);
    CommonResponse res = CommonResponse.fromJson(response);
    return res;
  }

  Future<CommonResponse> userDetails() async {
    dynamic response = await api.getWithToken(CustomerEndpoints.userDetails);
    CommonResponse res = CommonResponse.fromJson(response);
    return res;
  }
}
