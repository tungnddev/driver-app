import 'package:driver/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  final String initialText;
  final String title;
  final Function(String content)? onChange;
  final String? Function(String? value)? validator;

  const ProfileTextField({Key? key, this.initialText = "", this.title = "", this.onChange, this.validator}) : super(key: key);

  @override
  _ProfileTextFieldState createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {

  // TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // textEditingController.text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (content) {
        widget.onChange?.call(content);
      },
      initialValue: widget.initialText,
      validator: (String? value) => widget.validator?.call(value),
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        labelText: widget.title,
      ),
      autovalidateMode: AutovalidateMode.always,
    );
  }
}
