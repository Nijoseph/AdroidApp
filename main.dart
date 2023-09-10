import 'package:data_capture/pages/login.dart';
import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    //#region Decralation
    final textTheme = Theme.of(context).textTheme;
    //#endregion
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      initialBinding: ControllerBindings(),
      //#region ThemeData
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: MyBlueGrayBlueGray100,
          textTheme: GoogleFonts.poppinsTextTheme(textTheme).copyWith(
            headline6: GoogleFonts.poppins(
                textStyle: textTheme.headline6,
                color: MyBlueGrayBlueGray600,
                letterSpacing: 0.15,
                fontSize: 16),
            bodyText1: GoogleFonts.poppins(
                textStyle: textTheme.bodyText1,
                color: MyBlueGrayBlueGray900,
                letterSpacing: 0.15,
                fontSize: 14),
            subtitle1: GoogleFonts.poppins(
                textStyle: textTheme.subtitle1,
                color: MyBlueGrayBlueGray700,
                letterSpacing: 0.1,
                fontSize: 14),
            caption: GoogleFonts.poppins(
                textStyle: textTheme.caption,
                color: MyBlueGrayBlueGray300,
                letterSpacing: 0.1,
                fontSize: 11),
            labelMedium: GoogleFonts.poppins(
                textStyle: textTheme.caption,
                color: MyBlueGrayBlueGray900,
                letterSpacing: 0.1,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          canvasColor: MyBlueGrayBlueGray50),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: MyGreenGreen50,
        iconTheme: const IconThemeData(size: 24.0, color: Colors.white70),
      ),
//#endregion
      home: const LoginPage(),
    );
  }
}
