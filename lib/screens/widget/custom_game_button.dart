import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soccer_run/screens/widget/custom_text.dart';
import 'package:soccer_run/utils/app_theme.dart';

class CustomGameButton extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? height;
  final double? width;
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final Function()? onTap;
  const CustomGameButton({
    super.key,
    this.text,
    this.textColor,
    this.fontSize,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.height,
    this.width,
    this.color1,
    this.color2,
    this.color3,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 35.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1, //spread radius
                blurRadius: 2, // blur radius
                offset: const Offset(0, 2), // changes position of shadow
                //first paramerter of offset is left-right
                //second parameter is top to down
              ),
            ],
            gradient: LinearGradient(
              colors: [
                color1 ?? Colors.deepOrange, // Colors.green,
                color2 ?? Colors.deepOrange.shade300, // Colors.green.shade300,
                color3 ?? Colors.deepOrange, //Colors.green,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border:
                Border.all(width: 2.w, color: AppTheme.silver)), //premiumColor2
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null,
              child: Icon(
                icon ?? Icons.abc,
                color: iconColor ?? Colors.black,
                size: iconSize ?? 18.sp,
              ),
            ),
            Visibility(
              visible: text != null,
              child: CustomText(
                text: text ?? '',
                textColor: textColor,
                size: fontSize ?? 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
