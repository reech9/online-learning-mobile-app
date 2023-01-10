import 'package:digi_school/api/api.dart';
import 'package:digi_school/api/endpoints.dart';
import 'package:digi_school/api/response/category_response.dart';

class CategoryRepository {
  API api = API();

  Future<CategoryResponse> getCategories() async {
    dynamic response;
    CategoryResponse res;
    try {
      response = await api.getData(CustomerEndpoints.categories);
      res = CategoryResponse.fromJson(response);
    } catch (e) {
      res = CategoryResponse.fromJson(response);
    }
    return res;
  }
}
