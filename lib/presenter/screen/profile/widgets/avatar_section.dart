import 'package:driver/generated/l10n.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/constant.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/image_dialog_picker.dart';
import 'package:driver/utils/widgets/images.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class AvatarSection extends StatefulWidget {
  final String? initialUrl;
  const AvatarSection({Key? key, this.initialUrl}) : super(key: key);

  @override
  _AvatarSectionState createState() => _AvatarSectionState();
}

class _AvatarSectionState extends State<AvatarSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RippleInkWell(
          onTap: () =>
              Navigator.pushNamed(
                  context,
                  Routes.photoViewNoAnimation,
                  arguments: "https://i.pravatar.cc/300"),
          child: Hero(
            tag: Constant.HERO_TAG_PHOTO_VIEW,
            child: PhysicalModel(
              color: Colors.black,
              borderRadius: BorderRadius.circular(60),
              elevation: 4,
              child: AvatarCircle(
                size: 112,
                url: "https://i.pravatar.cc/300",
                widthBorder: 2,
                colorBorder: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        RippleInkWell(
          onTap: () {
            ImageDialogPicker.showDialogSelectImage((path) {

            }, context);
          },
          child: TextNormal(
            content: S
                .of(context)
                .profile_edit_avatar,
            color: ColorUtils.grayProfile,
          ),
        ),
      ],
    );
  }
}
