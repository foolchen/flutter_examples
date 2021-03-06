import 'package:flutter/material.dart';
import 'package:flutter_examples/widget/snack_bar.dart';

void main() => runApp(SnackApp());

class SnackApp extends StatelessWidget {
  GlobalKey<SnackBarWidgetState> _globalKey = GlobalKey();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          appBar: AppBar(
            title: Text("SnackBar"),
            actions: <Widget>[
              InkWell(
                child: Padding(
                  child: Center(
                    child: Text("显示"),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                ),
                onTap: () {
                  _globalKey.currentState
                      .showSnackBar("这是SnackBar count: ${count++}");
                },
              ),
              Padding(
                child: InkWell(
                  child: Padding(
                    child: Center(
                      child: Text("隐藏"),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                  ),
                  onTap: () {
                    _globalKey.currentState.dismiss();
                  },
                ),
                padding: EdgeInsets.only(right: 10),
              )
            ],
          ),
          body: SnackBarWidget(
              key: _globalKey,
              textBuilder: (String message) {
                return Text(message ?? "");
              },
              content: Text("这是内容部分")),
        ));
  }
}
