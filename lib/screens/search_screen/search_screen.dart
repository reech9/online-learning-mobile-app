import 'dart:async';

import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/course_detail/course_detail.dart';
import 'package:digi_school/screens/my_learning_screen/components/my_learning_shimmer.dart';
import 'package:digi_school/screens/search_screen/components/top_categoeies.dart';
import 'package:digi_school/screens/search_screen/search_viewmodel.dart';
import 'package:digi_school/widgets/list_card_product.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/fonts.dart';
import 'components/top_serach.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
        create: (_) => SearchViewModel(), child: SearchScreenBody());
  }
}

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({Key? key}) : super(key: key);

  @override
  _SearchScreenBodyState createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  TextEditingController _controller = TextEditingController();
  bool isGrid = true;
  bool showHistory = true;
  Timer? _debounce;

  ScrollController? _scrollController;
  String tmpSearch = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, data, child) {
      return Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kPrimaryColor, Colors.black])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: CustomScrollView(slivers: <Widget>[
                      SliverAppBar(
                        toolbarHeight: 50,
                        backgroundColor: Colors.white,
                        pinned: false,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        title: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              // color: Colors.red
                              ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
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
                                  data.setSearch(value.toString());
                                  data.fetchsearchresult();
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
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search,
                                  color: gray_600,
                                ),
                              ),
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
                      _controller.text.length > 1
                          ? SliverToBoxAdapter(
                              child: isLoading(data.searchApiResponse)
                                  ? MyLearningShimmer()
                                  : data.courses.length == 0
                                      ? ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Container(
                                                child: Image.asset(
                                                    "assets/images/no-data.png")),
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemCount: data.courses.length,
                                          itemBuilder: (context, index) {
                                            return ListCardProduct(
                                              title: data
                                                  .courses[index].courseTitle
                                                  .toString(),
                                              user: "",
                                              image: data.courses[index].image
                                                  .toString(),
                                              discount: data.courses[index]
                                                          .discount ==
                                                      null
                                                  ? 0
                                                  : data.courses[index].discount!,
                                              price: data.courses[index].price ==
                                                      null
                                                  ? 0
                                                  : data.courses[index].price!,
                                              rating: data.courses[index]
                                                          .rating ==
                                                      null
                                                  ? 0
                                                  : data.courses[index].rating!,
                                              onPress: () {
                                                Navigator.pushNamed(context,
                                                    CourseDetail.routeName,
                                                    arguments: data
                                                        .courses[index].courseSlug
                                                        .toString());
                                              },
                                            );
                                          },
                                        ),
                            )
                          : SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(
                                  //       horizontal: 0, vertical: 10),
                                  //   child: Column(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Container(
                                  //         margin: EdgeInsets.symmetric(
                                  //             horizontal: 10),
                                  //         child: scafoldHeader("Top Search"),
                                  //       ),
                                  //       const SizedBox(
                                  //         height: 10,
                                  //       ),
                                  //       const TopSearchWidget(),
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: scafoldHeader("Browse All"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const TopCategoriesWidget(
                                            screen: "search"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ]))),
          ));
    });
  }
}
