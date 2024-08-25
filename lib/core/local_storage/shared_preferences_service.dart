import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  final _getValueMap = <Type, Function>{
    String: (SharedPreferences prefs, String key) => prefs.getString(key),
    bool: (SharedPreferences prefs, String key) => prefs.getBool(key),
    List<String>: (SharedPreferences prefs, String key) =>
        prefs.getStringList(key),
    // Add other data types as needed
  };

  final _setValueMap = <Type, Function>{
    String: (SharedPreferences prefs, String key, String value) =>
        prefs.setString(key, value),
    bool: (SharedPreferences prefs, String key, bool value) =>
        prefs.setBool(key, value),
    List<String>: (SharedPreferences prefs, String key, List<String> value) =>
        prefs.setStringList(key, value),
    // Add other data types as needed
  };

  T getValue<T>(String key, T defaultValue) {
    final getValueFunction = _getValueMap[T];
    if (getValueFunction != null) {
      return getValueFunction(_prefs, key) ?? defaultValue;
    }
    throw ArgumentError('Unsupported type: $T');
  }

  Future<void> setValue<T>(String key, T value) async {
    final setValueFunction = _setValueMap[T];
    if (setValueFunction != null) {
      await setValueFunction(_prefs, key, value);
      return;
    }
    throw ArgumentError('Unsupported type: $T');
  }
}
