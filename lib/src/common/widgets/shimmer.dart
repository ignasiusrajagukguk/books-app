import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidgets {
  static Widget listShimmer({EdgeInsetsGeometry? padding}) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: ConstColors.gray.withOpacity(.1),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        padding: padding ?? const EdgeInsets.fromLTRB(15, 200, 15, 0),
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

  static Widget detailShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: ConstColors.gray.withOpacity(.1),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ConstColors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SeparatorWidget.height16(),
              Container(color: ConstColors.white, height: 30, width: 220),
              SeparatorWidget.height12(),
              Container(color: ConstColors.white, height: 20, width: 80),
              SeparatorWidget.height10(),
              Container(color: ConstColors.white, height: 20, width: 180),
              SeparatorWidget.height16(),
              Container(color: ConstColors.white, height: 20, width: 60),
              SeparatorWidget.height10(),
              Container(color: ConstColors.white, height: 20, width: 140),
              SeparatorWidget.height16(),
              Container(color: ConstColors.white, height: 20, width: 100),
              SeparatorWidget.height10(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                      height: 30,
                      decoration: BoxDecoration(
                          color: ConstColors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                      height: 30,
                      decoration: BoxDecoration(
                          color: ConstColors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              SeparatorWidget.height10(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                      height: 30,
                      decoration: BoxDecoration(
                          color: ConstColors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                      height: 30,
                      decoration: BoxDecoration(
                          color: ConstColors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              SeparatorWidget.height10(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                      height: 30,
                      decoration: BoxDecoration(
                          color: ConstColors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                      height: 30,
                      decoration: BoxDecoration(
                          color: ConstColors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              SeparatorWidget.height16(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ConstColors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ));
  }
}
