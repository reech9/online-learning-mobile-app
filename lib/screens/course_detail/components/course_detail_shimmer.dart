import 'package:digi_school/widgets/make_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseDetailShimmer extends StatelessWidget {
  const CourseDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerContainer(),
          SizedBox(
            height: 20,
          ),
          shimmerContainer(height: 30),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              shimmerContainer(height: 30, round: 10, width: 50),
              SizedBox(
                width: 10,
              ),
              shimmerContainer(height: 30, round: 10, width: 50),
              SizedBox(
                width: 10,
              ),
              shimmerContainer(height: 30, round: 10, width: 50),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          shimmerContainer(height: 200),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
