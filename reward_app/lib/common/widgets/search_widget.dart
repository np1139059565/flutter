import 'package:flutter/material.dart';

import '../def_style.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget(
      {super.key, required this.searchText, required this.hintText});

  final String searchText;
  final String hintText;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: TextEditingController.fromValue(TextEditingValue(
              text: widget.searchText,
              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: widget.searchText.length)))),
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 25,
              color: DISABLED_COLOR,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 25, minWidth: 40),
            // contentPadding必须设置isDense才生效
            isDense: true,
            // contentPadding:
            //     EdgeInsets.only(top: -7, bottom: 10),
            // fillColor必须设置filled才生效
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: DISABLED_COLOR),
          ),
          textInputAction: TextInputAction.search,
          cursorColor: DEF_COLOR,
          onSubmitted: (v) {
            Navigator.pop(context, v);
          },
        ),
      ),
      body: Center(child: Column()),
    );
  }
}
