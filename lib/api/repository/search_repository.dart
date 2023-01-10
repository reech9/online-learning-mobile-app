import 'package:digi_school/api/api.dart';
import 'package:digi_school/api/endpoints.dart';
import 'package:digi_school/api/response/search_response.dart';
import 'package:flutter/services.dart';

class SearchRepository {
  API api = API();

  Future<SearchResponse> quicksearch(String params) async {
    dynamic response;
    SearchResponse res;
    try {
      response = await api.getData(CustomerEndpoints.quickSearch + params);
      print("RAW  RESPONSE " + response.toString());
      res = SearchResponse.fromJson(response);
      print("RESPONE " + res.toString());
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = SearchResponse.fromJson(response);
    }
    return res;
  }
}
