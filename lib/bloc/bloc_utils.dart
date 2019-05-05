import 'package:flutter_examples/network/network.dart';

/// 将异常转化为RequestException
RequestException processException(dynamic e, [ExceptionCallBack callback]) {
  if (e is RequestException) {
    if (callback != null) {
      callback(e);
    }
    return e;
  } else {
    var requestException =
        RequestException(code: -1, message: "加载失败，请稍候重试", error: e);
    if (callback != null) {
      callback(requestException);
    }
    return requestException;
  }
}

typedef ExceptionCallBack = void Function(RequestException msg);
