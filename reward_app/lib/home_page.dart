import 'package:flutter/material.dart';

import 'common/def_style.dart';
import 'search_page.dart';
import 'job_list_page.dart';
import 'common/my_log.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static dynamic getAppBar() {
    return null;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SEARCH_RIGHT_WIDTH_MAX =
      "                                                                                                                                                  ";
  final SEARCH_HINT_TEXT = "任务标题";

  String _searchText = '';

  @override
  Widget build(BuildContext c) => DefaultTextStyle.merge(
        style: TextStyle(
          fontSize: DEF_SIZE,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 10,
                  bottom: 10,
                  right: 10,
                ),
                color: DEF_COLOR,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.search),
                  label: Text(
                    "${_searchText == "" ? SEARCH_HINT_TEXT : _searchText}${SEARCH_RIGHT_WIDTH_MAX}",
                    style: TextStyle(
                      fontSize: TITLE_SIZE,
                    ),
                  ),
                  onPressed: () async {
                    var inputStr = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SearchPage(
                            defSearchText: _searchText,
                            hintText: SEARCH_HINT_TEXT,
                          );
                        },
                      ),
                    );
                    MyLog.inf("search text:$inputStr");
                    if (inputStr != null) {
                      setState(
                        () {
                          _searchText = inputStr;
                        },
                      );
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      StadiumBorder(),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return DISABLED_COLOR;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 13,
              child: Container(
                color: Colors.white,
                child: JobListSearch(
                  searchText: _searchText,
                  child: JobListPage(),
                ),
              ),
            ),
          ],
        ),
      );
}
