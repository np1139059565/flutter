import 'package:flutter/material.dart';

import 'common/def_style.dart';
import 'index_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: DEF_COLOR,
      ),
      home: const IndexPage(),
    );
  }
}
