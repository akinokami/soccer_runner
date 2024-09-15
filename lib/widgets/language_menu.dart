import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soccer_run/controller/language_controller.dart';
import 'package:soccer_run/utils/app_theme.dart';
import 'package:soccer_run/utils/constants.dart';
import 'package:soccer_run/widgets/settings_menu.dart';

import '../game/soccer_run.dart';
import '../screens/widget/custom_game_button.dart';
import '../screens/widget/custom_text.dart';

class LanguageMenu extends StatelessWidget {
  static const id = 'LanguageMenu';

  final SoccerRun game;

  const LanguageMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return ChangeNotifierProvider.value(
      value: game.settings,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              color: Colors.black.withAlpha(200),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 30.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomGameButton(
                          width: 40.h,
                          height: 40.h,
                          onTap: () {
                            game.overlays.remove(LanguageMenu.id);
                            game.overlays.add(SettingsMenu.id);
                          },
                          icon: Icons.arrow_back_ios_rounded,
                          iconColor: Colors.white,
                          iconSize: 9.sp,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        CustomText(
                          text: 'change_language'.tr,
                          textColor: Colors.deepOrange,
                          size: 10.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(() => ListTile(
                          onTap: () {
                            languageController.changeLanguage("en", "US");
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/usa.webp",
                                    width: 10.w,
                                    height: 10.w,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    text: "English",
                                    textColor: Colors.deepOrange,
                                    size: 8.sp,
                                  )
                                ],
                              ),
                              Icon(
                                languageController.lang.value ==
                                        Language.en.name
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: languageController.lang.value ==
                                        Language.en.name
                                    ? Colors.deepOrange
                                    : AppTheme.grey,
                                size: 10.sp,
                              ),
                            ],
                          ),
                        )),
                    Obx(() => ListTile(
                          onTap: () {
                            languageController.changeLanguage("zh", "CN");
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/china.webp",
                                    width: 10.w,
                                    height: 10.w,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    text: "中文",
                                    textColor: Colors.deepOrange,
                                    size: 8.sp,
                                  )
                                ],
                              ),
                              Icon(
                                languageController.lang.value ==
                                        Language.zh.name
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: languageController.lang.value ==
                                        Language.zh.name
                                    ? Colors.deepOrange
                                    : AppTheme.grey,
                                size: 10.sp,
                              ),
                            ],
                          ),
                        )),
                    Obx(
                      () => ListTile(
                        onTap: () {
                          languageController.changeLanguage("vi", "VN");
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/vietnam.webp",
                                  width: 10.w,
                                  height: 10.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: "Tiếng Việt",
                                  textColor: Colors.deepOrange,
                                  size: 8.sp,
                                )
                              ],
                            ),
                            Icon(
                              languageController.lang.value == Language.vi.name
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              color: languageController.lang.value ==
                                      Language.vi.name
                                  ? Colors.deepOrange
                                  : AppTheme.grey,
                              size: 10.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
