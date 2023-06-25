import 'dart:ui';

import 'package:driver/generated/l10n.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/button_with_arrow.dart';
import 'package:driver/utils/widgets/input_constraint.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewNotesPage extends StatelessWidget {
  const ReviewNotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReviewNotesWidget();
  }
}

class ReviewNotesWidget extends StatefulWidget {
  const ReviewNotesWidget({Key? key}) : super(key: key);

  @override
  _ReviewNotesWidgetState createState() => _ReviewNotesWidgetState();
}

class _ReviewNotesWidgetState extends State<ReviewNotesWidget> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(color: ColorUtils.grayPackingSlip, child: Column(
      children: [
        DriverAppBar(
          color: ColorUtils.grayPackingSlip,
          title: S.of(context).review_notes,
          asset: ImageUtils.icAppBarReviewNotes,
        ),
        SizedBox(height: 35,),
        TextNormal(
          color: ColorUtils.colorNote,
          content: S.of(context).rate_client_experience,
          fontWeight: FontWeight.bold,
          size: 24,
        ),
        SizedBox(height: 23,),
      RatingBar.builder(
        initialRating: 0,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Image.asset(ImageUtils.icStarFill, width: 31, height: 31,),
        unratedColor: ColorUtils.colorGrayUnderLine,
        onRatingUpdate: (rating) {
          // current rating
        },
      ),
        SizedBox(height: 45,),
        TextNormal(
          content: S.of(context).write_any_note,
          color: ColorUtils.colorNote,
          size: 16,
        ),
        SizedBox(height: 17,),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 27),
            child: InputConstraint(
              onChange: (text) {},
              hint: S.of(context).example_client_has_10,
            ),
          ),
        ),
        SizedBox(height: 50,),
        _buildButton()
      ],
    ));
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: DriverButton(
              textColor: Colors.black,
              backgroundColor: Color(0xFFD3D3D3),
              text: S.of(context).profile_back,
              onTap: () {},
            ),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: DriverButtonWithArrow(
              text: S.of(context).complete_drop_off,
              onTap: () {
                Navigator.pushNamed(context, Routes.driverPayment);
              },
            ),
            flex: 2,
          )
        ],
      ),
    );
  }
}

