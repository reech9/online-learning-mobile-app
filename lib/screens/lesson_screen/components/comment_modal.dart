import 'package:digi_school/api/response/comment_response.dart';
import 'package:digi_school/api/response/course_detail_response.dart';
import 'package:digi_school/api/response/lesson_response.dart'
    as LessonResponse;
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/lesson_screen/components/comment_shimmer.dart';
import 'package:digi_school/screens/lesson_screen/components/lesson_filter_shimmer.dart';
import 'package:digi_school/screens/lesson_screen/lesson_screen.dart';
import 'package:digi_school/screens/lesson_screen/lesson_viewmodel.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../widgets/cache_image_util.dart';
import '../../course_detail/course_detail_viewmodel.dart';

class CommentModal extends StatefulWidget {
  GlobalKey<ScaffoldState> globalKey;
  CommentModal({Key? key, required this.globalKey}) : super(key: key);

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  double headerHeight = 40;
  late LessonViewModel _lessonViewModel;
  late CommonViewModel _commonViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _lessonViewModel = Provider.of<LessonViewModel>(context, listen: false);
      _commonViewModel = Provider.of<CommonViewModel>(context, listen: false);
      getComments(_lessonViewModel);
    });
  }

  String? replyPending;
  void getComments(LessonViewModel lessonViewModel) {
    lessonViewModel.getComments(lessonViewModel.lesson!.lessonSlug.toString());
    lessonViewModel.getRatings(lessonViewModel.lesson!.lessonSlug.toString());
  }

  TextEditingController _commentController = TextEditingController();

  String status = "comment";
  String? commentId;
  List<int> stack = [];

  FocusNode _commentNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void _requestFocus(_focusNode) {
    setState(() {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LessonViewModel, CourseDetailViewModel>(
        builder: (context, data, course, child) {
      return SafeArea(
        child: Stack(
          children: [
            isLoading(data.lessonDetailApiResponse) ||
                    isLoading(data.lessonCommentApiResponse)
                ? CommentShimmer()
                : course.course == null
                    ? Text("Error Please try again")
                    : Container(
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior()
                              .copyWith(overscroll: false),
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: headerHeight + 20,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Comments",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: SmoothStarRating(
                                                allowHalfRating: false,
                                                rating: data.rating == -1
                                                    ? 0.toDouble()
                                                    : data.rating.toDouble(),
                                                isReadOnly: false,
                                                size: 25,
                                                onRated: (double value) {
                                                  _commonViewModel
                                                      .setLoading(true);
                                                  try {
                                                    data
                                                        .doRating(
                                                            value.toInt(),
                                                            data.lesson!
                                                                .lessonSlug
                                                                .toString())
                                                        .then((value) {
                                                      _commonViewModel
                                                          .setLoading(false);
                                                    });
                                                  } catch (e) {
                                                    _commonViewModel
                                                        .setLoading(false);
                                                  }
                                                },
                                                starCount: 5,
                                                color: Colors.yellow.shade700,
                                                borderColor:
                                                    Colors.yellow.shade700,
                                                spacing: 0.0,
                                                // color: ,
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    if (data.lesson != null)
                                      if (data.comment.length == 0)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(
                                            "Looks like there are no comment for this lesson.\nBe the first to comment",
                                            style: TextStyle(color: gray_700),
                                          ),
                                        ),
                                    if (data.comment.length != 0)
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: data.comment.length,
                                        itemBuilder: (context, i) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: buildCommentCard(
                                                data.comment[i], [i]),
                                          );
                                        },
                                      ),
                                    SizedBox(
                                      height: 80,
                                    )
                                  ],
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        border: Border(
                                            top: BorderSide(color: gray_500))),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (replyPending != null)
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                            "Replying to " +
                                                                replyPending!)),
                                                    Expanded(
                                                        child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                replyPending =
                                                                    null;
                                                                _commentNode
                                                                    .unfocus();
                                                                status =
                                                                    "comment";
                                                                commentId =
                                                                    null;
                                                                stack = [];
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              });
                                                            },
                                                            child: Container(
                                                                child: Text(
                                                                    "Cancel"))))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                flex: 6,
                                                child: TextFormField(
                                                  focusNode: _commentNode,
                                                  onTap: () => _requestFocus(
                                                      _commentNode),
                                                  enabled: true,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  validator: (value) {
                                                    if (value == "") {
                                                      return 'Please enter a comment';
                                                    }
                                                    // success condition
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Write a comment",
                                                    fillColor: gray_100,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: -10,
                                                            horizontal: 10),
                                                    filled: true,
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    gray_500)),
                                                    focusColor: kPrimaryColor,
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    kPrimaryColor)),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                  ),
                                                  controller:
                                                      _commentController,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: InkWell(
                                                onTap: () {
                                                  _commonViewModel
                                                      .setLoading(true);
                                                  _commentNode.unfocus();
                                                  FocusScope.of(context)
                                                      .unfocus();

                                                  try {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      if (status == "comment") {
                                                        _lessonViewModel
                                                            .writeComment(
                                                                _commentController
                                                                    .text,
                                                                _lessonViewModel
                                                                    .lesson!
                                                                    .lessonSlug
                                                                    .toString())
                                                            .then((value) {
                                                          if (isError(
                                                              _lessonViewModel
                                                                  .lessonCommentUpdateApiResponse)) {
                                                            snackThis(
                                                                context:
                                                                    context,
                                                                color:
                                                                    Colors.red,
                                                                content: Text(
                                                                    _lessonViewModel
                                                                        .lessonCommentUpdateApiResponse
                                                                        .message
                                                                        .toString()));
                                                          } else {
                                                            _commentController
                                                                .text = "";
                                                          }
                                                          _commonViewModel
                                                              .setLoading(
                                                                  false);
                                                        });
                                                      } else if (status ==
                                                          "reply") {
                                                        if (commentId != null) {
                                                          _lessonViewModel
                                                              .replyComment(
                                                                  commentId!,
                                                                  _commentController
                                                                      .text,
                                                                  stack)
                                                              .then((value) {
                                                            if (isError(
                                                                _lessonViewModel
                                                                    .lessonCommentUpdateApiResponse)) {
                                                              snackThis(
                                                                  context:
                                                                      context,
                                                                  color: Colors
                                                                      .red,
                                                                  content: Text(_lessonViewModel
                                                                      .lessonCommentUpdateApiResponse
                                                                      .message
                                                                      .toString()));
                                                            } else {
                                                              _commentController
                                                                  .text = "";
                                                              setState(() {
                                                                replyPending =
                                                                    null;
                                                                _commentNode
                                                                    .unfocus();
                                                                status =
                                                                    "comment";
                                                                commentId =
                                                                    null;
                                                                stack = [];
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              });
                                                            }
                                                            _commonViewModel
                                                                .setLoading(
                                                                    false);
                                                          });
                                                        }
                                                      }
                                                    } else {
                                                      _commonViewModel
                                                          .setLoading(false);
                                                    }
                                                  } catch (e) {
                                                    _commonViewModel
                                                        .setLoading(false);
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: Icon(Icons.send,
                                                      color: kWhite),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              height: headerHeight,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildCommentCard(CommentData data, List<int> stack) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                constraints: BoxConstraints(maxHeight: 50),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CacheImageUtil(
                      height: 50,
                      width: 50,
                      image: data.postedBy!.userImage.toString(),
                      default_image: "assets/images/default_user.png",
                    )
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.postedBy!.firstname.toString() +
                        " " +
                        data.postedBy!.lastname.toString(),
                    style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: p1),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    data.postedBy!.email.toString(),
                    style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: p2),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: data.comment.toString()))
                  .then((_) {
                snackThis(
                    context: context,
                    color: Colors.black,
                    content: Text("Copied to clipboard"));
              });
            },
            child: Container(
              width: double.infinity,
              child: Text(
                data.comment.toString(),
                style: TextStyle(
                    color: kBlack, fontWeight: FontWeight.w500, fontSize: p2),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  _commentNode.unfocus();
                  _requestFocus(_commentNode);
                  setState(() {
                    replyPending = data.postedBy!.firstname.toString() +
                        " " +
                        data.postedBy!.lastname.toString();
                    status = "reply";
                    commentId = data.id!;
                    this.stack = stack;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.reply,
                        size: 15,
                        color: gray_800,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Reply",
                        style: TextStyle(color: gray_800),
                      ),
                    ],
                  ),
                ),
              ),
              Text(" | "),
              Text("${data.replies!.length} replies"),
            ],
          ),
          if (data.replies != null && data.replies!.isNotEmpty)
            IntrinsicHeight(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                              color: gray_500,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(child: Builder(builder: (context) {
                                  List<Widget> _buildThis = [];
                                  for (var i = 0;
                                      i < data.replies!.length;
                                      i++) {
                                    _buildThis.add(buildCommentCard(
                                        data.replies![i], [...stack, i]));
                                  }
                                  return Column(
                                    children: [
                                      ..._buildThis,
                                    ],
                                  );
                                }))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
        ],
      ),
    );
  }
}
