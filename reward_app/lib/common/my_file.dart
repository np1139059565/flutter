import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'my_log.dart';

class MyFile {
  static String _PARENT_PATH = '';

  void init({Function()? callback}) {
    _getAbsolutePath().then((value) {
      MyLog.inf("init my file $value..");
      _PARENT_PATH = value;
      if (callback != null) {
        callback();
      }
    });
  }

  Future<String> _getAbsolutePath({String? path = ''}) async {
    return '${(await getApplicationDocumentsDirectory()).path}${path!=''?'/$path':''}';
  }

  String getAbsolutePathAsync({String? path = ''}) {
    if (_PARENT_PATH == '') {
      MyLog.err(Exception('my file is not init!'));
    }
    return '$_PARENT_PATH${path!=''?'/$path':''}';
  }

  String readAsStringSync(String path) {
    return File(getAbsolutePathAsync(path: path)).readAsStringSync();
  }

  Iterable<String> listSync({String? path = ''}) {
    final dir=Directory(
      getAbsolutePathAsync(path: path),
    );
    return dir.existsSync()?dir.listSync().map((d) => d.path):Iterable.empty();
  }

  void createSync(String path) {
    File(getAbsolutePathAsync(path: path)).createSync();
  }
}
