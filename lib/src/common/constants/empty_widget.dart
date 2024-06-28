import 'package:books_app/src/common/constants/asset_path.dart';
import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/widgets/typography.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
          ImagePath.general.book,
          height: 180,
          color: ConstColors.gray,
        )),
        const Heading.h3Large(
          'No Data',
          color: ConstColors.gray,
        )
      ],
    );
  }
}
