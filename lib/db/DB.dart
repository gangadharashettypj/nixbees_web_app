/*
 * @Author GS
 */
import 'dart:io';

import 'package:hive/hive.dart';

class DB {
  static DB _instance;
  static Box _box;
  static DB get instance {
    _instance ??= DB();
    if (_box == null) {
      var path = Directory.systemTemp.path;
      Hive.init(path);
      Hive.openBox('default').then((value) {
        _box = value;
      });
    }
    return _instance;
  }

  dynamic get(DBKeys key) {
    return _box.containsKey(key.toString()) ? _box.get(key.toString()) : null;
  }

  void store(DBKeys key, dynamic value) {
    _box.put(key.toString(), value);
  }

  void remove(DBKeys key) {
    _box.delete(key.toString());
  }

  bool containsKey(DBKeys key) {
    return _box.containsKey(key.toString());
  }

  dynamic getData(String key) {
    return _box.containsKey(key.toString()) ? _box.get(key.toString()) : null;
  }

  void storeData(String key, dynamic value) {
    _box.put(key.toString(), value);
  }

  void removeData(String key) {
    _box.delete(key.toString());
  }

  bool containsKeyData(String key) {
    return _box.containsKey(key.toString());
  }
}

enum DBKeys {
  credential,
}
