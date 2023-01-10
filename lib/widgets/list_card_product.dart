import 'package:digi_school/api/api.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../constants/fonts.dart';

class ListCardProduct extends StatelessWidget {
  ListCardProduct(
      {Key? key,
      this.image = "",
      this.title = "",
      this.user = "",
      this.border = true,
      this.price = 0,
      this.discount = 0,
      this.onPress,
      this.rating = 0})
      : super(key: key);
  String image = "";
  String title = "";
  String user = "";
  bool border = true;
  num price = 0;
  num discount = 0;
  num rating = 0;
  VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(onPress!=null){
          onPress!();
        }
      },
      child: Container(
          decoration: BoxDecoration(
            border: border
                ? Border(bottom: BorderSide(width: 1, color: gray_600))
                : Border(),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(0),child:
              CacheImageUtil(image: image.replaceAll("\\", "/"), height: 80, width: 80, fit: BoxFit.cover,)),
              SizedBox(width: 10,),

              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(title,
                        style:
                            TextStyle(fontSize: p1,color: kWhite, )),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      user,
                      style: TextStyle(
                          fontSize: p2,
                          // fontWeight: FontWeight.w500,
                          color: kWhite),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "NRP ${discount > 0 ? (price - discount).toString() : price.toString()}",
                          style: TextStyle(
                              fontSize: p1,
                              // fontWeight: FontWeight.w500,
                              color: kWhite),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        if (discount > 0)
                          Text(
                            price.toStringAsFixed(2),
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
                          allowHalfRating: false,
                          rating: rating.toDouble(),
                          isReadOnly: true,
                          size: 20,
                          starCount: 5,
                          color: Colors.yellow.shade700,
                          borderColor: Colors.yellow.shade700,
                          spacing: 0.0,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(rating.toStringAsFixed(2),style: TextStyle(color: kWhite),)
                      ],
                    ),
                  ],
                ),
              ),

            ],
          )),
    );
  }
}
