import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soccer_run/language/languages.dart';
import 'package:soccer_run/screens/splash_screen.dart';
import 'package:soccer_run/services/local_storage.dart';
import 'package:soccer_run/utils/constants.dart';
import 'package:soccer_run/utils/global.dart';

import 'models/settings.dart';
import 'models/player_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await initHive();
  runApp(const MyApp());
}

Future<void> initHive() async {
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Global.language = LocalStorage.instance.read(language) ?? Language.zh.name;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Soccer Run',
          theme: ThemeData(
            // fontFamily: 'Audiowide',
            primarySwatch: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                // padding: const EdgeInsets.symmetric(vertical: 10.0),
                fixedSize: const Size(200, 60),
              ),
            ),
          ),
          translations: Languages(),
          locale: Global.language == Language.zh.name
              ? const Locale('zh', 'CN')
              : Global.language == Language.vi.name
                  ? const Locale('vi', 'VN')
                  : const Locale('en', 'US'),
          fallbackLocale: const Locale('zh', 'CN'),
          home: const SplashScreen(),
        );
      },
    );
  }
}
