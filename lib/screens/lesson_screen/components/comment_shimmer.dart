import 'package:digi_school/widgets/make_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommentShimmer extends StatelessWidget {
  CommentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery. of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            shimmerContainer(height: 40, width: 200,),
            SizedBox(height: 20,),
            getComment(w),
            SizedBox(height: 20,),
            getComment(w),
          ],

        ),
      ),
    );
  }

  Widget getComment(double w){
    return Column(
      children: [
        Row(
          children: [
            shimmerContainer(height: 50, width: 50, round: 100),
            SizedBox(width: 10,),
            Column(
              children: [
                shimmerContainer(height: 20, width: 120,),
                SizedBox(height: 5,),
                shimmerContainer(height: 10, width: 120,),
              ],
            ),
          ],
        ),
        SizedBox(height: 10,),
        shimmerContainer(height: 20, width: w),
        SizedBox(height: 10,),
        shimmerContainer(height: 20, width: w),
      ],
    );
  }
}
