// import 'package:digi_school/common_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// class ChangeThemeButtonWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<CommonViewModel>(context);
//
//     return Switch.adaptive(
//       value: themeProvider.isDarkMode,
//       onChanged: (value) {
//         final provider = Provider.of<CommonViewModel>(context, listen: false);
//         provider.toggleTheme(value);
//       },
//     );
//   }
// }