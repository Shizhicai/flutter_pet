import 'package:dio/dio.dart';
import 'package:flutter_pet/base/base_presenter.dart';
import 'package:flutter_pet/base/mvps.dart';
import 'package:flutter_pet/net/api.dart';
import 'package:flutter_pet/net/dio_utils.dart';
import 'package:flutter_pet/net/error_handle.dart';

class BasePagePresenter<V extends IMvpView> extends BasePresenter<V> {
  late CancelToken _cancelToken;

  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void dispose() {
    /// 销毁时，取消请求
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
  }

  /// 返回Future适用于刷新，加载更多
  Future<T?> requestNetwork<T>({
    required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    if (isShow) {
      view.showProgress();
    }
    return DioUtils.instance.requestNetwork<T>(Api.apiMethod[url]!, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? _cancelToken, onSuccess: (data) {
      if (isClose) {
        view.closeProgress();
      }
      onSuccess?.call(data);
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  /// 异步请求
  void asyncRequestNetwork<T>({
    required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    if (isShow) {
      view.showProgress();
    }
    DioUtils.instance.requestNetwork<T>(Api.apiMethod[url]!, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? _cancelToken, onSuccess: (data) {
      if (isClose) {
        view.closeProgress();
      }
      onSuccess?.call(data);
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  void _onError(int code, String msg, NetErrorCallback? onError) {
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error) {
      view.showToast(msg);
    }
    if (onError != null) {
      onError(code, msg);
    }
  }
}
