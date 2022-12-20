import 'package:flutter/material.dart';

import 'common/def_style.dart';
import 'common/widgets/job_list_widget.dart';
import 'common/utils/my_log_utils.dart';
import 'common/utils/my_service_utils.dart';

class OrderJobPage extends StatefulWidget {
  const OrderJobPage({super.key});

  @override
  State<OrderJobPage> createState() => _OrderJobPageState();
}

class _OrderJobPageState extends State<OrderJobPage> {
  final SEARCH_RIGHT_WIDTH_MAX =
      "                                                                                                                                                  ";
  final SEARCH_HINT_TEXT = "任务标题";

  String _status_index = '-1';

  @override
  Widget build(BuildContext c) {
    final tabs = ['全部', '未提交', '审核中', '已通过', '未通过'];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "我的接单",
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Material(
              color: Colors.white,
              child: TabBar(
                onTap: (i) {
                  setState(() {
                    _status_index = (i-1).toString();
                  });
                },
                isScrollable: true,
                labelColor: DEF_COLOR,
                unselectedLabelColor: Colors.black,
                tabs: tabs
                    .map((t) => Tab(
                          text: t,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: JobListSearch(
                  uri: MyServiceUtils.orderJobListUri,
                  params: {
                    'status': _status_index,
                    'uid': '1',
                  },
                  child: JobListWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
