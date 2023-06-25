import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/images.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildAvatarWithStatus(),
          SizedBox(width: 15,),
          Expanded(child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextBoldNormal(
              content: "Hi, John!",
              maxLines: 2,
              size: 24,
            ),
          ))
        ],
      ),
    );
  }

  _buildAvatarWithStatus() => PhysicalModel(
    color: Colors.black,
    elevation: 8,
    borderRadius: BorderRadius.circular(25),
    child: Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        AvatarCircle(size: 50,
          url: "https://i.pravatar.cc/300",
          widthBorder: 2,
          colorBorder: Colors.white,),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: Colors.white),
              shape: BoxShape.circle,
          color: ColorUtils.colorHomeActivateAvatar),
        )
      ],
    ),
  );
}
