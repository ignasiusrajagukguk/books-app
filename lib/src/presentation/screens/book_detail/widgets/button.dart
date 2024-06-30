import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/widgets/typography.dart';
import 'package:flutter/material.dart';

class ButtonWidget {
  static Widget defaultButton(BuildContext context,
      {required String title, required Function() onPressed}) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(ConstColors.white),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
          onPressed: onPressed,
          child: BodyText.largeBold(
            title,
            color: ConstColors.lightBlue,
          )),
    );
  }
}
