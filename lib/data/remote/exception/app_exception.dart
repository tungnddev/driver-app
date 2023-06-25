import 'package:driver/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

class AppException implements Exception {
  AppException([this._message = ""]);
  final dynamic _message;

  String toString() {
    return "$_message";
  }

  String toStringDisplay(BuildContext context) {
    if (this is UnknownException) {
      return S.of(context).something_went_wrong;
    } else {
      return this.toString();
    }
  }
}

class UnknownException extends AppException {
  UnknownException() : super();
}

enum NetworkExceptionType {
  ApiError,
  ExpiredToken,
  LostConnection,
  Unknown
}

class NetException extends AppException {
  NetworkExceptionType type;
  String message;

  NetException(this.type, this.message);
}
