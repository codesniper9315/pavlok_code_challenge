import 'package:pavlok_challenge/src/data/model/habit_item_model.dart';
import 'package:pavlok_challenge/src/utils/constants/images.dart';
import 'package:pavlok_challenge/src/utils/constants/strings.dart';

List<HabitItemModel> goodHabitItems = [
  HabitItemModel(title: AppStrings.setTime, icon: AppImages.sleep),
  HabitItemModel(title: AppStrings.walk, icon: AppImages.walk),
  HabitItemModel(title: AppStrings.stay, icon: AppImages.bottle),
  HabitItemModel(title: AppStrings.call, icon: AppImages.call),
  HabitItemModel(title: AppStrings.donate, icon: AppImages.donate),
];

List<HabitItemModel> badHabitItems = [
  HabitItemModel(title: AppStrings.cantWakeUp, icon: AppImages.sleep),
  HabitItemModel(title: AppStrings.lazy, icon: AppImages.walk),
  HabitItemModel(title: AppStrings.forget, icon: AppImages.bottle),
  HabitItemModel(title: AppStrings.spend, icon: AppImages.donate),
];
