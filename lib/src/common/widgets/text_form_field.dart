import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/constants/text_style.dart';
import 'package:flutter/material.dart';

const _errorStyleNoLabel = TextStyle(
  color: Colors.red,
  height: 0,
);

class TextFormFieldWidget {
  static Widget search(String hint,
      {TextEditingController? controller,
      FormFieldValidator<String>? validator,
      OutlineInputBorder? focusBorder,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
      Color? backgroundColor,
      VoidCallback? onEditingComplete,
      Function(String? value)? onChanged,
      FocusNode? focusNode}) {
    return Stack(
      children: [
        TextFormField(
          autovalidateMode: autovalidateMode,
          focusNode: focusNode,
          textInputAction: TextInputAction.search,
          controller: controller,
          enableSuggestions: true,
          validator: validator,
          onEditingComplete: onEditingComplete,
          style: textStyleTextLarge.copyWith(color: Colors.black),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, -10, 10, -10),
              focusedBorder: focusBorder ?? _Border._focusedBorder(),
              enabledBorder: _Border._enabledBorder(),
              errorBorder: _Border._errorBorder(),
              errorStyle: _errorStyleNoLabel,
              filled: true,
              fillColor: backgroundColor ?? Colors.white,
              hintText: hint,
              prefixIcon: const Icon(Icons.search)),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _Border {
  static OutlineInputBorder _focusedBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        color: ConstColors.lightBlue,
        width: .5,
      ),
    );
  }

  static OutlineInputBorder _enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: ConstColors.gray,
        width: .5,
      ),
    );
  }

  static OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
    );
  }
}
