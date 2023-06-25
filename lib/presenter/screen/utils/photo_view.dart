
import 'package:driver/utils/define/constant.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final String path;

  PhotoViewPage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: PhotoView(
              imageProvider: NetworkImage(path),
              minScale: PhotoViewComputedScale.contained,
              initialScale:
              PhotoViewComputedScale.contained * 0.9,
              heroAttributes: const PhotoViewHeroAttributes(tag: Constant.HERO_TAG_PHOTO_VIEW),

            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  color: Colors.black12,
                  padding: EdgeInsets.only(top: 24),
                  alignment: Alignment(-1, 0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
            ],
          )
        ],
      ),
    );
  }
}