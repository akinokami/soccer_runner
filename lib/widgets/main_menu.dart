import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soccer_run/screens/widget/custom_game_button.dart';
import 'package:soccer_run/screens/widget/custom_text.dart';

import '/widgets/hud.dart';
import '../game/soccer_run.dart';
import '/widgets/settings_menu.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';

  final SoccerRun game;

  const MainMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          color: Colors.black.withAlpha(200),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 80.w),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Image.asset(
                    'assets/images/bg.webp',
                    height: 60.h,
                  ),
                  CustomText(
                    text: 'Soccer Run',
                    textColor: Colors.deepOrange,
                    size: 12.sp,
                  ),
                  CustomGameButton(
                    width: 100.w,
                    height: 50.h,
                    onTap: () {
                      game.startGamePlay();
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(Hud.id);
                    },
                    text: 'play'.tr,
                    fontSize: 10.sp,
                    textColor: Colors.white,
                  ),
                  CustomGameButton(
                    width: 100.w,
                    height: 50.h,
                    onTap: () {
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(SettingsMenu.id);
                    },
                    text: 'settings'.tr,
                    fontSize: 10.sp,
                    textColor: Colors.white,
                  ),
                  CustomGameButton(
                    width: 100.w,
                    height: 50.h,
                    onTap: () {
                      exit(0);
                    },
                    text: 'exit'.tr,
                    fontSize: 10.sp,
                    textColor: Colors.white,
                    color1: Colors.red,
                    color2: Colors.red.shade300,
                    color3: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
