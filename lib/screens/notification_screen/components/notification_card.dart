import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  NotificationCard({Key? key, this.title="", this.date = "" , this.image = "", this.seen=false, required this.onTap, required this.onNoticitaionClick}) : super(key: key);
  String title = "";
  String date = "";
  String image = "";
  bool seen = false;
  VoidCallback onTap = (){};
  VoidCallback onNoticitaionClick = (){};

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: gray_500,
                  width: 1
              )
          )
      ),
      child: InkWell(
        onTap: (){
          widget.onNoticitaionClick();
        },
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            // color: Colors.red
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 6,
                      child: Text(widget.title, style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: p2
                      ),)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.date, style: TextStyle(
                      color: gray_600,
                      fontWeight: FontWeight.w500,
                      fontSize: p2
                  ), textAlign: TextAlign.end,),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: widget.seen ?
                    Container()
                    // ElevatedButton(
                    //     style: ButtonStyle(
                    //         padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                    //
                    //         backgroundColor: MaterialStateProperty.all<Color>(
                    //             kPrimaryColor),
                    //         elevation: MaterialStateProperty.all(0)
                    //     ),
                    //     onPressed: () {
                    //
                    //     }, child: Text("Read", style: TextStyle(
                    //     color: kWhite
                    // ),))
                          : ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: kPrimaryColor, width: 1),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            elevation: MaterialStateProperty.all(0)
                        ),
                        onPressed: () {
                          widget.onTap();
                        }, child: Text("Mark as read", style: TextStyle(
                        color: kBlack
                    ),)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
