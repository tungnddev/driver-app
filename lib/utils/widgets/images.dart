import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/extensions/resize_url.dart';
import 'package:driver/utils/extensions/nullable.dart';
import 'package:driver/utils/widgets/loading_image.dart';

import 'loading_view.dart';

class CacheImage extends StatelessWidget {
  final String url;
  final double width, height;
  final int widthNetworkImage, heightNetworkImage;
  final double radiusAll;

  CacheImage(
      {required this.url,
      required this.height,
      required this.width,
      this.widthNetworkImage = 500,
      this.heightNetworkImage = 500,
      this.radiusAll = 0});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url.resizeUrl(widthNetworkImage, heightNetworkImage),
      placeholder: (context, url) => LoadAnimation(
          child: Container(
        color: ColorUtils.grayBG,
        width: width,
        height: height,
      )),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(radiusAll),
          color: ColorUtils.grayBG
        ),
        alignment: Alignment.center,
        child: Image.asset(
          ImageUtils.errorImage,
          width: width,
          height: width,
        ),
      ),
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(radiusAll),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class AvatarCircle extends StatelessWidget {
  final double size;
  final String url;
  final Color colorBorder;
  final String defaultImage;
  final double widthBorder;
  final BoxFit fit;
  final bool isShadow;

  AvatarCircle(
      {required this.size,
      required this.url,
      this.colorBorder = const Color.fromRGBO(235, 235, 245, 1),
      this.defaultImage = ImageUtils.defaultAvatar,
      this.widthBorder = 1,
      this.fit = BoxFit.fill,
      this.isShadow = false});

  @override
  Widget build(BuildContext context) {
    return url.isNullOrEmpty
        ? ErrorImageCircle(size: size, errorImage: defaultImage)
        : CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) =>
                AvatarLoadingView(size: size),
            errorWidget: (context, url, error) => ErrorImageCircle(
              size: size,
              errorImage: defaultImage,
            ),
            imageBuilder: (context, imageProvider) => Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: colorBorder, width: widthBorder),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
                boxShadow: isShadow ? [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 8,
                  offset: Offset(4, 2), // Shadow position
                )] : [],
              ),
            ),
          );
  }
}

class AvatarLoadingView extends StatelessWidget {
  final double size;

  AvatarLoadingView({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ColorUtils.grayBG,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      // child: LoadingView(
      //   size: size * 3 / 20,
      //   strokeWidth: size > 70 ? 2 : 1,
      // ),
    );
  }
}

class ErrorImageCircle extends StatelessWidget {
  final double size;
  final String errorImage;

  ErrorImageCircle({required this.size, required this.errorImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromRGBO(235, 235, 245, 1), width: 0.5),
          color: ColorUtils.grayBG,
          shape: BoxShape.circle,
          image:
              DecorationImage(image: AssetImage(errorImage), fit: BoxFit.fill)),
      alignment: Alignment.center,
    );
  }
}
