import 'package:books_app/src/common/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer {
  static Widget listShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: ConstColors.gray.withOpacity(.1),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        padding: const EdgeInsets.fromLTRB(15, 75, 15, 0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 120,
                decoration: BoxDecoration(
                    color: ConstColors.gray,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 10,
                width: 50,
                decoration: BoxDecoration(
                    color: ConstColors.gray,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 10,
                width: 100,
                decoration: BoxDecoration(
                    color: ConstColors.gray,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          );
        },
      ),
    );
  }
}
