import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  DateTime focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  void updateFocusedDay(DateTime day) {
    final firstDay = DateTime.now();

    if ((day.isAfter(firstDay) || isSameDay(day, firstDay)) &&
        (day.isBefore(endDate) || isSameDay(day, endDate))) {
      focusedDay = day;
      emit(BookChangeDateState());
    }
  }

  void chooseBookingDate(DateTime dateTime) async {
    selectedDate = dateTime;
    emit(BookChangeDateState());
  }
}
