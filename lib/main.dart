import 'dart:io';

import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/preference.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/notifications/local_notification_service.dart';
import 'package:digi_school/routes/route_generator.dart';
import 'package:digi_school/screens/assessment_screen/assessment_viewmodel.dart';
import 'package:digi_school/screens/course_detail/course_detail_viewmodel.dart';
import 'package:digi_school/screens/category_screen/category_viewmodel.dart';
import 'package:digi_school/screens/home_screen/home_view_model.dart';
import 'package:digi_school/screens/quiz/quiz_view_model.dart';
import 'package:digi_school/screens/search_screen/search_viewmodel.dart';
import 'package:digi_school/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:khalti_flutter/localization/khalti_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configs/environment.config.dart';
import 'screens/lesson_screen/lesson_viewmodel.dart';
import 'screens/navigation/navigation_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await EnvironmentConfig().init();
  await PreferenceUtils.init();
  LocalNotificationService.initialize();
  ByteData data =
      await PlatformAssetBundle().load('assets/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]).then((_) {
  //   SharedPreferences.getInstance().then((prefs) {
  //     var darkModeOn = prefs.getBool('darkMode') ?? true;
  //     runApp(MyApp(themeData: darkModeOn ? MyThemes().darkTheme : MyThemes().lightTheme ),
  //     );
  //   });
  // });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: Center(
            child: Container(
                height: 250,
                width: 250,
                child: Lottie.asset('assets/preloader.json'))),
        // SpinKitDoubleBounce(
        //   color: kPrimaryColor,
        //   size: 50.0,
        // ),
      ),
      overlayOpacity: 0.8,
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider<CommonViewModel>(
              create: (_) => CommonViewModel(),
            ),
            ChangeNotifierProvider<AuthViewModel>(
              create: (_) => AuthViewModel(),
            ),
            ChangeNotifierProvider<SearchViewModel>(
              create: (_) => SearchViewModel(),
            ),
            ChangeNotifierProvider<HomeViewModel>(
              create: (_) => HomeViewModel(),
            ),
            ChangeNotifierProvider<LessonViewModel>(
              create: (_) => LessonViewModel(),
            ),
            ChangeNotifierProvider<CourseDetailViewModel>(
              create: (_) => CourseDetailViewModel(),
            ),
            ChangeNotifierProvider<QuizViewModel>(
              create: (_) => QuizViewModel(),
            ),
            ChangeNotifierProvider<CategoryViewModel>(
              create: (_) => CategoryViewModel(),
            ),
            ChangeNotifierProvider<AssessmentViewModel>(
              create: (_) => AssessmentViewModel(),
            ),
          ],
          child: Consumer<CommonViewModel>(builder: (context, common, child) {
            final themeProvider = Provider.of<CommonViewModel>(context);
            if (common.isLoading) {
              context.loaderOverlay.show();
            }
            if (!common.isLoading) {
              context.loaderOverlay.hide();
            }
            return KhaltiScope(
                publicKey: "asdf",
                builder: (context, navigatorKey) {
                  return MaterialApp(
                    navigatorKey: navigatorKey,
                    supportedLocales: const [
                      Locale('en', 'US'),
                      Locale('ne', 'NP'),
                    ],
                    localizationsDelegates: const [
                      KhaltiLocalizations.delegate,
                    ],
                    title: 'Digi School',
                    debugShowCheckedModeBanner: false,
                    // theme: common.getTheme(),
                    // themeMode: themeProvider.themeMode,
                    // theme: MyThemes.lightTheme,
                    // darkTheme: MyThemes.darkTheme,
                    initialRoute: '/',
                    onGenerateRoute: RouteGenerator.generateRoute,
                  );
                });
          })),
    );
  }
}
