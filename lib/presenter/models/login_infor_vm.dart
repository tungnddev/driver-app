class LoginInfoVM {
  String username;
  String password;

  LoginInfoVM({required this.username, required this.password});

  factory LoginInfoVM.init() => LoginInfoVM(username: "", password: "");

  bool get isValid => username.isNotEmpty && password.isNotEmpty;
}