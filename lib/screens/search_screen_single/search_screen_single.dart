import 'dart:async';

import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/demo.dart';
import 'package:digi_school/screens/search_screen/components/top_categoeies.dart';
import 'package:digi_school/screens/search_screen/search_viewmodel.dart';
import 'package:digi_school/widgets/list_card_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constants/fonts.dart';
import '../../widgets/utils.dart';
import 'components/top_serach.dart';

class SearchScreenSingle extends StatefulWidget {
  const SearchScreenSingle({Key? key}) : super(key: key);
  static const String routeName = "/search-single";

  @override
  _SearchScreenSingleState createState() => _SearchScreenSingleState();
}

class _SearchScreenSingleState extends State<SearchScreenSingle> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
        create: (_) => SearchViewModel(), child: SearchScreenSingleBody());
  }
}

class SearchScreenSingleBody extends StatefulWidget {
  const SearchScreenSingleBody({Key? key}) : super(key: key);

  @override
  _SearchScreenSingleBodyState createState() => _SearchScreenSingleBodyState();
}

class _SearchScreenSingleBodyState extends State<SearchScreenSingleBody> {
  TextEditingController _controller = TextEditingController();
  bool isGrid = true;
  bool showHistory = true;
  Timer? _debounce;

  ScrollController? _scrollController;
  String tmpSearch = "";

  List<Map<String, dynamic>> demo = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    demo = dummyProduct.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SearchViewModel>(builder: (context, data, child) {
        return Container(
            color: kWhite,
            child: SafeArea(
                child: ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                    child: CustomScrollView(slivers: <Widget>[
                      SliverAppBar(
                        toolbarHeight: 50,
                        backgroundColor: Colors.white,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        title: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              // color: Colors.red
                              ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: TextField(
                            onSubmitted: (value) {
                              if (value.length > 1)
                                data.setRecentString(value.toString());
                              // data.searchAll(value.toString());
                            },
                            textInputAction: TextInputAction.search,
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false)
                                _debounce?.cancel();
                              _debounce =
                                  Timer(const Duration(milliseconds: 500), () {
                                //  search here
                                if (value.length > 1 &&
                                    tmpSearch != value.toString()) {
                                  data.setRecentString(value.toString());
                                  // data.searchAll(
                                  //     value.toString());
                                  setState(() {
                                    tmpSearch = value.toString();
                                    showHistory = false;
                                  });
                                } else {
                                  setState(() {
                                    showHistory = true;
                                  });
                                }
                              });
                            },
                            controller: _controller,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              prefixIcon: backButton(context),
                              hintText: "Search",
                              hintStyle: TextStyle(color: gray_600),
                              suffixIcon: _controller.text.length > 1
                                  ? IconButton(
                                      onPressed: () {
                                        _controller.clear();
                                        setState(() {
                                          tmpSearch = "";
                                        });
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        color: gray_600,
                                      ))
                                  : Container(
                                      height: 0,
                                      width: 0,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...List.generate(
                                demo.length,
                                (index) => ListCardProduct(
                                      title: demo[index]["title"],
                                      user: demo[index]["user"],
                                      image: demo[index]["image"],
                                      discount: demo[index]["discount"],
                                      price: demo[index]["price"],
                                      rating: demo[index]["rating"],
                                    ))
                          ],
                        ),
                      )
                    ]))));
      }),
    );
  }
}
