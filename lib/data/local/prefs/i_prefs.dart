abstract class IPrefsDataSource {
  Future<bool> getIsDark();
  Future<void> saveIsDark(bool isDark);
}
