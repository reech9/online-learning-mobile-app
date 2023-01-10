import 'package:digi_school/api/response/login_response.dart';
import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_viewmodel.dart';
import '../../../configs/api_response.config.dart';

class AboutYou extends StatefulWidget {
  dynamic user;
  AboutYou({Key? key, this.user}) : super(key: key);

  @override
  _AboutYouState createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CommonViewModel>(builder: (context, common, child) {
      return isLoading(common.userDetailsApiResponse)
          ? CircularProgressIndicator(
              color: kPrimaryColor,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CacheImageUtil(
                              width: 80,
                              height: 80,
                              image: common.userDetail['userImage'].toString(),
                              default_image: "assets/images/default_user.png",
                              fit: BoxFit.cover,
                            )
                            // Image.asset("assets/images/default_user.png", height: 150, width: 150, fit: BoxFit.cover,),
                            ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                widget.user['firstname'].toString().toUpperCase() +
                                    " " +
                                    widget.user['lastname'].toString().toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kWhite,
                                  fontSize: h4,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.user['email'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kWhite,
                                  fontSize: p1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
    });
  }
}
