import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';
import 'package:soccer_run/screens/widget/custom_game_button.dart';
import 'package:soccer_run/screens/widget/custom_text.dart';

import '../game/soccer_run.dart';
import '/game/audio_manager.dart';
import '/models/player_data.dart';
import '/widgets/pause_menu.dart';

class Hud extends StatelessWidget {
  static const id = 'Hud';

  final SoccerRun game;

  const Hud(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: game.playerData,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Selector<PlayerData, int>(
              selector: (_, playerData) => playerData.highScore,
              builder: (_, highScore, __) {
                return CustomText(
                  text: "${'high_score'.tr}: $highScore",
                  textColor: Colors.deepOrange,
                  fontWeight: FontWeight.w500,
                  size: 10.sp,
                );
              },
            ),
            Selector<PlayerData, int>(
              selector: (_, playerData) => playerData.currentScore,
              builder: (_, score, __) {
                return CustomText(
                  text: "${'score'.tr}: $score",
                  textColor: Colors.deepOrange,
                  fontWeight: FontWeight.w500,
                  size: 10.sp,
                );
              },
            ),
            CustomGameButton(
              width: 40.h,
              height: 40.h,
              onTap: () {
                game.overlays.remove(Hud.id);
                game.overlays.add(PauseMenu.id);
                game.pauseEngine();
                AudioManager.instance.pauseBgm();
              },
              icon: Icons.pause,
              iconColor: Colors.white,
              iconSize: 9.sp,
            ),
            // TextButton(
            //   onPressed: () {
            //     game.overlays.remove(Hud.id);
            //     game.overlays.add(PauseMenu.id);
            //     game.pauseEngine();
            //     AudioManager.instance.pauseBgm();
            //   },
            //   child: const Icon(Icons.pause, color: Colors.white),
            // ),
            // Selector<PlayerData, int>(
            //   selector: (_, playerData) => playerData.lives,
            //   builder: (_, lives, __) {
            //     return Row(
            //       children: List.generate(5, (index) {
            //         if (index < lives) {
            //           return const Icon(
            //             Icons.favorite,
            //             color: Colors.red,
            //           );
            //         } else {
            //           return const Icon(
            //             Icons.favorite_border,
            //             color: Colors.red,
            //           );
            //         }
            //       }),
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
