import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/material.dart';


import '../screens/search_screen/search_screen.dart';

class ExploreButton extends StatelessWidget {
  VoidCallback? onTap = () {};
  String title = "";
  IconData icon;
  ExploreButton({Key? key, this.onTap, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
      },
      child: Row(
        children: [
          Container(
              decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              height: 40,
              width: 135,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        title,
                        style: const TextStyle(color: kWhite, fontSize: h5),
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        height: 35,
                        width: 15,
                        child: Icon(icon),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
