import 'package:driver/presenter/models/image_vm.dart';

class PhotoState {

}

class PhotoInitial extends PhotoState {

}

class PhotoFillSuccess extends PhotoState {
  List<ImageVM> images;
  PhotoFillSuccess(this.images);
}