import 'package:bloc/bloc.dart';
import 'package:flutter_examples/bloc/bloc_events.dart';
import 'package:flutter_examples/bloc/bloc_states.dart';
import 'package:flutter_examples/bloc/bloc_utils.dart';
import 'package:flutter_examples/network/network.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 实现了下拉刷新、上拉加载的BLoC模板，旨在快速实现下拉刷新、上拉加载功能
abstract class RefreshFetchBloc extends Bloc<BlocEvent, BlocState> {
  @override
  BlocState get initialState => Uninitialized();

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is Reload || event is Refresh) {
      if (event is Reload) {
        // 此时页面重新加载，并显示加载中UI
        yield Uninitialized();
      }
      try {
        dynamic result = await onRefresh(event);
        BlocState state = onRefreshSuccess(event, result);
        yield state;
      } catch (e) {
        yield Error.from(processException(e, onFailure), currentState);
      }
    } else if (event is Fetch &&
        !(currentState is BottomRefreshing) &&
        !currentState.isFinal) {
      // 如果当前不为上拉加载状态，并且不是最后一页，则执行上拉嘉爱
      // 分发加载中状态
      yield BottomRefreshing.fromState(currentState);
      // 加载数据
      try {
        dynamic result = await onFetch(event);
        BlocState state = onFetchSuccess(event, result);
        yield state;
      } catch (e) {
        yield BottomError.from(processException(e, onFailure), currentState);
      }
    }
  }

  dynamic onRefresh(BlocEvent event);

  dynamic onFetch(BlocEvent event);

  /// 数据加载成功
  /// 根据数据决定返回[Empty]或者[Success]
  BlocState onRefreshSuccess(BlocEvent event, dynamic result);

  BlocState onFetchSuccess(BlocEvent event, dynamic result);

  /// 默认的加载失败回调
  /// 该方法默认会使用[FlutterToast]来进行提示
  void onFailure(RequestException e) {
    Fluttertoast.showToast(msg: e.message);
  }
}

class Impl extends RefreshFetchBloc {
  @override
  onFetch(BlocEvent event) {
    // TODO: implement onFetch
    return null;
  }

  @override
  BlocState onFetchSuccess(BlocEvent event, result) {
    // TODO: implement onFetchSuccess
    return null;
  }

  @override
  onRefresh(BlocEvent event) {
    // TODO: implement onRefresh
    return null;
  }

  @override
  BlocState onRefreshSuccess(BlocEvent event, result) {
    // TODO: implement onRefreshSuccess
    return null;
  }
}
