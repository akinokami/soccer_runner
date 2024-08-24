import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soccer_run/controller/language_controller.dart';
import 'package:soccer_run/widgets/language_menu.dart';

import '../game/soccer_run.dart';
import '../screens/widget/custom_game_button.dart';
import '../screens/widget/custom_text.dart';
import '../utils/constants.dart';
import '/models/settings.dart';
import '/widgets/main_menu.dart';
import '/game/audio_manager.dart';

class SettingsMenu extends StatelessWidget {
  static const id = 'SettingsMenu';

  final SoccerRun game;

  const SettingsMenu(this.game, {super.key});

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
                    // TextButton(
                    //   onPressed: () {
                    //     game.overlays.remove(SettingsMenu.id);
                    //     game.overlays.add(MainMenu.id);
                    //   },
                    //   child: const Icon(Icons.arrow_back_ios_rounded),
                    // ),
                    Row(
                      children: [
                        CustomGameButton(
                          width: 40.h,
                          height: 40.h,
                          onTap: () {
                            game.overlays.remove(SettingsMenu.id);
                            game.overlays.add(MainMenu.id);
                          },
                          icon: Icons.arrow_back_ios_rounded,
                          iconColor: Colors.white,
                          iconSize: 10.sp,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        CustomText(
                          text: 'settings'.tr,
                          textColor: Colors.deepOrange,
                          size: 10.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Selector<Settings, bool>(
                      selector: (_, settings) => settings.bgm,
                      builder: (context, bgm, __) {
                        return SwitchListTile(
                          activeColor: Colors.deepOrange,
                          inactiveTrackColor: Colors.grey,
                          title: Row(
                            children: [
                              const Icon(
                                Icons.music_note,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              CustomText(
                                text: 'sound'.tr,
                                textColor: Colors.deepOrange,
                                size: 8.sp,
                              ),
                            ],
                          ),
                          value: bgm,
                          onChanged: (bool value) {
                            Provider.of<Settings>(context, listen: false).bgm =
                                value;
                            if (value) {
                              AudioManager.instance
                                  .startBgm('8BitPlatformerLoop.wav');
                            } else {
                              AudioManager.instance.stopBgm();
                            }
                          },
                        );
                      },
                    ),
                    ListTile(
                      onTap: () {
                        game.overlays.remove(SettingsMenu.id);
                        game.overlays.add(LanguageMenu.id);
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.language,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              CustomText(
                                text: 'change_language'.tr,
                                textColor: Colors.deepOrange,
                                size: 8.sp,
                              ),
                            ],
                          ),
                          CustomText(
                            text: languageController.lang.value ==
                                    Language.en.name
                                ? 'english'.tr
                                : 'vietnam'.tr,
                            textColor: Colors.deepOrange,
                            size: 7.sp,
                          ),
                        ],
                      ),
                    )
                    // Selector<Settings, bool>(
                    //   selector: (_, settings) => settings.sfx,
                    //   builder: (context, sfx, __) {
                    //     return SwitchListTile(
                    //       title: const Text(
                    //         'Effects',
                    //         style: TextStyle(
                    //           fontSize: 30,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       value: sfx,
                    //       onChanged: (bool value) {
                    //         Provider.of<Settings>(context, listen: false).sfx =
                    //             value;
                    //       },
                    //     );
                    //   },
                    // ),
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
