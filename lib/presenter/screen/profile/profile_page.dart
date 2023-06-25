import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/profile_vm.dart';
import 'package:driver/presenter/screen/profile/bloc/profile_bloc.dart';
import 'package:driver/presenter/screen/profile/bloc/profile_event.dart';
import 'package:driver/presenter/screen/profile/bloc/profile_state.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/constant.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/images.dart';
import 'package:driver/utils/widgets/loading_dialog.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'widgets/avatar_section.dart';
import 'widgets/profile_text_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => ProfileBloc())],
        child: ProfileWidget());
  }
}

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ProfileBloc>(context)..add(ProfileInitData());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(
      color: ColorUtils.blueHome,
      child: Column(
        children: [
          DriverAppBar(
              asset: ImageUtils.icAppBarProfile,
              title: S
                  .of(context)
                  .home_profile,
              color: ColorUtils.blueHome),
          Expanded(
              child: BlocConsumer<ProfileBloc, ProfileState>(
                bloc: bloc,
                  listener: (context, state) {
                    if (state is ProfileLoadingSave) {
                      LoadingDialog.show(context);
                    } else if (state is ProfileSaveSuccessful) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).save_profile_successful)));
                    } else if (state is ProfileSaveDone) {
                      Navigator.pop(context);
                    } else if (state is ProfileFail) {
                      AppExceptionHandle.handle(context, state.exception);
                    }
                  },
                  buildWhen: (pre, next) => next is ProfileLoading || next is ProfileFill ,
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return LoadingView();
                    }
                    if (state is ProfileFill) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _buildFormWidget(state.model),
                            ),
                            _buildButton()
                          ],
                        ),
                      );
                    }
                    return Container();
                  }
              )),
        ],
      ),
    );
  }

  Widget _buildFormWidget(ProfileVM profile) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          AvatarSection(initialUrl: profile.avatar,),
          FormBuilderTextField(
            name: S
                .of(context)
                .profile_name,
            decoration: _inputDecoration(S.of(context).profile_name),
            initialValue: profile.name,
            onChanged: (text) {
              bloc.currentProfile.name = text?.trim() ?? "";
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            autovalidateMode: AutovalidateMode.always,
            style: _textStyle(),
          ),
          FormBuilderTextField(
            name: S
                .of(context)
                .profile_email,
            decoration: _inputDecoration(S
                .of(context)
                .profile_email),
            initialValue: profile.email,
            onChanged: (text) {
              bloc.currentProfile.email = text?.trim() ?? "";
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            style: _textStyle(),
          ),
          FormBuilderTextField(
            name: S
                .of(context)
                .profile_password_reset,
            decoration: _inputDecoration(S
                .of(context)
                .profile_password_reset),
            initialValue: "avcc",
            onChanged: (text) {
              bloc.currentProfile.name = text?.trim() ?? "";
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            style: _textStyle(),
          ),
          FormBuilderTextField(
            name: S
                .of(context)
                .profile_mobile,
            decoration: _inputDecoration(S
                .of(context)
                .profile_mobile,
            ),
            initialValue: profile.mobile,
            onChanged: (text) {
              bloc.currentProfile.mobile = text?.trim() ?? "";
            },
            validator: FormBuilderValidators.compose([
            ]),
            style: _textStyle(),
          ),
          FormBuilderTextField(
            name: S
                .of(context)
                .profile_alt_phone,
            decoration: _inputDecoration(S
                .of(context)
                .profile_alt_phone),
            initialValue: profile.altPhone,
            onChanged: (text) {
              bloc.currentProfile.altPhone = text?.trim() ?? "";
            },
            validator: FormBuilderValidators.compose([
            ]),
            style: _textStyle(),
          ),
          FormBuilderTextField(
            name: S
                .of(context)
                .profile_address,
            decoration: _inputDecoration(S
                .of(context)
                .profile_address),
            initialValue: profile.address,
            onChanged: (text) {
              bloc.currentProfile.address = text?.trim() ?? "";
            },
            validator: FormBuilderValidators.compose([
            ]),
            style: _textStyle(),
          ),
          FormBuilderTextField(
            name: S
                .of(context)
                .profile_vehicle_info,
            decoration: _inputDecoration(S
                .of(context)
                .profile_vehicle_info),
            initialValue: profile.vehicleInfo,
            onChanged: (text) {
              bloc.currentProfile.vehicleInfo = text?.trim() ?? "";
            },
            validator: FormBuilderValidators.compose([
            ]),
            style: _textStyle(),
          ),
          FormBuilderTextField(
            name: S
                .of(context)
                .profile_driver_license,
            decoration: _inputDecoration(S
                .of(context)
                .profile_driver_license),
            initialValue: profile.driverLicense,
            onChanged: (text) {
              bloc.currentProfile.driverLicense = text?.trim() ?? "";
            },
            validator: FormBuilderValidators.compose([
            ]),
            style: _textStyle(),
          ),
          Row(
            children: [
              Expanded(child: FormBuilderDateTimePicker(
                name: 'date',
                onChanged: (date) {
                  if (date != null) {
                    bloc.currentProfile.expiration = date;
                  }
                },
                inputType: InputType.date,
                decoration: _inputDecoration(S.of(context).profile_expiration),
                initialValue: DateTime.now(),
                style: _textStyle(),
                // enabled: true,
              ),),
              Expanded(
                child: FormBuilderDateTimePicker(
                  name: 'date',
                  onChanged: (date) {
                    if (date != null) {
                      bloc.currentProfile.issueDate = date;
                    }
                  },
                  inputType: InputType.date,
                  decoration: _inputDecoration(S.of(context).profile_issue_date),
                  initialValue: DateTime.now(),
                  style: _textStyle(),
                  // enabled: true,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String placeHolder) => InputDecoration(
    labelText: placeHolder,
    isDense: true,
    contentPadding: EdgeInsets.only(top: 8, bottom: 8)
  );

  TextStyle _textStyle() => TextStyle(
      fontSize: 13.5
  );

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(child: DriverButton(textColor: Colors.black, backgroundColor: Color(0xFFD3D3D3), text: S.of(context).profile_back, onTap: () {
            Navigator.pop(context);
          },), flex: 1,),
          SizedBox(width: 18,),
          Expanded(child: DriverButton(text: S.of(context).profile_save, onTap: () {
            bloc.add(ProfileSaveData());
          },), flex: 2,)
        ],
      ),
    );
  }
}
