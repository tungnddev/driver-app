import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/image_vm.dart';
import 'package:driver/presenter/screen/route/photo/bloc/photo_state.dart';
import 'package:driver/presenter/screen/route/photo/widgets/item_photo.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/button_with_arrow.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/photo_bloc.dart';
import 'bloc/photo_event.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc(),
      child: PhotoWidget(),
    );
  }
}

class PhotoWidget extends StatefulWidget {
  const PhotoWidget({Key? key}) : super(key: key);

  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  late PhotoBloc bloc;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PhotoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    return ScaffoldWithColor(
        color: ColorUtils.grayPackingSlip,
        child: Column(
          children: [
            DriverAppBar(
                asset: ImageUtils.icAppBarPhoto,
                title: S.of(context).photo,
                color: ColorUtils.grayPackingSlip),
            SizedBox(
              height: 16,
            ),
            TextNormal(
              content: S.of(context).take_a_clear_photo_note,
              color: ColorUtils.colorNote,
              size: 16,
            ),
            SizedBox(
              height: 5,
            ),
            TextNormal(
              content: S.of(context).click_here_to_view_example,
              color: ColorUtils.colorNote,
              size: 12,
              decoration: TextDecoration.underline,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: _buildPhotoWidget()),
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextNormal(
                    color: ColorUtils.colorNote,
                    content: S.of(context).skip,
                    decoration: TextDecoration.underline,
                    size: 17,
                  ),
                ),
              ),
            ),
            _buildButton()
          ],
        ));
  }

  Widget _buildPhotoWidget() {
    return BlocConsumer<PhotoBloc, PhotoState>(
        bloc: bloc,
        builder: (context, state) {
          return state is PhotoFillSuccess
              ? Padding(
                  padding: EdgeInsets.all(26),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1,
                          mainAxisSpacing: 23),
                      itemCount: state.images.length,
                      itemBuilder: (context, index) => ItemPhoto(
                          imageVM: state.images[index],
                          index: index,
                          onTap: () async {
                            var imageVM = state.images[index];
                            if (imageVM.status == ImageStatus.none) {
                              var result = await Navigator.pushNamed(context, Routes.camera);
                              if (result != null && result is String) {
                                bloc.add(PhotoUpLoad(index, result));
                              }
                              // PickedFile? pickedFile =
                              //     await picker.getImage(source: ImageSource.camera);
                              // if (pickedFile != null) {
                              //   bloc.add(PhotoUpLoad(index, pickedFile.path));
                              // }
                            }
                          })),
                )
              : Container();
        },
        listener: (context, state) {});
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 5),
      child: Row(
        children: [
          Expanded(child: DriverButton(textColor: Colors.black, backgroundColor: Color(0xFFD3D3D3), text: S.of(context).profile_back, onTap: () {
          },), flex: 1,),
          SizedBox(width: 18,),
          Expanded(child: DriverButtonWithArrow(text: S.of(context).proceed_to_review, onTap: () {
            Navigator.pushNamed(context, Routes.reviewNotes);
          },), flex: 2,)
        ],
      ),
    );
  }
}
