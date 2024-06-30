import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/presentation/widgets/typography.dart';
import 'package:books_app/src/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.state,
      required this.isActive});
  final String title;
  final Function() onTap;
  final DashboardState state;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: <Color>[ConstColors.lightBlue, ConstColors.green])
                : null,
            borderRadius: BorderRadius.circular(30),
            boxShadow: isActive
                ? [
                    BoxShadow(
                        color: const Color(0xFF18274B).withOpacity(0.8),
                        blurRadius: 4,
                        spreadRadius: -2,
                        offset: const Offset(0, 5)),
                  ]
                : null,
          ),
          child: Center(
            child: BodyText.largeBold(
              title,
              color: isActive ? ConstColors.white : ConstColors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }
}
