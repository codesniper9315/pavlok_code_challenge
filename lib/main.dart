import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavlok_challenge/src/routes/generator.dart';
import 'package:pavlok_challenge/src/routes/routes.dart';
import 'package:pavlok_challenge/src/utils/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.backgroundColor,
          ),
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primaryColor: AppColors.primaryColor,
        ),
        initialRoute: Routes.start,
        onGenerateRoute: RouteGenerator.onGenerate,
      ),
    );
  }
}
