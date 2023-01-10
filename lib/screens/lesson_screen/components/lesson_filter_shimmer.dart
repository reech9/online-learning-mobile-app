
import 'package:digi_school/widgets/make_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LessonFilterShimmer extends StatelessWidget {
  LessonFilterShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery. of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerContainer(height: 50, width: w),
            SizedBox(height: 20,),
            shimmerContainer(height: 40, width: w),
            SizedBox(height: 10,),
            shimmerContainer(height: 40, width: w),
            SizedBox(height: 10,),
            shimmerContainer(height: 40, width: w),
            SizedBox(height: 10,),
            shimmerContainer(height: 40, width: w),
            SizedBox(height: 10,),
            shimmerContainer(height: 40, width: w),
            SizedBox(height: 10,),
          ],

        ),
      ),
    );
  }
}
