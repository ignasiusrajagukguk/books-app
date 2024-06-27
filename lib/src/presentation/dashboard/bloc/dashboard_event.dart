part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardSetTabIndex extends DashboardEvent {
  final int tabIndex;

  const DashboardSetTabIndex({this.tabIndex = 0});
}
