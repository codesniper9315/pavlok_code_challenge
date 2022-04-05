import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pavlok_challenge/src/utils/components/primary_button.dart';
import 'package:pavlok_challenge/src/utils/constants/colors.dart';
import 'package:pavlok_challenge/src/utils/constants/icons.dart';
import 'package:pavlok_challenge/src/utils/constants/images.dart';
import 'package:pavlok_challenge/src/utils/constants/strings.dart';
import 'package:pavlok_challenge/src/utils/constants/styles.dart';
import 'package:pavlok_challenge/src/utils/plugins/flutter_circular_slider/flutter_circular_slider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'widgets/remind_time_picker_dialog.dart';

class SetTimePage extends StatefulWidget {
  const SetTimePage({Key? key}) : super(key: key);

  @override
  State<SetTimePage> createState() => _SetTimePageState();
}

class _SetTimePageState extends State<SetTimePage> {
  int sleepTime = 0;
  int wakeupTime = 30;
  int duration = 30;
  List<int> selectedDays = [];
  int remindTime = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 21.sp),
        ),
      ),
      body: SizedBox(
        width: 375.w,
        child: Column(
          children: [
            Text(AppStrings.setTime, style: AppTextStyles.title),
            SizedBox(height: 20.h),
            _watchBuilder(),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.union),
                SizedBox(width: 5.w),
                Text(
                  duration ~/ 12 > 8 ? AppStrings.overGoal : AppStrings.underGoal,
                  style: AppTextStyles.normal,
                )
              ],
            ),
            _timeWidgetsBuilder(),
            _weekdaySelectionBuilder(),
            _remindTimeSelectionBuilder(),
          ],
        ),
      ),
      bottomSheet: _bottomButtonBuilder(),
    );
  }

  Widget _watchBuilder() {
    return DoubleCircularSlider(
      288,
      sleepTime,
      wakeupTime,
      width: 240.w,
      height: 240.w,
      baseColor: AppColors.trackColor,
      selectionColor: AppColors.primaryColor,
      sliderStrokeWidth: 20.w,
      startWidget: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(AppIcons.sleepSm),
      ),
      endWidget: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(AppIcons.wakeupSm),
      ),
      child: Center(
        child: Container(
          width: 190.w,
          height: 190.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(AppImages.watch),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getHour(duration),
                style: AppTextStyles.title.copyWith(color: AppColors.primaryColor),
              ),
              SizedBox(height: 5.h),
              Text(
                getMinute(duration),
                style: AppTextStyles.normal.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      onSelectionChange: (start, end, rad) {
        setState(() {
          sleepTime = start;
          wakeupTime = end;
          if (sleepTime > wakeupTime) {
            duration = wakeupTime + 288 - sleepTime;
          } else {
            duration = wakeupTime - sleepTime;
          }
        });
      },
    );
  }

  Widget _timeWidgetsBuilder() {
    return Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(AppIcons.sleepLg),
              SizedBox(width: 5.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.bedTime, style: AppTextStyles.normal),
                  SizedBox(height: 5.h),
                  Text(formatTime(sleepTime), style: AppTextStyles.title),
                ],
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.wakeupLg),
              SizedBox(width: 5.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.wakeup, style: AppTextStyles.normal),
                  SizedBox(height: 5.h),
                  Text(formatTime(wakeupTime), style: AppTextStyles.title),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _weekdaySelectionBuilder() {
    return Container(
      width: 315.w,
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.repeatDays,
            style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              bool isSelected = selectedDays.contains(index);
              return InkWell(
                onTap: () {
                  if (isSelected) {
                    selectedDays.remove(index);
                  } else {
                    selectedDays.add(index);
                  }
                  setState(() {});
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  margin: EdgeInsets.zero,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isSelected ? AppColors.primaryShadowColor : AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        getWeekDay(index),
                        style: AppTextStyles.subtitle.copyWith(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _remindTimeSelectionBuilder() {
    return InkWell(
      onTap: onChangeRemindTime,
      child: Container(
        width: 315.w,
        margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.remindMe, style: AppTextStyles.subtitle),
            Text('$remindTime min', style: AppTextStyles.title),
          ],
        ),
      ),
    );
  }

  Widget _bottomButtonBuilder() {
    return Container(
      width: 375.w,
      height: 60.h,
      alignment: Alignment.center,
      child: PrimaryButton(
        onPressed: () {},
        width: 355.w,
        height: 50.h,
        title: AppStrings.nextButtonTitle,
      ),
    );
  }

  void onChangeRemindTime() async {
    final result = await showSlidingBottomSheet(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          duration: const Duration(milliseconds: 400),
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [1],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) => RemindTimePickerDialog(value: remindTime),
        );
      },
    );
    if (result != null) {
      setState(() {
        remindTime = result;
      });
    }
  }

  String getWeekDay(int day) {
    switch (day) {
      case 0:
        return 'SU';
      case 1:
        return 'MO';
      case 2:
        return 'TU';
      case 3:
        return 'WE';
      case 4:
        return 'TH';
      case 5:
        return 'FR';
      case 6:
        return 'SA';
      default:
        return 'MO';
    }
  }

  String formatTime(int time) {
    if (time == 0) {
      return '00:00';
    }
    var hours = time ~/ 12;
    var minutes = (time % 12) * 5;
    var suffix = hours >= 12 ? 'PM' : 'AM';
    var formattedHour = hours > 12 ? hours - 12 : hours;
    return '$formattedHour:$minutes $suffix';
  }

  String getHour(int time) {
    if (time == 0) {
      return '00 hrs';
    }
    var hours = time ~/ 12;
    return '$hours hrs';
  }

  String getMinute(int time) {
    if (time == 0) {
      return '00 min';
    }
    var minutes = (time % 12) * 5;
    return '$minutes min';
  }
}
