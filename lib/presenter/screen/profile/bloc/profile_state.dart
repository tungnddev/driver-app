import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/profile_vm.dart';
import 'package:flutter/cupertino.dart';

class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  
}

class ProfileFill extends ProfileState {
  ProfileVM model;
  ProfileFill({required this.model});
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoadingSave extends ProfileState {
  const ProfileLoadingSave();
}

class ProfileSaveSuccessful extends ProfileState {
  const ProfileSaveSuccessful();
}

class ProfileFail extends ProfileState {
  final AppException exception;
  const ProfileFail(this.exception);
}

class ProfileSaveDone extends ProfileState {
  const ProfileSaveDone();
}