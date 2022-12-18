import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'common/my_log.dart';
import 'common/def_style.dart';
import 'common/my_service.dart';
import 'common/my_file.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  final USER_DIR = 'users';

  static dynamic getAppBar() {
    return AppBar(
      title: Center(
        child: Text(
          "个人中心",
        ),
      ),
    );
  }

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String _this_user = '';
  bool checkLogin() {
    final users = MyFile.list(path: widget.USER_DIR);
    MyLog.inf('check login $users..');
    if (users.length > 0) {
      setState(() {
        _this_user = users.first.split('/').last;
      });
    }
    return users.length > 0;
  }

  void login(uid, user, pwd) {
    MyService.getAsync(MyService.sessionUri, (e, session) {
      if (session == null) {
        MyLog.inf('not find session..');
        return;
      }
      final encode =
          md5.convert(new Utf8Encoder().convert('$uid:$user:$pwd:$session'));
      MyService.getAsync(
        MyService.loginUri,
        (e, body) {
          MyLog.inf('$uid:$user:$pwd:$session>$encode');
          if (body != null) {
            MyLog.inf('$user login is success');
            MyFile.createDir('${widget.USER_DIR}/$user');
            setState(() {
              _this_user = user;
            });
          }
        },
        queryParameters: {
          'uid': uid,
          'key': encode,
        },
      );
    });
  }

  @override
  void initState() {
    MyFile.initAsync(callback: checkLogin);
  }

  @override
  Widget build(BuildContext c) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(
                  10,
                ),
                color: DEF_COLOR,
                child: ElevatedButton.icon(
                  icon: Container(
                    width: 80,
                    height: 80,
                    child: _this_user.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 80,
                            color: DISABLED_COLOR,
                          )
                        : null,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      image: _this_user.isEmpty
                          ? null
                          : DecorationImage(
                              image: NetworkImage(
                                "${MyService.parentUrl}/images/title.png",
                                // color: Colors.blue,
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  label: Text(
                    _this_user.isEmpty ? "点击登录" : _this_user,
                    style: TextStyle(
                      fontSize: TITLE_SIZE * 1.2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                  ),
                  onPressed: () {
                    if (_this_user.isEmpty) {
                      login(1, 'admin', '0192023a7bbd73250516f069df18b500');
                    } else {
                      setState(() {
                        _this_user = '';
                      });
                      MyFile.deleteDir('${widget.USER_DIR}/$_this_user');
                    }
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    overlayColor: MaterialStateProperty.all(DEF_COLOR),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(
                  10,
                ),
                color: BACK_COLOR,
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "收入余额",
                                    style: TextStyle(color: DISABLED_COLOR),
                                  ),
                                  Text("￥0.0"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton(
                                        child: Text("账单"),
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: DEF_COLOR),
                                        ),
                                        onPressed: () {},
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: OutlinedButton(
                                          child: Text("提现"),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(color: DEF_COLOR),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: BACK_COLOR,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "收入余额",
                                      style: TextStyle(color: DISABLED_COLOR),
                                    ),
                                    Text("￥0.0"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        OutlinedButton(
                                          child: Text("账单"),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(color: DEF_COLOR),
                                          ),
                                          onPressed: () {},
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: OutlinedButton(
                                            child: Text("提现"),
                                            style: OutlinedButton.styleFrom(
                                              side:
                                                  BorderSide(color: DEF_COLOR),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 100,
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    child: Icon(
                                      Icons.border_color,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "我的发布",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 100,
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    child: Icon(
                                      Icons.assignment_turned_in,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "我的接单",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 100,
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    child: Icon(
                                      Icons.card_membership,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "开通会员",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
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
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: ElevatedButton.icon(
                                    icon: Container(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.announcement,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    label: Text(
                                      "我的消息",
                                      style: TextStyle(
                                        fontSize: TITLE_SIZE,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 4,
                                    ),
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      elevation: MaterialStateProperty.all(0),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: ElevatedButton.icon(
                                    icon: Container(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.people_outline,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    label: Text(
                                      "我的粉丝",
                                      style: TextStyle(
                                        fontSize: TITLE_SIZE,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 4,
                                    ),
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      elevation: MaterialStateProperty.all(0),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: ElevatedButton.icon(
                                    icon: Container(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.call,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    label: Text(
                                      "联系客服",
                                      style: TextStyle(
                                        fontSize: TITLE_SIZE,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 4,
                                    ),
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      elevation: MaterialStateProperty.all(0),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: ElevatedButton.icon(
                                    icon: Container(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.home,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    label: Text(
                                      "小黑屋",
                                      style: TextStyle(
                                        fontSize: TITLE_SIZE,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 4,
                                    ),
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      elevation: MaterialStateProperty.all(0),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: ElevatedButton.icon(
                                    icon: Container(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.settings,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    label: Text(
                                      "系统设置",
                                      style: TextStyle(
                                        fontSize: TITLE_SIZE,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 4,
                                    ),
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      elevation: MaterialStateProperty.all(0),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          "商务合作",
                          style: TextStyle(fontSize: TITLE_SIZE * 1.2),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          "工作时间: [工作日:08:40~18:00]",
                          style: TextStyle(color: DISABLED_COLOR),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 80),
                      child: Center(
                        child: Text(
                          "用户协议",
                          style: TextStyle(
                            color: DEF_COLOR,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          "隐私政策",
                          style: TextStyle(
                              color: DEF_COLOR,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
