import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:soccer_run/game/soccer_run.dart';
import 'package:soccer_run/widgets/hud.dart';
import 'package:soccer_run/widgets/language_menu.dart';

import '../widgets/game_over_menu.dart';
import '../widgets/main_menu.dart';
import '../widgets/pause_menu.dart';
import '../widgets/settings_menu.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String f = '';
  int selectedGame = 4;

  @override
  void initState() {
    super.initState();

    // f = LocalStorage.instance.read(first) ?? '';

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   try {
    //     if (f == '') {
    //       if (context.mounted) {
    //         showDialog(
    //           context: context,
    //           barrierDismissible: false,
    //           builder: (ctx) => Builder(builder: (context) {
    //             return StatefulBuilder(
    //               builder: (context, StateSetter setState) {
    //                 return AlertDialog(
    //                   content: Column(
    //                     children: [
    //                       SingleChildScrollView(
    //                         child: SizedBox(
    //                             height: 1.sh * 0.53,
    //                             width: 1.sw,
    //                             child: WebViewWidget(
    //                                 controller: WebViewController()
    //                                   ..loadHtmlString(
    //                                       Global.language == Language.vi.name
    //                                           ? Global.policyHtmlVi
    //                                           : Global.policyHtmlEn))),
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           Checkbox(
    //                             shape: RoundedRectangleBorder(
    //                                 borderRadius: BorderRadius.circular(6)),
    //                             activeColor: Colors.deepOrange,
    //                             side: BorderSide(
    //                               width: 1.5,
    //                               color: isChecked
    //                                   ? Colors.deepOrange
    //                                   : Colors.black,
    //                             ),
    //                             value: isChecked,
    //                             onChanged: (bool? value) {
    //                               setState(() {
    //                                 isChecked = value!;
    //                                 if (isChecked) {
    //                                   isAccepted = true;
    //                                 } else {
    //                                   isAccepted = false;
    //                                 }
    //                               });
    //                             },
    //                           ),
    //                           CustomText(
    //                             text: 'agree'.tr,
    //                             size: 12,
    //                           ),
    //                         ],
    //                       ),
    //                       // CustomGameButton(
    //                       //   onTap: isAccepted
    //                       //       ? () async {
    //                       //           LocalStorage.instance
    //                       //               .write(first, 'notfirst');
    //                       //           Navigator.pop(context);
    //                       //         }
    //                       //       : null,
    //                       //   text: 'accept'.tr,
    //                       //   fontSize: 12,
    //                       // ),
    //                       SizedBox(
    //                         height: 35.h,
    //                         child: ElevatedButton(
    //                           style: ButtonStyle(
    //                               backgroundColor:
    //                                   MaterialStateColor.resolveWith((states) =>
    //                                       isAccepted
    //                                           ? Colors.deepOrange
    //                                           : AppTheme.greyTicket)),
    //                           // ignore: sort_child_properties_last
    //                           child: CustomText(
    //                             text: 'accept'.tr,
    //                             size: 8,
    //                           ),
    //                           onPressed: isAccepted
    //                               ? () async {
    //                                   LocalStorage.instance
    //                                       .write(first, 'notfirst');
    //                                   Navigator.pop(context);
    //                                 }
    //                               : null,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               },
    //             );
    //           }),
    //         );
    //       }
    //     }
    //   } catch (e) {
    //     // print("Error fetching SharedPreferences: $e");
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<SoccerRun>.controlled(
        loadingBuilder: (conetxt) => Container(
          alignment: Alignment.center,
          color: Colors.white,
        ),
        overlayBuilderMap: {
          MainMenu.id: (_, game) => MainMenu(game),
          PauseMenu.id: (_, game) => PauseMenu(game),
          Hud.id: (_, game) => Hud(game),
          GameOverMenu.id: (_, game) => GameOverMenu(game),
          SettingsMenu.id: (_, game) => SettingsMenu(game),
          LanguageMenu.id: (_, game) => LanguageMenu(game),
        },
        initialActiveOverlays: const [MainMenu.id],
        gameFactory: () => SoccerRun(
          camera: CameraComponent.withFixedResolution(
            width: 360,
            height: 180,
          ),
        ),
      ),
    );
  }
}
