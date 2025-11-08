import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  DateTime focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  void updateFocusedDay(DateTime day) {
    focusedDay = day;
    emit(BookChangeDateState());
  }

  void chooseBookingDate(DateTime dateTime) async {
    selectedDate = dateTime;

    emit(BookChangeDateState());
  }
  
}
