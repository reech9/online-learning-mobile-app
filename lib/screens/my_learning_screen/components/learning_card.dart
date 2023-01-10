import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:flutter/material.dart';

class LearningCard extends StatefulWidget {
  LearningCard({Key? key, this.title="", this.image="", this.subTitle="", this.progress=0, this.onClick}) : super(key: key);
  VoidCallback? onClick = (){};
  String title = "";
  String image = "";
  String subTitle = "";
  num progress = 0;
  @override
  _LearningCardState createState() => _LearningCardState();
}

class _LearningCardState extends State<LearningCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(
                  2, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        onTap: (){
          if(widget.onClick!=null) {
            widget.onClick!();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
                child:
                CacheImageUtil(width: 60, height: 60, fit: BoxFit.cover,image: widget.image,)),
                // Image.asset(widget.image, height: 60, width: 60, fit: BoxFit.cover,)),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: TextStyle(fontSize: p1, fontWeight: FontWeight.w600),),
                  SizedBox(height: 2,),
                  Text(widget.subTitle, style: TextStyle(fontSize: p2, fontWeight: FontWeight.w500),),
                  SizedBox(height: 2,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(color: gray_500, value: widget.progress/100,  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),)),
                  SizedBox(height: 5,),
                  widget.progress ==0 ? Container(
                    child: Text("Start Course", style: TextStyle(
                      color: kPrimaryColor, fontSize: p1, fontWeight: FontWeight.w600
                    ),),
                  ) :
                  Row(
                    children: [
                      Text(widget.progress.toInt().toString() + "%", style: TextStyle(
                        color: kBlack, fontWeight: FontWeight.w500, fontSize: p1
                      ),),
                      SizedBox(width: 5),
                      Text("complete", style: TextStyle(
                          color: kBlack, fontWeight: FontWeight.w500, fontSize: p2
                      ),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
