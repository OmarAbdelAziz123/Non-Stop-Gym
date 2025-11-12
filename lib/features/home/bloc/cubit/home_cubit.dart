import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/errors/failures.dart' as errors;
import 'package:non_stop/core/network/api_result.dart' as api_result;
import 'package:non_stop/core/services/di/dependency_injection.dart';
import 'package:non_stop/features/home/data/models/banner_response.dart';
import 'package:non_stop/features/home/data/repos/home_repository.dart';
import 'package:table_calendar/table_calendar.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeRepository? homeRepository})
      : _homeRepository = homeRepository ?? getIt<HomeRepository>(),
        super(HomeInitial());

  final HomeRepository _homeRepository;

  DateTime focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));
  List<BannerModel> banners = [];
  int currentBannerIndex = 0;

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

  Future<void> fetchBanners() async {
    emit(HomeBannersLoading());

    final api_result.ApiResult<List<BannerModel>> result =
        await _homeRepository.fetchBanners();

    if (result is api_result.Success<List<BannerModel>>) {
      banners = result.data;
      currentBannerIndex = 0;
      emit(HomeBannersSuccess(banners, currentBannerIndex));
      return;
    }

    if (result is api_result.Failure<List<BannerModel>>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(HomeBannersFailure(message));
      return;
    }

    emit(HomeBannersFailure('حدث خطأ غير متوقع'));
  }

  void changeBannerIndex(int index) {
    currentBannerIndex = index;
    emit(HomeBannersSuccess(banners, currentBannerIndex));
  }
}
