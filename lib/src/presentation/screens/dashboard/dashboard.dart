import 'package:books_app/src/common/constants/colors.dart';
import 'package:books_app/src/common/widgets/separator_widget.dart';
import 'package:books_app/src/common/widgets/typography.dart';
import 'package:books_app/src/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:books_app/src/presentation/screens/home/home_screen.dart';
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
    return [const HomeScreen(), Container()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return Scaffold(
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: BottomNavigationBar(
              backgroundColor: ConstColors.white,
              showUnselectedLabels: false,
              selectedItemColor: ConstColors.lightBlue,
              showSelectedLabels: false,
              onTap: (index) {
                pageController.jumpToPage(index);
                _updateTabIndex(index);
              },
              currentIndex: state.tabIndex,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: ConstColors.lightBlue,
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        size: 20,
                      ),
                      SeparatorWidget.width4(),
                      const BodyText.dfltBold(
                        'Home',
                        color: ConstColors.black,
                      )
                    ],
                  ),
                  activeIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home,
                        size: 25,
                      ),
                      SeparatorWidget.width4(),
                      const BodyText.largeBold(
                        'Home',
                        color: ConstColors.lightBlue,
                      )
                    ],
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 20,
                      ),
                      SeparatorWidget.width4(),
                      const BodyText.dfltBold(
                        'Liked',
                        color: ConstColors.black,
                      )
                    ],
                  ),
                  activeIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 25,
                      ),
                      SeparatorWidget.width4(),
                      const BodyText.largeBold(
                        'Liked',
                        color: ConstColors.lightBlue,
                      )
                    ],
                  ),
                  label: '',
                ),
              ],
            ),
          ),
          backgroundColor: ConstColors.grayBasic,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: pageList(),
          ));
    });
  }
}
