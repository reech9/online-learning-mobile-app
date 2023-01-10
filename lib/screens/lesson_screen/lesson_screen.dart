import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/category_screen/components/category_filter.dart';
import 'package:digi_school/screens/course_detail/course_detail_viewmodel.dart';
import 'package:digi_school/screens/lesson_screen/components/assessment_modal.dart';
import 'package:digi_school/screens/lesson_screen/components/comment_modal.dart';
import 'package:digi_school/screens/lesson_screen/components/course_details.dart';
import 'package:digi_school/screens/lesson_screen/components/lesson_modal.dart';
import 'package:digi_school/screens/lesson_screen/components/lesson_shimmer.dart';
import 'package:digi_school/screens/lesson_screen/lesson_viewmodel.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../login/login_screen.dart';
import '../navigation/navigation_screen.dart';

class LessonScreen extends StatefulWidget {
  LessonScreen({Key? key, required this.slug}) : super(key: key);
  String slug = "";
  static const routeName = "/lesson-screen";

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return LessonBody(
      slug: widget.slug,
    );
  }
}

class LessonBody extends StatefulWidget {
  LessonBody({Key? key, required this.slug}) : super(key: key);
  String slug = "";
  @override
  State<LessonBody> createState() => _LessonBodyState();
}

class _LessonBodyState extends State<LessonBody> {
  late LessonViewModel _lessonViewModel;
  late CourseDetailViewModel _course;
  late CommonViewModel _common;

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _lessonViewModel = Provider.of<LessonViewModel>(context, listen: false);
      _course = Provider.of<CourseDetailViewModel>(context, listen: false);
      _common = Provider.of<CommonViewModel>(context, listen: false);
      get(_lessonViewModel);
    });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );

    super.initState();
  }

  String _headerHack =
  """<!DOCTYPE html><html><head><meta name="viewport" content="width=device-width, initial-scale=1.0">
      <style>
        img {
            width: 100%;
            height: auto;
            max-width: 100%;
            object-fit: contain;
        }
        .h-200{
            height: 100px !important;
        }
        p{
            font-size: 0.8em;
            word-wrap: break-word;
          }
          *{
           word-wrap: break-word;
          }
          iframe{
            width: 100% !important;
          }
          
      </style>
      </head><!--rest of your html--><body>""";
  String _footerHacks = '<div class="h-200"></div></body></html>';

  String wrapHtml(String content) {
    return _headerHack + content + _footerHacks;
  }

  bool completed = false;
  Future<void> get(LessonViewModel lessonViewModel) async {
    await lessonViewModel.getLesson(widget.slug);
    try {
      _course.getAssessment(_course.course!.details!.courseSlug!);
      _course.findWeek(lessonViewModel.lesson!.lessonSlug);
    } catch (e) {
      print("ERR " + e.toString());
    }
  }
  bool hasStarted = false;

  void startCourse({bool state = false}) {
    setState(() {
      hasStarted = state;
    });
  }

  int navigationIndex = 0;

  void getLessons(){
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: kWhite,
        builder: (context) {
          return Container(
              padding: MediaQuery.of(context).viewInsets,
              margin: MediaQuery.of(context).padding,
            child: Container(

                constraints: BoxConstraints(maxHeight: height * 0.8),
                height: height * 0.9, child: LessonModal(globalKey: _scaffoldKey,)),
          );
    });
  }

  void getComments(){
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: kWhite,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(

                constraints: BoxConstraints(maxHeight: height * 0.8),
                height: height * 0.9, child: CommentModal(globalKey: _scaffoldKey,)),
          );
        });
  }


  void getAssessments(){
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: kWhite,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(

                constraints: BoxConstraints(maxHeight: height * 0.8),
                height: height * 0.9, child: AssessmentModal(globalKey: _scaffoldKey,)),
          );
        });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer3<LessonViewModel, CourseDetailViewModel, AuthViewModel>(
        builder: (context, data, course, auth,child) {
      return Scaffold(
          key: _scaffoldKey,
          endDrawer: Drawer(
              child: CourseDetailDrawer(
            globalKey: _scaffoldKey,
          )),

          bottomNavigationBar: Theme(
            data: ThemeData(
              // splashColor: Colors.transparent,
              // highlightColor: Colors.transparent,
            ),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                elevation: 0,
                selectedItemColor: primary_2,
                unselectedItemColor: gray_900,
                selectedLabelStyle: TextStyle(color: primary_2),
                unselectedLabelStyle: TextStyle(color: gray_900),
                selectedFontSize: 12,
                unselectedFontSize: 12,
                currentIndex: 0,
                backgroundColor: kWhite,
                onTap: (int i){
                  if(i == 0){
                    getLessons();
                  }else if(i == 1){
                    getComments();
                  }else if(i == 2){
                    getAssessments();
                  }
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book, color: gray_900 ,),
                    label:'Courses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.comment_rounded, color: gray_900 ,),
                    label:'Comments',
                  ),BottomNavigationBarItem(
                    icon: Icon(Icons.assignment, color: gray_900 ,),
                    label:'Assessments',
                  ),

                ],
              ),
            ),
          ),
          appBar: AppBar(
            leading: backButton(context),
            actions: [
              InkWell(
                onTap: () {
                  try {
                    _scaffoldKey.currentState!.openEndDrawer();
                  } catch (e) {}
                },
                child: Container(
                    decoration: BoxDecoration(),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Icon(
                      Icons.book,
                      color: kBlack,
                    )),
              )
            ],
            title: Text(
              data.lesson == null ? "-" : data.lesson!.lessonTitle.toString(),
              style: TextStyle(color: kBlack),
            ),
            backgroundColor: kWhite,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: isLoading(data.lessonDetailApiResponse) ||
                  isError(data.lessonDetailApiResponse)
              ? Container()
              : !data.hasStarted
                  ? !isLoadingOnly(data.lessonStatusApiResponse)
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(top: 80),
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                data
                                    .startLesson(
                                        data.lesson!.lessonSlug.toString())
                                    .then((value) {
                                  if (isError(data.lessonStatusApiResponse)) {
                                    snackThis(
                                        context: context,
                                        content: Text(data
                                            .lessonStatusApiResponse.message
                                            .toString()),
                                        color: Colors.red);
                                  }
                                  // commonSnackHacks(context: context, response: data.lessonStatusApiResponse, success: [
                                  //   startCourse(),
                                  // ]);
                                });
                                // setState(() {
                                //   hasStarted = !hasStarted;
                                // });
                              },
                              label: Text("Start course"),
                              icon: Icon(Icons.play_arrow),
                              backgroundColor:
                                  completed ? green_1 : kPrimaryColorHover,
                            ),
                          ))
                      : Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(top: 80),
                            child: FloatingActionButton.large(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                              onPressed: () {},
                              backgroundColor: kPrimaryColorHover,
                            ),
                          ),
                        )
                  : !isLoadingOnly(data.lessonStatusApiResponse)
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                if (!data.hasFinished) {
                                  _common.setLoading(true);
                                  data
                                      .completeLesson(
                                          course.course!.details!.courseSlug.toString(),
                                          data.lesson!.lessonSlug.toString())
                                      .then((value) {
                                    if (isError(data.lessonStatusApiResponse)) {
                                      _common.setLoading(false);
                                      snackThis(
                                          context: context,
                                          content: Text(data
                                              .lessonStatusApiResponse.message
                                              .toString()),
                                          color: Colors.red);
                                    } else {
                                      _common.setLoading(false);
                                      try{
                                        _course.getCourse(_course.course!.details!.courseSlug.toString(), email: auth.user.email.toString());
                                      }catch(e){

                                      }
                                      course.setStatus(
                                          data.lesson!.lessonSlug.toString());
                                    }
                                  });
                                }
                              },
                              label: data.hasFinished
                                  ? Text("Marked as complete")
                                  : Text('Mark as complete'),
                              icon: data.hasFinished
                                  ? Icon(Icons.check)
                                  : Icon(Icons.thumb_up),
                              backgroundColor: data.hasFinished
                                  ? green_1
                                  : kPrimaryColorHover,
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: FloatingActionButton.extended(
                              icon: Center(
                                child: Container(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator()),
                              ),
                              label: Container(
                                child: Text("Loading"),
                              ),
                              onPressed: () {},
                              backgroundColor: kPrimaryColorHover,
                            ),
                          ),
                        ),
          // bottomNavigationBar: Container(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: kWhite,
          //       borderRadius: BorderRadius.only(
          //         topRight: Radius.circular(10),
          //         topLeft: Radius.circular(10),
          //       ),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.2),
          //           spreadRadius: 1,
          //           blurRadius: 7,
          //           offset: const Offset(-2, 0), // changes position of shadow
          //         ),
          //       ],
          //     ),
          //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //     margin: EdgeInsets.zero,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Expanded(
          //             child: Container(
          //                 child: Row(
          //           children: [
          //             Icon(
          //               Icons.chevron_left,
          //               color: kPrimaryColor,
          //             ),
          //             Text("Section 1"),
          //           ],
          //         ))),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Expanded(
          //             child: Container(
          //                 child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Text("Section 3"),
          //             Icon(
          //               Icons.chevron_right,
          //               color: kPrimaryColor,
          //             )
          //           ],
          //         ))),
          //       ],
          //     ),
          //   ),
          // ),
          body: Container(
              color: kWhite,
              child: SafeArea(
                  child: isLoading(data.lessonDetailApiResponse)
                      ? LessonShimmer()
                      : data.lesson == null
                          ? RefreshIndicator(
                              onRefresh: () => get(data),
                              child: ListView(
                                children: [
                                  Container(
                                      child: Image.asset(
                                          "assets/images/no-data.png")),
                                ],
                              ),
                            )
                          : Stack(
                              children: [
                                InAppWebView(
                                  initialOptions: options,
                                  pullToRefreshController:
                                      pullToRefreshController,
                                  onWebViewCreated: (controller) {
                                    webViewController = controller;
                                  },
                                  shouldOverrideUrlLoading:
                                      (controller, navigationAction) async {
                                    try {
                                      launchUrl(navigationAction.request.url!);
                                    } catch (e) {}
                                    return NavigationActionPolicy.CANCEL;
                                  },
                                  androidOnPermissionRequest:
                                      (controller, origin, resources) async {
                                    return PermissionRequestResponse(
                                        resources: resources,
                                        action: PermissionRequestResponseAction
                                            .GRANT);
                                  },
                                  onLoadStop: (controller, url) async {
                                    pullToRefreshController.endRefreshing();
                                  },
                                  onLoadError:
                                      (controller, url, code, message) {
                                    pullToRefreshController.endRefreshing();
                                  },
                                  onProgressChanged: (controller, progress) {
                                    if (progress == 100) {
                                      pullToRefreshController.endRefreshing();
                                    }
                                  },
                                  onConsoleMessage:
                                      (controller, consoleMessage) {
                                    print(consoleMessage);
                                  },
                                  initialUrlRequest: URLRequest(
                                      url: Uri.dataFromString(
                                          wrapHtml(data.lesson!.lessonContents
                                              .toString()),
                                          encoding: Encoding.getByName("utf-8"),
                                          mimeType: 'text/html')),
                                ),
                                Visibility(
                                  visible: !data.hasStarted,
                                  child: InkWell(
                                    onTap: () {
                                      print("ASP");
                                    },
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 3.0,
                                        sigmaY: 3.0,
                                      ),
                                      child: Container(),
                                    ),
                                  ),
                                ),
                              ],
                            ))));
    });
  }
}
