import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState.initial()) {
    on<DashboardSetTabIndex>(_dashboardSetTabIndex);
  }

  void _dashboardSetTabIndex(DashboardSetTabIndex event, emit) async {
    emit(state.copyWith(tabIndex: event.tabIndex));
  }
}
