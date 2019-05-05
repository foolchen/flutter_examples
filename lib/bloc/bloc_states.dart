import 'package:equatable/equatable.dart';
import 'package:flutter_examples/network/network.dart';

abstract class BlocState extends Equatable {
  final dynamic data;
  final bool isFinal;

  BlocState({this.data, this.isFinal, props})
      : super([DateTime.now(), data, isFinal, props]);
}

/// 未初始化，此时应该使用全局加载的方式
class Uninitialized extends BlocState {
  Uninitialized() : super();
}

/// 已经初始化，此时应该使用下拉刷新的方式
class Refreshing extends BlocState {
  Refreshing({dynamic data, bool isFinal})
      : super(data: data, isFinal: isFinal);

  Refreshing.fromState(BlocState oldState)
      : super(data: oldState.data, isFinal: oldState.isFinal);
}

/// 加载成功
class Success extends BlocState {
  Success({dynamic data, bool isFinal}) : super(data: data, isFinal: isFinal);

  Success.fromState({BlocState currentState, dynamic data, bool isFinal})
      : super(
            data: data ?? currentState.data,
            isFinal: isFinal ?? currentState.isFinal);
}

class Empty extends BlocState {}

/// 加载失败
class Error extends BlocState {
  RequestException exception;
  Error(this.exception, {dynamic data, bool isFinal})
      : super(data: data, isFinal: isFinal);

  Error.from(this.exception, BlocState currentState)
      : super(data: currentState.data, isFinal: currentState.isFinal);
}

class BottomRefreshing extends BlocState {
  BottomRefreshing({dynamic data, bool isFinal})
      : super(data: data, isFinal: isFinal);

  BottomRefreshing.fromState(BlocState currentState)
      : super(data: currentState.data, isFinal: currentState.isFinal);
}

class BottomSuccess extends BlocState {
  BottomSuccess({dynamic data, bool isFinal})
      : super(data: data, isFinal: isFinal);

  BottomSuccess.fromState({BlocState currentState, dynamic data, bool isFinal})
      : super(
            data: data ?? currentState.data, isFinal: isFinal ?? currentState.isFinal);
}

class BottomError extends BlocState {
  RequestException exception;
  BottomError({this.exception, dynamic data, bool isFinal})
      : super(data: data, isFinal: isFinal);

  BottomError.from(this.exception, BlocState currentState)
      : super(data: currentState.data, isFinal: currentState.isFinal);
}
