import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/features/main%20layout/business_logic/main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());

  static MainLayoutCubit get(context) => BlocProvider.of(context);
  void changeBottomNavBar(index) {
    AppConstants.mainLayoutInitialScreenIndex = index;
    emit(AppBottomNavState(AppConstants.mainLayoutInitialScreenIndex));
  }
}
