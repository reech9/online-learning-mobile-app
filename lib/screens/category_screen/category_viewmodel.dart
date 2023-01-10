import 'package:flutter/material.dart';

class CategoryViewModel with ChangeNotifier{

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