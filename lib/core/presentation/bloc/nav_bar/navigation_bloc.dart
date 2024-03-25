import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const PageInitial(tabIndex: 0)) {
    on<NavigationEvent>((event, emit) {
      if (event is TabChange) {
        emit(PageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}