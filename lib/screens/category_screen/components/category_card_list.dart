
import 'package:digi_school/api/models/course.dart';
import 'package:digi_school/widgets/single_card.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';

class CategoryCardList extends StatefulWidget {
  CategoryCardList({Key? key, this.title = "", this.data}) : super(key: key);
  String title = "";
  List<Course>? data = [];
  @override
  _CategoryCardListState createState() => _CategoryCardListState();
}

class _CategoryCardListState extends State<CategoryCardList> {
  int size = 0;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      size = widget.data == null ? 0 : widget.data!.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data==null || widget.data!.isEmpty ? Container() : Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.title,
                style: TextStyle(fontSize: h3, fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 5,),
          Container(
            height: 260,
            child: ListView(
              shrinkWrap: true,
              cacheExtent: 10,
              scrollDirection: Axis.horizontal,
              children: [
                if (widget.data != null)
                  ...List.generate(
                      widget.data!.length,
                          (index) => Container(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 10 : 0,
                            right: index == size ? 0 : 10),
                        child: SingleCard(
                          ontap: (){},
                          title: widget.data![index].courseTitle.toString(),
                          // image: widget.data![index]["image"],
                          // ratings: widget.data![index]["rating"],
                          // price: widget.data![index]["price"],
                          // user: widget.data![index]["user"],
                          // discount: widget.data![index]["discount"],
                        ),
                      )),
                // ...List.generate(size, (index) => Container(
                //   padding: EdgeInsets.only(left: index==0 ? 10 : 0, right: index==size ? 0: 10),
                //   child: SingleCard(
                //       title: "Test",
                //   ),
                // )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "See all",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: h4,
                          color: kPrimaryColor),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
