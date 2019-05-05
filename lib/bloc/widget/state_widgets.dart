import 'package:flutter/material.dart';
import 'package:flutter_examples/bloc/bloc_states.dart';

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            child: CircularProgressIndicator(), width: 40, height: 40));
  }
}

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("暂无数据"));
  }
}

class FailureWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  FailureWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(child: Text("加载失败，点击重试"), onTap: this.onTap));
  }
}

class BottomLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Center(
          child: SizedBox(
              width: 30, height: 30, child: CircularProgressIndicator())),
    );
  }
}

class BottomFailureWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  BottomFailureWidget({this.onTap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45,
        child: GestureDetector(
          child: Center(
              child: Text(
            "加载失败，点击重试",
          )),
          onTap: this.onTap,
        ));
  }
}

class BottomFinalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 45, child: Center(child: Text("没有了")));
  }
}

/// 根据状态返回需要的Widget
Widget ofWidget(BuildContext context, BlocState state,
    {@required ContentBuilder defaultBuilder, GestureTapCallback retryTap}) {
  if (state is Uninitialized)
    return LoaderWidget();
  else if (state is Error && state.data == null)
    return FailureWidget(onTap: retryTap);
  else if (state is Empty)
    return EmptyWidget();
  else
    return defaultBuilder(context, state);
}

Widget ofBottomWidget(BuildContext context, BlocState state,
    {ContentBuilder defaultBuilder, GestureTapCallback retryTap}) {
  if (state is BottomRefreshing || state is Success)
    return BottomLoaderWidget();
  else if (state is BottomError)
    return BottomFailureWidget(onTap: retryTap);
  else if (state is BottomSuccess)
    return state.isFinal ? BottomFinalWidget() : BottomLoaderWidget();
  else if (defaultBuilder != null) {
    return defaultBuilder(context, state);
  } else {
    return Container();
  }
}

typedef ContentBuilder = Widget Function(BuildContext context, BlocState state);
