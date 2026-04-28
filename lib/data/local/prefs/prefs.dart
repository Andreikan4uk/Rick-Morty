import 'package:rick_and_morty/data/local/prefs/i_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsProvider implements IPrefsDataSource {
  static const _isDarkKey = 'isDark';

  @override
  Future<bool> getIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkKey) ?? false;
  }

  @override
  Future<void> saveIsDark(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkKey, isDark);
  }
}
