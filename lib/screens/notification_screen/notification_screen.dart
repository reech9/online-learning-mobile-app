import 'package:digi_school/api/request/notification_update_request.dart';
import 'package:digi_school/api/response/notification_response.dart';
import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/demo.dart';
import 'package:digi_school/notifications/notification_click_handler.dart';
import 'package:digi_school/screens/notification_screen/components/notification_card.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common_viewmodel.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);
  static const String routeName = "/notifications";
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late CommonViewModel _common;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _common = Provider.of<CommonViewModel>(context, listen: false);
      getAll(_common);
    });
  }
  List<Map<String, dynamic>> demoNotification =  dummyNotification;

  getAll(CommonViewModel common){
    common.getMyNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<CommonViewModel, AuthViewModel>(builder: (context, common, auth,child) {
        return Scaffold(
            body: Container(
                color: kWhite,
                child: SafeArea(
                    child: ScrollConfiguration(
                        behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                        child: RefreshIndicator(
                          edgeOffset: 50,
                          onRefresh: ()=>common.getMyNotifications(),
                          child: CustomScrollView(slivers: <Widget>[
                            SliverAppBar(
                              toolbarHeight: 50,
                              backgroundColor: kWhite,
                              pinned: true,
                              automaticallyImplyLeading: true,
                              leading: backButton(context),
                              titleSpacing: 0,
                              title: Container(
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                height: 50,
                                decoration: BoxDecoration(
                                  // color: Colors.red
                                ),
                                padding:
                                 EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    scafoldHeader("Notifications")
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  if(common.notifications.isEmpty)
                                    Column(
                                      children: [
                                        Image.asset("assets/images/no-data.png")
                                      ],
                                    ),
                                  if(common.notifications.isNotEmpty)
                                  ...List.generate(common.notifications.length, (index) =>
                                    Builder(
                                      builder: (context) {
                                        var data = DateFormat('MMM dd, yyyy');
                                        bool seen = false;
                                        try{
                                          seen = common.notifications[index].is_read! == 1;
                                        }catch(e){}
                                        return NotificationCard(
                                          title: common.notifications[index].notificationContent.toString(),
                                          date: data.format(common.notifications[index].createdAt! ),
                                          image: common.notifications[index].id.toString(),
                                          seen:  seen,
                                          onNoticitaionClick: (){
                                            common.markNotification(NotificationUpdateRequest(
                                                id: common.notifications[index].id!
                                            ));
                                            notificationClickHandler(context, common.notifications[index], common: common);
                                          },
                                          onTap: (){
                                            common.setLoading(true);
                                            try{
                                              common.markNotification(NotificationUpdateRequest(
                                                  id: common.notifications[index].id!
                                              )).then((value) {
                                                common.setLoading(false);
                                              });
                                            }catch(e){
                                              common.setLoading(false);
                                            }

                                          },
                                        );
                                      }
                                    )
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                            )
                          ]),
                        )))));
      }
    );
  }
}
