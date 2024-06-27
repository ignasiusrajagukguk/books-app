import 'package:flutter/material.dart';

class BouncingScrollBehavior extends ScrollBehavior {
  const BouncingScrollBehavior();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const BouncingScrollPhysics();
    }
  }
}
