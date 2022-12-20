import 'package:flutter/material.dart';

import 'common/def_style.dart';
import 'common/utils/my_service_utils.dart';
import 'common/widgets/step_list_widget.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({super.key, required this.jobInfo});
  final jobInfo;

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "任务详情",
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
            Icons.more_horiz,
          ),
          ),
        ],
      ),
      body: DefaultTextStyle.merge(
        style: TextStyle(
          fontSize: DEF_SIZE,
        ),
        child: SingleChildScrollView(
          child: Container(
            color: BACK_COLOR,
            child: Column(
              children: [
                Container(
                  height: 80,
                  color: Colors.white,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          "${MyServiceUtils.parentUrl}/images/title.png",
                          width: 80,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.all(
                            10,
                          ),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Expanded(
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.jobInfo["title"],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: TITLE_SIZE,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text.rich(
                                        textScaleFactor: 1.4,
                                        TextSpan(
                                          children: [
                                            TextSpan(text: "￥"),
                                            TextSpan(
                                              text: widget.jobInfo["money"]
                                                  .toString(),
                                            ),
                                          ],
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: TITLE_SIZE,
                                          ),
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.jobInfo["job_type"],
                                        style: TextStyle(
                                          color: DISABLED_COLOR,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "支持设备:${widget.jobInfo["system_type"]}",
                                        style: TextStyle(
                                          color: DISABLED_COLOR,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  // margin: EdgeInsets.only(right: 10),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: DISABLED_COLOR,
                        ),
                      ),
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: DISABLED_COLOR,
                                ),
                              ),
                            ),
                            child: Flex(
                              direction: Axis.vertical,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${(widget.jobInfo["avg_used_seconds"] / 60).toStringAsFixed(2)}分钟",
                                    style: TextStyle(
                                      fontSize: TITLE_SIZE,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "人均用时",
                                    style: TextStyle(
                                      color: DISABLED_COLOR,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: DISABLED_COLOR,
                                ),
                              ),
                            ),
                            child: Flex(
                              direction: Axis.vertical,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${widget.jobInfo["success_count"]}",
                                    style: TextStyle(
                                      fontSize: TITLE_SIZE,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "完成人数",
                                    style: TextStyle(
                                      color: DISABLED_COLOR,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: DISABLED_COLOR,
                                ),
                              ),
                            ),
                            child: Flex(
                              direction: Axis.vertical,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${(widget.jobInfo["avg_check_seconds"] / 60).toStringAsFixed(2)}分钟",
                                    style: TextStyle(
                                      fontSize: TITLE_SIZE,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "平均审核",
                                    style: TextStyle(
                                      color: DISABLED_COLOR,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Expanded(
                                child: Text(
                                  "${widget.jobInfo["success_ratio"]}%",
                                  style: TextStyle(
                                    fontSize: TITLE_SIZE,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "总通过率",
                                  style: TextStyle(
                                    color: DISABLED_COLOR,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 40,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '''剩余名额:${widget.jobInfo["total_count"] - widget.jobInfo["success_count"]}  做单时间:${(widget.jobInfo["max_used_seconds"] / 60).toStringAsFixed(2)}分钟  审核时间:${(widget.jobInfo["max_check_seconds"] / 60).toStringAsFixed(2)}分钟''',
                        style: TextStyle(
                          color: DISABLED_COLOR,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  constraints: BoxConstraints(
                    minHeight: 40,
                  ),
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "任务说明",
                            style: TextStyle(
                              fontSize: TITLE_SIZE,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.jobInfo["job_tip"],
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  constraints: BoxConstraints(
                    minHeight: 40,
                  ),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: StepListWidget(
                    title: "任务步骤",
                    titleTip: "请参照以下步骤完成做单",
                    jobInfo: widget.jobInfo,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
