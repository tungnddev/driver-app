import 'dart:io';

import 'package:driver/presenter/models/image_vm.dart';
import 'package:driver/presenter/screen/route/photo/bloc/photo_event.dart';
import 'package:driver/presenter/screen/route/photo/bloc/photo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  List<ImageVM> images = [ImageVM(), ImageVM(), ImageVM(), ImageVM()];
  PhotoBloc() : super(PhotoFillSuccess([ImageVM(), ImageVM(), ImageVM(), ImageVM()]));

  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    if (event is PhotoUpLoad) {
      await compressImage(event.path);
      images[event.index].path = event.path;
      images[event.index].status = ImageStatus.loading;
      yield PhotoFillSuccess(images);
      try {
        await Future.delayed(Duration(milliseconds: 500));
        images[event.index].url = "https://vnn-imgs-f.vgcloud.vn/2021/05/24/11/dac-quyen-chuan-nhat-cua-phan-khu-the-sakura-the-metrolines-1.jpg";
        images[event.index].status = ImageStatus.success;
        yield PhotoFillSuccess(images);
      } catch (e) {
        images[event.index].status = ImageStatus.fail;
        yield PhotoFillSuccess(images);
      }
    }
  }

  compressImage(String path) async {
    int lastPointIndex = path.lastIndexOf(".");
    if (lastPointIndex == -1) return;
    String pathCompress = path.substring(0, lastPointIndex) +
        "_com" +
        path.substring(lastPointIndex);
    CompressFormat? compressFormat = _getCompressType(path.toLowerCase());
    if (compressFormat == null) return;
    await FlutterImageCompress.compressAndGetFile(path, pathCompress,
        format: compressFormat, quality: 60);
    File fileOrigin = new File(path);
    File fileCompress = new File(pathCompress);
    await fileOrigin.delete();
    await fileCompress.rename(path);
  }

  CompressFormat? _getCompressType(String path) {
    if (path.endsWith(".heic")) {
      return CompressFormat.heic;
    } else if (path.endsWith(".webp")) {
      return CompressFormat.webp;
    } else if (path.endsWith(".png")) {
      return CompressFormat.png;
    } else if (path.endsWith(".jpg") || path.endsWith(".jpeg")) {
      return CompressFormat.jpeg;
    }
    return null;
  }

}