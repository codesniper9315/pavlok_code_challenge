import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavlok_challenge/src/utils/constants/colors.dart';

class AppTextStyles {
  static TextStyle title = TextStyle(fontSize: 24.sp, color: Colors.black, fontWeight: FontWeight.w700);
  static TextStyle subtitle = TextStyle(fontSize: 16.sp, color: Colors.black);
  static TextStyle normal = TextStyle(fontSize: 14.sp, color: AppColors.fontColor);
  static TextStyle buttonTitle = TextStyle(fontSize: 16.sp, color: Colors.white);
}

class AppGradients {
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [AppColors.primaryColor, AppColors.primaryLightColor],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
  static const LinearGradient cardGradient = LinearGradient(
    colors: [AppColors.primaryColor, AppColors.primaryLightColor],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
}
