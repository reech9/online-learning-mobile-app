import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  CartCard({Key? key, required this.title, required this.subTitle, this.image, required this.price, required this.discount, this.onRemove, this.onSave}) : super(key: key);
  String title="";
  String? image="";
  String subTitle="";
  num price=0;
  num discount=0;
  VoidCallback? onRemove = (){};
  VoidCallback? onSave = (){};

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.red
          ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                widget.image!,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: TextStyle(
                color: kBlack,
                fontWeight: FontWeight.w500,
                fontSize: p1
              ),),
              Text(widget.subTitle, style: TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: p2
              ),),
              Text(widget.price.toString(), style: TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: p2
              ),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      // widget.onSave();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, ),
                      child: Text(
                        "Save for later",
                        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      widget.onRemove!();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        "Remove",
                        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                ],
              )
            ],
          ))
        ],
      ),
    );
  }

}
