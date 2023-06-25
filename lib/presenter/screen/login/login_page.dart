import 'dart:async';

import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/screen/login/bloc/login_bloc.dart';
import 'package:driver/presenter/screen/login/bloc/login_event.dart';
import 'package:driver/presenter/screen/login/bloc/login_state.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/loading_dialog.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => LoginBloc())
    ], child: LoginWidget());
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  StreamController<bool> _buttonLoginStream = StreamController();
  late LoginBloc bloc;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _buttonLoginStream.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: bloc,
        listener: (context, state) {
          if (state is LoginSuccessful) {
            // Navigator.pop(context);
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
            // Navigator.of(context).pushNamed(Routes.home);
          } else if (state is LoginFail) {
            AppExceptionHandle.handle(context, state.exception);
          } else if (state is LoginLoading) {
            LoadingDialog.show(context);
          }
        },
        builder: (context, state) =>  Container(
          height: double.infinity,
          color: ColorUtils.colorLogin,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LayoutBuilder(builder: (context, constrait) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    alignment: Alignment.center,
                    child: Image.asset(
                      ImageUtils.imgLogoLogin,
                      width: 300,
                      height: 174,
                    ),
                  );
                }),
                _buildInput(S.of(context).login_enter_user_name, (text) {
                  bloc.loginVM.username = text.trim();
                  _buttonLoginStream.add(bloc.loginVM.isValid);
                }),
                SizedBox(
                  height: 15,
                ),
                _buildInput(S.of(context).login_enter_password, (text) {
                  bloc.loginVM.password = text.trim();
                  _buttonLoginStream.add(bloc.loginVM.isValid);
                }, isObscure: true),
                SizedBox(
                  height: 20,
                ),
                _buildLoginButton(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).login_forgot_password,
                  style: TextStyle(
                      color: Color.fromRGBO(152, 152, 152, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String placeholder, Function(String text) onChange, {bool isObscure = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: PhysicalModel(
        color: Colors.black,
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: CupertinoTextField(
            placeholder: placeholder,
            placeholderStyle:
            TextStyle(fontSize: 14, color: Color.fromRGBO(152, 152, 152, 1)),
            style: TextStyle(
              fontSize: 14,
            ),
            obscureText: isObscure,
            onChanged: onChange,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16)),
      ),
    );
  }

  Widget _buildLoginButton() {
    return StreamBuilder<bool>(
      stream: _buttonLoginStream.stream,
      builder: (context, snapshot) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: PhysicalModel(
            color: Colors.black,
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            child: CupertinoButton(
              onPressed: snapshot.data == true ? () {
                FocusScope.of(context).unfocus();
                bloc.add(LoginStartLogin());
              } : null,
              disabledColor: ColorUtils.grayBackButton,
              child: TextBoldNormal(
                size: 14,
                content: S.of(context).login_button,
                color: Colors.white,
              ),
              color: ColorUtils.colorButtonLogin,
              padding: EdgeInsets.only(top: 0, bottom: 0),
              minSize: 54,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    );
  }
}

