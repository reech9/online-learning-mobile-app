import 'package:digi_school/widgets/make_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyLearningShimmer extends StatelessWidget {
  const MyLearningShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child:
        Column(
          children: [
            ...List.generate(3, (index) =>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerContainer(height: 50, width: 50),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            children: [
                              shimmerContainer(height: 20, width: double.infinity),
                              SizedBox(height: 5,),
                              shimmerContainer(height: 20, width: double.infinity),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    shimmerContainer(height: 20, width: double.infinity),

                    SizedBox(height: 20,),
                  ],

                ),),
          ],
        ),
      ),
    );
  }
}
