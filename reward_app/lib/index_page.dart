import 'package:flutter/material.dart';

import 'common/def_style.dart';
import 'job_list_page.dart';
import 'user_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int pageIndex = 0;

  Widget? scaffoldBody;
  AppBar? appBar;

  @override
  void initState() {
    super.initState();
    switchPage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: scaffoldBody,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的")
        ],
        currentIndex: pageIndex,
        selectedItemColor: DEF_COLOR,
        unselectedItemColor: DISABLED_COLOR,
        showUnselectedLabels: true,
        onTap: switchPage,
      ),
    );
  }

  void switchPage(int i) {
    setState(() {
      pageIndex = i;
      switch (pageIndex) {
        case 0:
          scaffoldBody = JobListPage();
          appBar = JobListPage.getAppBar();
          break;
        case 1:
          scaffoldBody = UserPage();
          appBar = UserPage.getAppBar();
          break;
      }
    });
  }
}
