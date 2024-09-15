import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:soccer_run/language/en_language.dart';
import 'package:soccer_run/language/vi_language.dart';
import 'package:soccer_run/language/zh_language.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': ZhLanguage().zhLanguage,
        'en_US': EnLanguage().enLanguage,
        'vi_VN': ViLanguage().viLanguage,
      };
}
