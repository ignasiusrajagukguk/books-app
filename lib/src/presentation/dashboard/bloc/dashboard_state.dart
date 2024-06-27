part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({this.tabIndex = 0});

  final int tabIndex;

  DashboardState copyWith({
    int? tabIndex,
  }) {
    return DashboardState(
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }

  factory DashboardState.initial() => const DashboardState(tabIndex: 0);

  @override
  List<Object> get props => [tabIndex];
}
