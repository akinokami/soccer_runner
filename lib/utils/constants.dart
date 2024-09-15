import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soccer_run/utils/app_theme.dart';

Constants constants = Constants();

class Constants {
  static final Constants _constants = Constants._i();

  factory Constants() {
    return _constants;
  }

  Constants._i();
  void showSnackBar(
      {String? title, String? msg, Color? bgColor, Color? textColor}) {
    Get.snackbar(
      title ?? "",
      msg ?? "",
      colorText: textColor ?? AppTheme.blackTextColor,
      backgroundColor: bgColor ?? AppTheme.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void showDialog(String title, String desc, VoidCallback? onTap) {
    Get.defaultDialog(
        titlePadding: EdgeInsets.all(10.w),
        contentPadding: EdgeInsets.all(10.w),
        title: title,
        middleText: desc,
        backgroundColor: AppTheme.white,
        titleStyle: TextStyle(color: AppTheme.black, fontSize: 15.sp),
        middleTextStyle: TextStyle(color: AppTheme.black, fontSize: 12.sp),
        textConfirm: 'yes'.tr,
        textCancel: 'no'.tr,
        cancelTextColor: AppTheme.black,
        confirmTextColor: AppTheme.white,
        buttonColor: const Color(0xff8f7a66),
        barrierDismissible: false,
        radius: 10.r,
        onConfirm: onTap);
  }
}

///Storage constant
String language = 'language';
String mute = 'isMuted';
String first = 'first';
String four = 'four';
String five = 'five';
String six = 'six';
String eight = 'eight';

enum Language { en, vi, zh }
