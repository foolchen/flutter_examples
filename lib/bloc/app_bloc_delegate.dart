import 'package:bloc/bloc.dart';

/// 简单的Delegate，用于打印状态变化
class AppBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print('onTransition - $transition');
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print('onError - error : $error , stacktrace : $stacktrace');
  }
}
