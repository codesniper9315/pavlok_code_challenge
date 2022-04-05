import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavlok_challenge/src/data/model/habit_item_model.dart';
import 'package:pavlok_challenge/src/utils/constants/colors.dart';
import 'package:pavlok_challenge/src/utils/constants/styles.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({
    Key? key,
    required this.item,
    required this.selected,
    required this.onSelect,
  }) : super(key: key);

  final HabitItemModel item;
  final bool selected;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Card(
        elevation: 8.0,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
        margin: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryShadowColor : Colors.white,
            border: Border.all(color: selected ? AppColors.primaryColor : Colors.transparent, width: 1.sp),
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Row(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryShadowColor,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                alignment: Alignment.center,
                child: Center(child: Image.asset(item.icon)),
              ),
              Text(item.title, style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
