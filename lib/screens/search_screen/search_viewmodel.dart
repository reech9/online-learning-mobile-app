import 'dart:convert';

import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/models/category.dart';
import 'package:digi_school/api/models/course.dart' hide Category;
import 'package:digi_school/api/repository/category_repository.dart';
import 'package:digi_school/api/repository/search_repository.dart';
import 'package:digi_school/api/response/category_response.dart';
import 'package:digi_school/api/response/course_response.dart';
import 'package:digi_school/api/response/search_response.dart';
import 'package:flutter/material.dart';

class SearchViewModel with ChangeNotifier {
  List<String> _recentSearch = [];
  List<String> get recentSearch => _recentSearch;

  List<String> _recommendation = <String>[];
  List<String> get recommendation => _recommendation;

  Future<void> setRecentString(String search) async {
    _recentSearch = [];
    notifyListeners();
    if (search.isNotEmpty) {
      try {
        // await
        await Future.delayed(const Duration(seconds: 2));
        _recentSearch = ["Search1", "Search2", "Search3"];
      } catch (e) {
        notifyListeners();
      }
      notifyListeners();
    }
  }

  ApiResponse _categoryApiResponse = ApiResponse.initial('Empty data');

  ApiResponse get categoryApiResponse => _categoryApiResponse;
  List<Category> _categories = <Category>[];
  List<Category> get categories => _categories;

  Future<void> fetchAllcatgory() async {
    _categoryApiResponse = ApiResponse.loading('Fetching device data');
    notifyListeners();
    try {
      CategoryResponse data = await CategoryRepository().getCategories();
      _categories = data.data!;

      _categoryApiResponse = ApiResponse.completed(data.msg);
      notifyListeners();
    } catch (e) {
      _categoryApiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  ApiResponse _searchApiResponse = ApiResponse.initial('Empty data');

  ApiResponse get searchApiResponse => _searchApiResponse;
  List<Course> _courses = <Course>[];
  List<Course> get courses => _courses;

  String _search = "";
  String get search => _search;

  setSearch(String params) {
    _search = params;
    notifyListeners();
  }

  Future<void> fetchsearchresult() async {
    _searchApiResponse = ApiResponse.loading('Fetching device data');
    _courses = [];
    notifyListeners();
    try {
      SearchResponse data = await SearchRepository().quicksearch(_search);
      _courses = data.data!;

      _searchApiResponse = ApiResponse.completed(data.msg);
      notifyListeners();
    } catch (e) {
      _searchApiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  int _page = 1;
  int _size = 6;
  int _totalData = 0;
  bool _hasMore = true;

  int get page => _page;
  int get size => _size;
  int get totalData => _totalData;
  bool get hasMore => _hasMore;

  @override
  void dispose() {
    _page = 1;
    _size = 10;
    _totalData = 0;
    _hasMore = true;
    super.dispose();
  }
}
