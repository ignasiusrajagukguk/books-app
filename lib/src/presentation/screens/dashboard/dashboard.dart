import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/widgets/separator_widget.dart';
import 'package:books_app/src/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:books_app/src/presentation/screens/dashboard/widgets/custom_button.dart';
import 'package:books_app/src/presentation/screens/home/home_screen.dart';
import 'package:books_app/src/presentation/screens/liked/liked_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: const _DashboardScreen(),
    );
  }
}

class _DashboardScreen extends StatefulWidget {
  const _DashboardScreen();

  @override
  State<_DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<_DashboardScreen> {
  late PageController pageController;

  _updateTabIndex(int tabIndex) {
    context.read<DashboardBloc>().add(DashboardSetTabIndex(
          tabIndex: tabIndex,
        ));
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  List<Widget> pageList() {
    return [const HomeScreen(), const LikedScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return Scaffold(
          bottomNavigationBar: _bottomNavBar(state),
          backgroundColor: ConstColors.grayBasic,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: pageList(),
          ));
    });
  }

  Widget _bottomNavBar(DashboardState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: ConstColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      child: Row(
        children: [
          CustomButton(
            title: 'Home',
            isActive: state.tabIndex == 0,
            onTap: () {
              pageController.jumpToPage(0);
              _updateTabIndex(0);
            },
            state: state,
          ),
          SeparatorWidget.width16(),
          CustomButton(
            title: 'Liked',
            isActive: state.tabIndex == 1,
            onTap: () {
              pageController.jumpToPage(1);
              _updateTabIndex(1);
            },
            state: state,
          ),
        ],
      ),
    );
  }
}
