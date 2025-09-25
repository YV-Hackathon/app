import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class StorageService {
  Future<void> init();
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> setDouble(String key, double value);
  Future<double?> getDouble(String key);
  Future<void> setStringList(String key, List<String> value);
  Future<List<String>?> getStringList(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}

class SharedPreferencesStorageService implements StorageService {
  SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs?.getString(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _prefs?.getInt(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs?.getBool(key);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  @override
  Future<double?> getDouble(String key) async {
    return _prefs?.getDouble(key);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    return _prefs?.getStringList(key);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs?.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _prefs?.containsKey(key) ?? false;
  }
}

class HiveStorageService implements StorageService {
  static const String _boxName = 'app_storage';

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  Box get _box => Hive.box(_boxName);

  @override
  Future<void> setString(String key, String value) async {
    await _box.put(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _box.get(key) as String?;
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _box.put(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _box.get(key) as int?;
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _box.put(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _box.get(key) as bool?;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _box.put(key, value);
  }

  @override
  Future<double?> getDouble(String key) async {
    return _box.get(key) as double?;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _box.put(key, value);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    return _box.get(key) as List<String>?;
  }

  @override
  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _box.containsKey(key);
  }
}
