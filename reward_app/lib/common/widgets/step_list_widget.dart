import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../def_style.dart';
import '../utils/my_service_utils.dart';
import '../utils/my_log_utils.dart';

class StepListWidget extends StatefulWidget {
  const StepListWidget(
      {super.key,
      required this.title,
      required this.titleTip,
      required this.jobInfo});
  final title;
  final titleTip;
  final jobInfo;

  @override
  State<StepListWidget> createState() => _StepListWidgetState();
}

class _StepListWidgetState extends State<StepListWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> columnChildrenArr = [
      Row(
        children: [
          Text.rich(
            style: TextStyle(
              fontSize: TITLE_SIZE,
            ),
            TextSpan(
              text: widget.title,
              children: [
                TextSpan(
                  text: " (${widget.titleTip})",
                  style: TextStyle(
                    color: DISABLED_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
    try {
      final stepArr = json.decode(
        widget.jobInfo["steps"],
      );
      for (var i = 0; i < stepArr.length; i++) {
        columnChildrenArr.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Center(
                  child: Text(
                    "${i + 1}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                width: TITLE_SIZE,
                height: TITLE_SIZE,
                margin: EdgeInsets.only(
                  right: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      TITLE_SIZE,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stepArr[i]["title"],
                    ),
                    getStep(stepArr[i], context: context),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      MyLogUtils.err(e);
    }
    return Column(
      children: columnChildrenArr,
    );
  }

  Widget getStep(stepInfo, {BuildContext? context}) {
    switch (stepInfo["type"]) {
      case "image":
        return Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Image.network(
                "${MyServiceUtils.parentUrl}/images/${stepInfo["value"]}",
                color: DEF_COLOR,
                width: 360,
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text("添加图片"),
                  onPressed: () async {
                    ImagePickers.pickerPaths().then((List medias) {
                      print("aaaaaaaaaaaaaaaaa");
                      print(medias);
                    });
                  },
                ),
              ),
            ),
          ],
        );
      case "copy":
        return ElevatedButton(
          child: Text(
            "复制",
          ),
          onPressed: () {
            Clipboard.setData(
              ClipboardData(
                text: stepInfo["value"],
              ),
            );
            ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(
                content: Text("已复制"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      case "input":
        return TextField(
          decoration: InputDecoration(
            hintText: "请按要求输入内容",
            hintStyle: TextStyle(
              fontSize: DEF_SIZE,
            ),
          ),
        );
      default:
        return stepInfo["value"] ? Text("not find type") : stepInfo["value"];
    }
  }
}
