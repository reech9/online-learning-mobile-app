
import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class WishlistCard extends StatefulWidget {
  WishlistCard({Key? key, this.title="", this.image="", this.subTitle="", this.onClick, this.price=0, this.onRemove}) : super(key: key);
  VoidCallback? onClick = (){};
  VoidCallback? onRemove = (){};
  String title = "";
  String image = "";
  num price = 0;
  String subTitle = "";
  @override
  _WishlistCardState createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(

      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: InkWell(
          onTap: (){
            if(widget.onClick!=null) {
              widget.onClick!();
            }
          },
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(widget.image, height: 60, width: 60, fit: BoxFit.cover,)),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.title, maxLines: 2, style: TextStyle(fontSize: p1, fontWeight: FontWeight.w600),),
                          SizedBox(height: 5,),
                          Text(widget.subTitle +  "\n\n", maxLines: 3, style: TextStyle(fontSize: p2, fontWeight: FontWeight.w500),),


                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("NPR. ${widget.price.toString()}" , style: TextStyle(fontSize: p1, fontWeight: FontWeight.w700),),

                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          if(widget.onRemove!=null){
                                            widget.onRemove!();
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.red,
                                          ),
                                          child: Icon(Icons.delete_outline, color: kWhite,)),
                                      ),

                                    ],
                                  ),
                                  // ElevatedButton(
                                  //     style: ButtonStyle(
                                  //       backgroundColor: MaterialStateProperty.all<Color>(
                                  //           red_1
                                  //       ),
                                  //       padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 0, vertical: 5)),
                                  //     ),
                                  //     onPressed: () {
                                  //       if(widget.onRemove!=null){
                                  //         widget.onRemove!();
                                  //       }
                                  //     }, child: Icon(Icons.restore_from_trash_outlined))
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
