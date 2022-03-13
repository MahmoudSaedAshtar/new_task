import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:task/common/constants/storage_keys.dart';

class HiveStorage {
  static HiveStorage? _singleton;
  static Box? _box;
  factory HiveStorage() {
    _singleton = _singleton ?? HiveStorage._internal();
    return _singleton!;
  }

  HiveStorage._internal();
  Directory? securePath;
  Future<void> createHive() async {
    securePath = await path.getApplicationDocumentsDirectory();
    Hive.init(securePath!.path);
    _box = await Hive.openBox(StorageKeys.BOX_NAME);
  }

  putInBox({required String key, required dynamic value}) {
    _box!.put(key, value);
  }

  getFromBox({required String key}) {
    return _box!.get(key, defaultValue: null);
  }

  removeFromBox({required String key}) {
    _box!.delete(key);
  }

  deleteBox() {
    Hive.deleteBoxFromDisk(StorageKeys.BOX_NAME);
  }

  deleteKeys({required List<String> keys}) {
    _box!.deleteAll(keys);
  }
}
