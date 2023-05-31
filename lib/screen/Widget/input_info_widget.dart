import 'package:flutter/material.dart';

class InputInfoTextField extends StatelessWidget {
  final _textController;
  final _hintText;
  final _icon;
  final _keyboardType;

  const InputInfoTextField(
      this._textController, this._hintText, this._icon, this._keyboardType,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(20)),
      child: TextField(
        keyboardType: _keyboardType,
        controller: _textController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: _hintText,
            prefixIcon: Icon(
              _icon,
              color: Colors.black,
            )),
      ),
    );
  }
}
