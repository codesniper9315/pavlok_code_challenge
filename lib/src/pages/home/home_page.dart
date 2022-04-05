import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pavlok_challenge/src/data/dummy.dart';
import 'package:pavlok_challenge/src/routes/routes.dart';
import 'package:pavlok_challenge/src/utils/components/primary_button.dart';
import 'package:pavlok_challenge/src/utils/constants/colors.dart';
import 'package:pavlok_challenge/src/utils/constants/icons.dart';
import 'package:pavlok_challenge/src/utils/constants/strings.dart';
import 'package:pavlok_challenge/src/utils/constants/styles.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'widgets/habit_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _controller;
  int? selectedGoodHabitItem;
  int? selectedBadHabitItem;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60.h),
          _indicatorBuilder(),
          SizedBox(height: 25.h),
          _titleBuilder(),
          SizedBox(height: 30.h),
          _tabbarBuilder(),
          SizedBox(height: 30.h),
          _tabviewBuilder(),
        ],
      ),
      bottomSheet: _bottomButtonBuilder(),
    );
  }

  Widget _indicatorBuilder() {
    return SizedBox(
      width: 375.w,
      height: 30.h,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 220.w,
              child: StepProgressIndicator(
                totalSteps: 4,
                currentStep: 1,
                roundedEdges: Radius.circular(10.sp),
                selectedColor: AppColors.indicatorColor,
                unselectedColor: AppColors.indicatorInActiveColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text('1 of 4', style: AppTextStyles.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleBuilder() {
    return Column(
      children: [
        Text(AppStrings.goalTitle, style: AppTextStyles.title),
        SizedBox(height: 12.h),
        Text(AppStrings.startTitle, style: AppTextStyles.subtitle),
      ],
    );
  }

  Widget _tabbarBuilder() {
    return TabBar(
      controller: _controller,
      indicatorColor: AppColors.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: AppTextStyles.normal,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.fontColor,
      tabs: [
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.goodHabit,
                color: _controller.index == 0 ? AppColors.primaryColor : AppColors.fontColor,
              ),
              SizedBox(width: 5.w),
              const Text(AppStrings.goodHabitTabTitle),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.badHabit,
                color: _controller.index == 1 ? AppColors.primaryColor : AppColors.fontColor,
              ),
              SizedBox(width: 5.w),
              const Text(AppStrings.badHabitTabTitle),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabviewBuilder() {
    return [
      Container(
        width: 375.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: goodHabitItems.map((item) {
            int index = goodHabitItems.indexOf(item);
            return Column(
              children: [
                HabitItem(
                  item: item,
                  selected: index == selectedGoodHabitItem,
                  onSelect: () => setState(() {
                    selectedGoodHabitItem = index;
                  }),
                ),
                SizedBox(height: 10.h),
              ],
            );
          }).toList(),
        ),
      ),
      Container(
        width: 375.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: badHabitItems.map((item) {
            int index = badHabitItems.indexOf(item);
            return Column(
              children: [
                HabitItem(
                  item: item,
                  selected: index == selectedBadHabitItem,
                  onSelect: () => setState(() {
                    selectedBadHabitItem = index;
                  }),
                ),
                SizedBox(height: 10.h),
              ],
            );
          }).toList(),
        ),
      ),
    ][_controller.index];
  }

  Widget _bottomButtonBuilder() {
    return Container(
      width: 375.w,
      height: 60.h,
      alignment: Alignment.center,
      child: PrimaryButton(
        onPressed: () => Navigator.pushNamed(context, Routes.setTime),
        width: 355.w,
        height: 50.h,
        title: AppStrings.nextButtonTitle,
      ),
    );
  }
}
