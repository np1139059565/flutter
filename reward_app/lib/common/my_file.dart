import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'my_log.dart';

class MyFile {
  static String _PARENT_PATH = '';

  static void initAsync({Function()? callback}) {
    _getAbsolutePathAsync().then((value) {
      MyLog.inf("init my file $value..");
      _PARENT_PATH = value;
      if (callback != null) {
        callback();
      }
    });
  }

  static Future<String> _getAbsolutePathAsync({String? path = ''}) async {
    return '${(await getApplicationDocumentsDirectory()).path}${path != '' ? '/$path' : ''}';
  }

  static String getAbsolutePath({String? path = ''}) {
    if (_PARENT_PATH == '') {
      MyLog.err(Exception('my file is not init!'));
    }
    return '$_PARENT_PATH${path != '' ? '/$path' : ''}';
  }

  static File getFile({String? path = '', bool? checkExists = true}) {
    final file = File(getAbsolutePath(path: path));
    if (checkExists! && file.existsSync() != true) {
      MyLog.err(Exception('file ${file.path} is not find!'));
    }
    return file;
  }

  static Directory getDir({String? path = '', bool? checkExists = true}) {
    final dir = Directory(getAbsolutePath(path: path));
    if (checkExists! && dir.existsSync() != true) {
      MyLog.err(Exception('dir ${dir.path} is not find!'));
    }
    return dir;
  }

  static String readAsString(String path) {
    final file = getFile(path: path);
    return file.existsSync() ? file.readAsStringSync() : '';
  }

  static Iterable<String> list({String? path = ''}) {
    final dir = getDir(path: path);
    return dir.existsSync()
        ? dir.listSync().map((d) => d.path)
        : Iterable.empty();
  }

  static void createFile(String path) =>
      getFile(path: path, checkExists: false).createSync();

  static void createDir(String path) =>
      getDir(path: path, checkExists: false).createSync();
}
