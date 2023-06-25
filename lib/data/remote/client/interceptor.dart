import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:driver/data/models/app_error_model.dart';
import 'package:driver/data/remote/exception/app_exception.dart';

class AuthInterceptor extends RequestInterceptor {

  @override
  FutureOr<Request> onRequest(Request request) {
    Map<String, String> headers = new Map();

    // get by hive
    //headers['Authorization'] = HiveService.instance.cacheToken;

    return request.copyWith(headers: headers);
  }
}

class ValidateInterceptor extends ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) {
    var error = response.error;
    var type = NetworkExceptionType.ApiError;
    if (error is AppErrorModel) {
      if (response.statusCode == 401 && error.code != "USER_LOGIN_FAILED")
        type = NetworkExceptionType.ExpiredToken;
      throw NetException(type, error.message);
    }
    return response;
  }
}
