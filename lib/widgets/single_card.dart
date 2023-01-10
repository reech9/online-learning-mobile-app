import 'package:digi_school/api/api.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../constants/fonts.dart';

class SingleCard extends StatelessWidget {
  SingleCard(
      {Key? key,
      this.title = "",
      this.image = "",
      // this.user = "",
      this.ratings = 0,
      this.price = 0,
      this.discount = 0,
      required this.ontap})
      : super(key: key);
  String title;
  String image;
  // String user;
  num ratings;
  num price;
  num discount;
  Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 230,
        decoration: BoxDecoration(
            color: Colors.transparent,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.2),
            //     spreadRadius: 0,
            //     blurRadius: 4,
            //     offset: const Offset(2, 2), // changes position of shadow
            //   ),
            // ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 170,
              child: image == null
                  ? Image.asset(
                      "assets/images/landing/images-1.jpg",
                      fit: BoxFit.cover,
                    )
                  : CacheImageUtil(
                      image: image.replaceAll("\\", '/'),
                      default_image: "assets/images/landing/images-1.jpg",
                      height: 170,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
            Container(
              color: Colors.transparent,
              // color: kWhite,
              //           decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [Colors.black26, kPrimaryColor ])),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: p2,
                      color: kWhite,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // Text(
                  //   user + "\n",
                  //   maxLines: 2,
                  //   style: TextStyle(
                  //       fontSize: p2,
                  //       fontWeight: FontWeight.w500,
                  //       color: gray_800),
                  // ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "NRP ${discount > 0 ? (price - discount).toString() : price.toString()}",
                        style: TextStyle(
                          fontSize: p1,
                          color: kWhite,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      if (discount > 0)
                        Text(
                          price.toString(),
                          style: TextStyle(
                              fontSize: p2,
                              color: kWhite,
                              decoration: TextDecoration.lineThrough),
                        )
                    ],
                  ),
                  Row(
                    children: [
                      SmoothStarRating(
                        allowHalfRating: true,
                        rating: ratings.toDouble(),
                        isReadOnly: true,
                        size: 20,
                        starCount: 5,
                        color: Colors.orangeAccent,
                        borderColor: Colors.orangeAccent,
                        spacing: 0.0,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ratings.toString(),
                        style: TextStyle(
                          color: kWhite,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
