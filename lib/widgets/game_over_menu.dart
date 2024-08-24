import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soccer_run/screens/widget/custom_game_button.dart';

import '../screens/widget/custom_text.dart';
import '/widgets/hud.dart';
import '../game/soccer_run.dart';
import '/widgets/main_menu.dart';
import '/models/player_data.dart';
import '/game/audio_manager.dart';

class GameOverMenu extends StatelessWidget {
  static const id = 'GameOverMenu';

  final SoccerRun game;

  const GameOverMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: game.playerData,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
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
                    CustomText(
                      text: 'game_over'.tr,
                      textColor: Colors.deepOrange,
                      size: 12.sp,
                    ),
                    Selector<PlayerData, int>(
                      selector: (_, playerData) => playerData.currentScore,
                      builder: (_, score, __) {
                        return CustomText(
                          text: "${'score'.tr}: $score",
                          textColor: Colors.deepOrange,
                          size: 10.sp,
                        );
                      },
                    ),

                    CustomGameButton(
                      width: 100.w,
                      height: 50.h,
                      onTap: () {
                        game.overlays.remove(GameOverMenu.id);
                        game.overlays.add(Hud.id);
                        game.resumeEngine();
                        game.reset();
                        game.startGamePlay();
                        AudioManager.instance.resumeBgm();
                      },
                      text: 'restart'.tr,
                      fontSize: 10.sp,
                      textColor: Colors.white,
                    ),
                    CustomGameButton(
                      width: 100.w,
                      height: 50.h,
                      onTap: () {
                        game.overlays.remove(GameOverMenu.id);
                        game.overlays.add(MainMenu.id);
                        game.resumeEngine();
                        game.reset();
                        AudioManager.instance.resumeBgm();
                      },
                      text: 'main_menu'.tr,
                      fontSize: 10.sp,
                      textColor: Colors.white,
                    ),
                    // ElevatedButton(
                    //   child: const Text(
                    //     'Restart',
                    //     style: TextStyle(
                    //       fontSize: 30,
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     game.overlays.remove(GameOverMenu.id);
                    //     game.overlays.add(Hud.id);
                    //     game.resumeEngine();
                    //     game.reset();
                    //     game.startGamePlay();
                    //     AudioManager.instance.resumeBgm();
                    //   },
                    // ),
                    // ElevatedButton(
                    //   child: const Text(
                    //     'Exit',
                    //     style: TextStyle(
                    //       fontSize: 30,
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     game.overlays.remove(GameOverMenu.id);
                    //     game.overlays.add(MainMenu.id);
                    //     game.resumeEngine();
                    //     game.reset();
                    //     AudioManager.instance.resumeBgm();
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
