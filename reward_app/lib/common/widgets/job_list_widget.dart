import 'package:flutter/material.dart';

import '../def_style.dart';
import '../../job_detail_page.dart';
import '../utils/my_service_utils.dart';
import '../utils/my_log_utils.dart';

class JobListWidget extends StatefulWidget {
  const JobListWidget({super.key});

  @override
  State<JobListWidget> createState() => _JobListWidgetState();
}

class _JobListWidgetState extends State<JobListWidget> {
  static String JOB_LIST_ERR = "###err###";
  static String JOB_LIST_END = "###end###";

  final jobList = <dynamic>[JOB_LIST_END];
  // int  = 8;
  // int jobPage = 1;
  // int jobMaxPage = 1;
  // String _searchText = '';
  final Map<String, String> _defParams = {
    'jobPage':'1',
    'jobMaxPage':'1',
    'jobPageSize':'8',
    'search':'',
  };

  @override
  void initState() {
    // SharedPreferences? prefs;

    // prefs = await SharedPreferences.getInstance();
    // prefs.setStringList("jobList",List());
    MyLogUtils.inf("initState...");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (c, i) {
        return Container(
          color: DISABLED_COLOR,
          height: 0.1,
        );
      },
      padding: EdgeInsets.only(top: 0),
      itemCount: jobList.length,
      itemBuilder: (BuildContext c, int i) {
        //如果到了表尾
        if (jobList[i] == JOB_LIST_END) {
          //不到最后一页,继续获取数据
          bool nextSuccess = nextPage();
          if (nextSuccess) {
            //加载时显示loading
            return Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            );
          } else {
            //已经到最后一页,显示结束
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                "没有更多了",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        } else if (jobList[i] == JOB_LIST_ERR) {
          //服务端异常
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              "服务端异常!",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }
        return JobLineWidget(
          jobInfo: jobList[i],
        );
      },
    );
  }

  @override //下文会详细介绍。
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    setState(() {
      _defParams.addAll(JobListSearch.of(context)!.params);
      _defParams['jobPage'] = '1';
      _defParams['jobMaxPage'] = '1';
      jobList.clear();
      jobList.add(JOB_LIST_END);
    });
    print("Dependencies change");
  }

  bool nextPage() {
    if (int.parse(_defParams['jobPage']!) <=int.parse(_defParams['jobMaxPage']!)) {
      MyServiceUtils.getAsync(JobListSearch.of(context)!.uri, (e, d) {
        if (e != null) {
          setState(
            () {
              jobList.clear();
              jobList.add(JOB_LIST_ERR);
            },
          );
          return MyLogUtils.err(e);
        }

        _defParams['jobPage'] = (int.parse(_defParams['jobPage']!)+1).toString();
        _defParams['jobMaxPage'] = d["maxPage"];
        dynamic newLine = d["data"];
        MyLogUtils.inf('job list ${_defParams['jobPage']} ${_defParams['jobMaxPage']}');
        if (mounted) {
          setState(
            () {
              if (newLine.length > 0) {
                jobList.insertAll(jobList.length - 1, newLine);
              }
            },
          );
        }
      }, queryParameters: _defParams);
      return true;
    } else
      return false;
  }
}

class JobLineWidget extends StatelessWidget {
  const JobLineWidget({
    Key? key,
    required this.jobInfo,
  });

  final jobInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        constraints: BoxConstraints.tightFor(height: 80), //卡片大小
        // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: DISABLED_COLOR))),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 6,
              child: Image.network(
                "${MyServiceUtils.parentUrl}/images/title.png",
                width: 80,
                color: DEF_COLOR,
              ),
            ),
            Expanded(
              flex: 18,
              child: Container(
                padding: EdgeInsets.only(bottom: 5, top: 5, right: 10),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            flex: 9,
                            child: Text(
                              jobInfo["title"],
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: TITLE_SIZE,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Text(""),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Text(
                              jobInfo["job_type"],
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text.rich(
                              textScaleFactor: 1.4,
                              TextSpan(
                                children: [
                                  TextSpan(text: "￥"),
                                  TextSpan(
                                    text: jobInfo["money"].toString(),
                                  )
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
                              "${jobInfo["success_count"]}人已赚|剩余${jobInfo["total_count"] - jobInfo["success_count"]}",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: DISABLED_COLOR),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "支持设备:${jobInfo["system_type"]}",
                              textAlign: TextAlign.right,
                              style: TextStyle(color: DISABLED_COLOR),
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return JobDetailPage(jobInfo: jobInfo);
            },
          ),
        );
      },
    );
  }
}

class JobListSearch extends InheritedWidget {
  JobListSearch(
      {Key? key,
      required this.uri,
      required this.params,
      required Widget child})
      : super(key: key, child: child);
  final uri;
  final Map<String, String> params;
  //定义一个便捷方法，方便子树中的widget获取共享数据
  static JobListSearch? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<JobListSearch>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(JobListSearch old) {
    // return old.params.values.any((v1) => params.values.any((v2) => v1 != v2));
    // return old.params.values.where((v) => v != '1').length == 0;
    return old.params.values
        .every((v1) => params.values.every((v2) => v1 != v2));
  }
}
