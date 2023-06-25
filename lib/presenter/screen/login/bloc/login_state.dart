import 'package:driver/data/remote/exception/app_exception.dart';

class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginSuccessful extends LoginState {

}

class LoginLoading extends LoginState {

}

class LoginFail extends LoginState {
  AppException exception;
  LoginFail(this.exception);
}