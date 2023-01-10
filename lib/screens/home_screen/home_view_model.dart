import 'dart:convert';

import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/models/category.dart';
import 'package:digi_school/api/models/course.dart';
import 'package:digi_school/api/repository/category_repository.dart';
import 'package:digi_school/api/repository/course_repository.dart';
import 'package:digi_school/api/response/category_response.dart';
import 'package:digi_school/api/response/course_response.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  int _page = 1;
  int _size = 10;
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

  ApiResponse _courseApiResponse = ApiResponse.initial('Empty data');
  ApiResponse _loadmorecourseApiResponse = ApiResponse.initial('Empty data');

  ApiResponse get loadmorecourseApiResponse => _loadmorecourseApiResponse;
  ApiResponse get courseApiResponse => _courseApiResponse;
  List<Course> _courses = <Course>[];
  List<Course> get courses => _courses;

  Future<void> fetchCourses(String? category) async {
    _courseApiResponse = ApiResponse.loading('Fetching device data');
    _courses = [];
    notifyListeners();

    try {
      CourseResponse data = await CourseRepository().courselist([
        {"category": category.toString(), "page": "1"},
      ]);

      _courses = data.data!;
      _totalData = data.totalData!;
      _hasMore = _totalData > _page * _size;
      _courseApiResponse = ApiResponse.completed(data.msg);
      // _loadMoreApiResponse = ApiResponse.completed(data);
      notifyListeners();
    } catch (e) {
      _courseApiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> loadMore() async {
    _page = _page + 1;
    _loadmorecourseApiResponse = ApiResponse.loading('Fetching device data');
    notifyListeners();
    try {
      CourseResponse data = await CourseRepository().courselist([
        {"page": _page.toString()},
      ]);
      _courses.addAll(data.data!);
      _hasMore = _totalData > _page * _size;
      _loadmorecourseApiResponse = ApiResponse.completed(data.msg);
      notifyListeners();
    } catch (e) {
      _loadmorecourseApiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
    notifyListeners();
  }
  // Future<void> fetchCourses() async {
  //   _courseApiResponse = ApiResponse.loading('Fetching device data');
  //   notifyListeners();
  //   try {
  //     CourseResponse data = await CourseRepository().getCourse();
  //     _courses = data.data!;
  //     // print('checkpoint courses::' + jsonEncode(_courses));
  //
  //     _courseApiResponse = ApiResponse.completed(data);
  //     notifyListeners();
  //   } catch (e) {
  //     _courseApiResponse = ApiResponse.error(e.toString());
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

}
