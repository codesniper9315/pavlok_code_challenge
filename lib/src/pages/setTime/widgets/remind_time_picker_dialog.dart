import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:pavlok_challenge/src/utils/components/primary_button.dart';
import 'package:pavlok_challenge/src/utils/constants/strings.dart';
import 'package:pavlok_challenge/src/utils/constants/styles.dart';

class RemindTimePickerDialog extends StatefulWidget {
  const RemindTimePickerDialog({Key? key, required this.value}) : super(key: key);

  final int value;

  @override
  State<RemindTimePickerDialog> createState() => _RemindTimePickerDialogState();
}

class _RemindTimePickerDialogState extends State<RemindTimePickerDialog> {
  late int remindTime;

  @override
  void initState() {
    super.initState();
    remindTime = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 375.w,
        height: 460.h,
        color: Colors.white,
        padding: EdgeInsets.only(top: 40.h, bottom: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.reminder, style: AppTextStyles.title),
            SizedBox(
              width: 375.w,
              height: 280.h,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 80.w,
                      child: InViewNotifierList(
                        isInViewPortCondition: (double deltaTop, double deltaBottom, double vpHeight) {
                          return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
                        },
                        initialInViewIds: ['${widget.value ~/ 5}'],
                        itemCount: 12,
                        padding: EdgeInsets.symmetric(vertical: 120.h),
                        builder: (BuildContext context, int index) {
                          return InViewNotifierWidget(
                            id: '$index',
                            builder: (BuildContext context, bool isInView, Widget? child) {
                              if (isInView) {
                                remindTime = (index + 1) * 5;
                              }
                              return Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: Text(
                                  '${(index + 1) * 5}',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.title.copyWith(
                                    fontSize: 26.sp,
                                    color: !isInView ? Colors.grey : Colors.black,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 100.w),
                      child: Text('min', style: AppTextStyles.title),
                    ),
                  ),
                ],
              ),
            ),
            PrimaryButton(
              onPressed: () => Navigator.pop(context, remindTime),
              width: 355.w,
              height: 50.h,
              title: AppStrings.doneButtonTitle,
            )
          ],
        ),
      ),
    );
  }
}
