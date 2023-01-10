import 'dart:io';

import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/assessment_screen/assessment_viewmodel.dart';
import 'package:digi_school/screens/assessment_screen/components/assessment_shimmer.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';

import 'package:file_picker/file_picker.dart';

class AssessmentScreen extends StatefulWidget {
  AssessmentScreen({Key? key, required this.slug}) : super(key: key);
  String slug = "";
  static const String routeName = "/assessment";

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  late AssessmentViewModel _assessmentViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _assessmentViewModel =
          Provider.of<AssessmentViewModel>(context, listen: false);
      get(_assessmentViewModel);
    });

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
      </style>
      </head><!--rest of your html--><body>""";
  String _footerHacks = '<div class="h-200"></div></body></html>';

  final HtmlEditorController controller = HtmlEditorController();

  String wrapHtml(String content) {
    return _headerHack + content + _footerHacks;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AssessmentViewModel, CommonViewModel>(
        builder: (context, data, common, child) {
      return Scaffold(
          appBar: AppBar(
            leading: backButton(context),
            title: Text(
              data.assessmentData == null
                  ? "-"
                  : data.assessmentData!.lesson!.lessonTitle.toString(),
              style: TextStyle(color: kBlack),
            ),
            backgroundColor: kWhite,
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: kPrimaryColor,
            icon: Icon(Icons.upload),
            onPressed: () {
              common.setLoading(true);
              controller.getText().then((value) {
                data.uploadAssignment(widget.slug, value).then((value) {
                  commonSnackHacks(
                      context: context,
                      response: data.assessmentUploadApiResponse);
                  common.setLoading(false);
                }).catchError(() {
                  common.setLoading(false);
                });
              });
            },
            label: Text("Submit"),
          ),
          body: Container(
              color: kWhite,
              child: SafeArea(
                  child: isLoading(data.assessmentApiResponse)
                      ? AssessmentShimmer()
                      : data.assessmentData == null
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
                          : SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Html(
                                    data: wrapHtml(data.assessmentData!.contents
                                        .toString()),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Text(
                                      "Submissions",
                                      style: TextStyle(
                                          fontSize: h5,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: HtmlEditor(
                                        controller: controller, //required
                                        htmlEditorOptions: HtmlEditorOptions(
                                          hint: "Your text here...",
                                          initialText:
                                              data.assessmentData!.submission !=
                                                          null &&
                                                      data
                                                          .assessmentData!
                                                          .submission!
                                                          .isNotEmpty
                                                  ? data.assessmentData!
                                                      .submission![0].contents
                                                      .toString()
                                                  : "",
                                        ),
                                        htmlToolbarOptions: HtmlToolbarOptions(
                                          toolbarPosition: ToolbarPosition
                                              .aboveEditor, //by default
                                          toolbarType: ToolbarType
                                              .nativeExpandable, //by default

                                          mediaLinkInsertInterceptor:
                                              (String url,
                                                  InsertFileType type) {
                                            print(url);
                                            return true;
                                          },
                                          mediaUploadInterceptor:
                                              (PlatformFile file,
                                                  InsertFileType type) async {
                                            print(file.name); //filename
                                            print(file.size); //size in bytes
                                            print(file
                                                .extension); //file extension (eg jpeg or mp4)
                                            return true;
                                          },
                                        ),
                                        otherOptions: OtherOptions(height: 400),
                                      )),
                                ],
                              ),
                            ))));
    });
  }

  Future<void> get(AssessmentViewModel data) async {
    data.getSingleAssessment(widget.slug);
  }
}
