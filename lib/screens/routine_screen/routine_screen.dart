import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/course_detail/course_detail_viewmodel.dart';
import 'package:digi_school/screens/routine_screen/components/routine_modal.dart';
import 'package:digi_school/screens/routine_screen/components/routine_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../widgets/utils.dart';
import 'dart:math' as math;

class RoutineScreen extends StatefulWidget {
  RoutineScreen({Key? key, required this.slug}) : super(key: key);
  String slug;
  static const String routeName = "/routine";
  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  late CourseDetailViewModel _courseDetailViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _courseDetailViewModel =
          Provider.of<CourseDetailViewModel>(context, listen: false);
      get(_courseDetailViewModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CourseDetailViewModel, CommonViewModel>(
        builder: (context, data, common, child) {
      return Scaffold(
          appBar: AppBar(
            leading: backButton(context),
            title: Text(
              "Routine",
              style: TextStyle(color: kBlack),
            ),
            backgroundColor: kWhite,
          ),
          body: Container(
              color: kWhite,
              child: SafeArea(
                  child: isLoading(data.routineApiResponse)
                      ? RoutineShimmer()
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
                          : Container(
                              child: GestureDetector(
                                child: SfCalendar(
                                  view: CalendarView.week,
                                  onTap: (CalendarTapDetails details) {
                                    if (details.targetElement ==
                                            CalendarElement.appointment ||
                                        details.targetElement ==
                                            CalendarElement.agenda) {
                                      final Meeting appointmentDetails =
                                          details.appointments![0];

                                      double height =
                                          MediaQuery.of(context).size.height;
                                      showModalBottomSheet(
                                          context: context,
                                          isDismissible: true,
                                          enableDrag: true,
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(20))),
                                          backgroundColor: kWhite,
                                          builder: (context) {
                                            return Container(
                                                constraints: BoxConstraints(
                                                    maxHeight: height * 0.5),
                                                height: height * 0.5,
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                margin: MediaQuery.of(context)
                                                    .padding,
                                                child: Container(
                                                  child: RoutineModal(
                                                    appointmentDetails:
                                                        appointmentDetails,
                                                  ),
                                                ));
                                          });
                                    }
                                  },
                                  dataSource:
                                      MeetingDataSource(_getDataSource(data)),
                                  monthViewSettings: MonthViewSettings(
                                      appointmentDisplayMode:
                                          MonthAppointmentDisplayMode
                                              .appointment),
                                ),
                              ),
                            ))));
    });
  }

  List<Meeting> _getDataSource(CourseDetailViewModel data) {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    int i = 0;
    for (var element in data.routine) {
      if (i > 9) i = 0;
      final DateTime startTime = DateTime(today.year, today.month,
          element.start!.day, element.start!.hour, 0, 0);
      final DateTime endTime = DateTime(
          today.year, today.month, element.end!.day, element.end!.hour, 0, 0);
      meetings.add(Meeting(
          element.title.toString(), startTime, endTime, _colors[i], false, i));
      meetings.add(Meeting(
          element.title.toString(), startTime, endTime, _colors[i], false, i));
      i++;
    }
    return meetings;
  }

  Future<void> get(CourseDetailViewModel courseDetailViewModel) async {
    courseDetailViewModel.getRoutine(widget.slug);
  }

  List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.brown,
    Colors.amber,
    Colors.blue,
    Colors.cyan,
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
  ];
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.index);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  int index;
}
