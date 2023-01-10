import 'dart:async';

import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/landing/models/slide.dart';
import 'package:digi_school/screens/landing/widgets/slide_item.dart';
import 'package:flutter/material.dart';

class WhyDigiSchoolBody extends StatefulWidget {
  const WhyDigiSchoolBody({Key? key}) : super(key: key);

  @override
  State<WhyDigiSchoolBody> createState() => _WhyDigiSchoolBodyState();
}

class _WhyDigiSchoolBodyState extends State<WhyDigiSchoolBody> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Why Digi School?',
            style: TextStyle(
                color: kWhite, fontWeight: FontWeight.bold, fontSize: h4),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.pink,
            height: 5,
            width: 150,
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,

                  itemCount: slideList.length,
                  itemBuilder: (ctx, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Container(
                        width: 100,

                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                        child: Column(

                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(slideList[i].imageUrl,height: 50,width: 200,),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    slideList[i].title,
                                    style: TextStyle(
                                        // fontStyle: FontStyle.italic,
                                        fontSize: h6,
                                        // fontWeight: FontWeight.w500,
                                        color: kBlack),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                slideList[i].description,
                                style: TextStyle(
                                    fontSize: p2,
                                    // fontStyle: FontStyle.italic,
                                    // fontWeight: FontWeight.w400,
                                    color: kBlack),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
