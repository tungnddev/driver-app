import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/presenter/models/profile_vm.dart';
import 'package:driver/presenter/screen/profile/bloc/profile_event.dart';
import 'package:driver/presenter/screen/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  late ProfileVM currentProfile;
  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileInitData) {
      try {
        yield ProfileLoading();
        await Future.delayed(Duration(seconds: 1));
        currentProfile = ProfileVM(avatar: "https://meragor.com/files/styles//ava_800_800_wm/mujiki-na-avu-028.jpg",
            name: "PeterPray", email: "peter_pray@gmail.com", address: "33 Zimbabue United State", vehicleInfo: "Mercedes Benz", driverLicense: "N1928-4884-9494", issueDate: DateTime.parse("2012-02-27"), expiration: DateTime.parse("2019-02-27"));
        yield ProfileFill(model: currentProfile);
      } catch (e) {
        yield ProfileFail(ExceptionMapper.map(e));
      }

    } else if (event is ProfileSaveData) {
      try {
        yield ProfileLoadingSave();
        await Future.delayed(Duration(milliseconds: 500));
        yield ProfileSaveDone();
        yield ProfileSaveSuccessful();
      } catch (e) {
        yield ProfileSaveDone();
        yield ProfileFail(ExceptionMapper.map(e));
      }

      // currentProfile = ProfileVM(avatar: "https://meragor.com/files/styles//ava_800_800_wm/mujiki-na-avu-028.jpg",
      //     name: "PeterPray2", email: "peter_pray@gmail.com", address: "33 Zimbabue United State", vehicleInfo: "Mercedes Benz", driverLicense: "N1928-4884-9494", issueDate: DateTime.parse("2012-02-27"), expiration: DateTime.parse("2019-02-27"));
      // yield ProfileFill(model: currentProfile);
    }
  }
}