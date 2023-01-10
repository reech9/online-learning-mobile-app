// import 'package:digi_school/auth_viewmodel.dart';
// import 'package:digi_school/common_viewmodel.dart';
// import 'package:digi_school/screens/home_screen/home_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Coursecheck extends StatefulWidget {
//   const Coursecheck({Key? key}) : super(key: key);
//
//   @override
//   _CoursecheckState createState() => _CoursecheckState();
// }
//
// class _CoursecheckState extends State<Coursecheck> {
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<HomeViewModel>(context, listen: false).fetchCourses("");
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Consumer3<AuthViewModel,CommonViewModel,HomeViewModel>(
//         builder: (context, auth,common,data, child) {
//           return ListView.builder(
//             shrinkWrap: true,
//             physics: const ScrollPhysics(),
//             itemCount: data.courses.length,itemBuilder: (context,index){
//             return Text(data.courses[index].courseTitle.toString());
//           },);
//         }
//     );
//   }
// }
