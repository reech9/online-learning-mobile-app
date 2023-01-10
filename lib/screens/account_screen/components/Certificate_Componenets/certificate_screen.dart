import 'package:digi_school/common_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../api/response/certificate_generate_response.dart';
import '../../../../auth_viewmodel.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/fonts.dart';

class GeneratedCertificate extends StatefulWidget {
  Course coursefinal;
  User userfinal;
  GeneratedCertificate(
      {Key? key, required this.coursefinal, required this.userfinal})
      : super(key: key);

  static const String routeName = "/GeneratedCertificate";

  @override
  State<GeneratedCertificate> createState() => _GeneratedCertificateState();
}

class _GeneratedCertificateState extends State<GeneratedCertificate> {
  late CommonViewModel common;
  late AuthViewModel auth;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      auth = Provider.of<AuthViewModel>(context, listen: false);
      common = Provider.of<CommonViewModel>(context, listen: false);
      getAll(common, auth);
    });

    super.initState();
  }

  Future<void> getAll(CommonViewModel common, AuthViewModel auth) async {
    if (auth.loggedIn) {
      common.getCertificate();
    }
  }

  Widget build(BuildContext context) {
    return Consumer<CommonViewModel>(builder: (context, common, child) {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kPrimaryColor, Colors.black])),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Container(
                  child: Card(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/Sideline.png",
                                height: 250)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 80),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints:
                                    BoxConstraints(maxHeight: double.infinity),
                                child: Row(
                                  children: [
                                    Text(
                                      "Statement of Completion",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 200, maxHeight: double.infinity),
                                child: Text(
                                  "${widget.userfinal.firstname.toString() + " " + widget.userfinal.lastname.toString()}",
                                  maxLines: 4,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "In recognition\nfor a record of\noutstanding accomplishment",
                                    style: TextStyle(
                                        fontSize: p2,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  Builder(builder: (context) {
                                    return ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: 200,
                                          maxHeight: double.infinity),
                                      child: Text(
                                        widget.coursefinal.courseTitle
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: p0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  })
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text("Validated by:"),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/logo.png",
                                    height: 45,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ),
      );
    });
  }
}
