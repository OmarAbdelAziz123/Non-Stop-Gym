import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/errors/failures.dart' as errors;
import 'package:non_stop/core/network/api_result.dart' as api_result;
import 'package:non_stop/core/services/di/dependency_injection.dart';
import 'package:non_stop/features/home/data/models/available_slots_response.dart';
import 'package:non_stop/features/home/data/models/banner_response.dart';
import 'package:non_stop/features/home/data/models/settings_response.dart';
import 'package:non_stop/features/home/data/models/faq_response.dart';
import 'package:non_stop/features/home/data/repos/home_repository.dart';
import 'package:non_stop/features/notification/data/models/notification_response.dart';
import 'package:non_stop/features/notification/data/repos/notification_repository.dart';
import 'package:table_calendar/table_calendar.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    HomeRepository? homeRepository,
    NotificationRepository? notificationRepository,
  })  : _homeRepository = homeRepository ?? getIt<HomeRepository>(),
        _notificationRepository =
            notificationRepository ?? getIt<NotificationRepository>(),
        super(HomeInitial());

  final HomeRepository _homeRepository;
  final NotificationRepository _notificationRepository;

  DateTime focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 1)); // Only today and tomorrow
  List<BannerModel> banners = [];
  int currentBannerIndex = 0;
  SettingsData? settings;
  List<AvailableSlotModel> availableSlots = [];
  AvailableSlotModel? selectedSlot;
  List<FaqModel> faqs = [];
  int unreadNotificationCount = 0;

  void updateFocusedDay(DateTime day) {
    final firstDay = DateTime.now();
    final tomorrow = firstDay.add(const Duration(days: 1));

    // Only allow today and tomorrow
    if ((isSameDay(day, firstDay) || isSameDay(day, tomorrow)) ||
        (day.isAfter(firstDay) && day.isBefore(tomorrow.add(const Duration(days: 1))))) {
      focusedDay = day;
      emit(BookChangeDateState());
    }
  }

  void chooseBookingDate(DateTime dateTime) async {
    // Only allow today and tomorrow
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    if (!isSameDay(dateTime, today) && !isSameDay(dateTime, tomorrow)) {
      return; // Don't allow selection of other dates
    }

    selectedDate = dateTime;
    // Clear selected slot when date changes
    selectedSlot = null;
    emit(BookChangeDateState());

    // Fetch available slots for selected date
    await fetchAvailableSlots(dateTime);
  }

  Future<void> fetchAvailableSlots(DateTime date) async {
    emit(HomeSlotsLoading());
    
    // Format date as YYYY-MM-DD
    final dateString = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    
    final api_result.ApiResult<List<AvailableSlotModel>> result =
        await _homeRepository.getAvailableBookingSlots(dateString);

    if (result is api_result.Success<List<AvailableSlotModel>>) {
      availableSlots = result.data;
      emit(HomeSlotsSuccess(availableSlots));
      return;
    }

    if (result is api_result.Failure<List<AvailableSlotModel>>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      availableSlots = [];
      emit(HomeSlotsFailure(message));
      return;
    }

    availableSlots = [];
    emit(HomeSlotsFailure('unexpectedErrorOccurred'.tr()));
  }

  void selectSlot(AvailableSlotModel? slot) {
    selectedSlot = slot;
    emit(BookChangeDateState());
  }

  Future<void> bookBooking() async {
    if (selectedSlot?.id == null) {
      emit(HomeBookingFailure('pleaseSelectTimeSlot'.tr()));
      return;
    }

    emit(HomeBookingLoading());

    final api_result.ApiResult<Map<String, dynamic>> result =
        await _homeRepository.bookBooking(selectedSlot!.id!);

    if (result is api_result.Success<Map<String, dynamic>>) {
      emit(HomeBookingSuccess(result.data['message'] as String? ?? 'bookingSuccess'.tr()));
      // Clear selection after successful booking
      selectedSlot = null;
      // Refresh available slots
      await fetchAvailableSlots(selectedDate);
      return;
    }

    if (result is api_result.Failure<Map<String, dynamic>>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(HomeBookingFailure(message));
      return;
    }

    emit(HomeBookingFailure('unexpectedErrorOccurred'.tr()));
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

    emit(HomeBannersFailure('unexpectedErrorOccurred'.tr()));
  }

  void changeBannerIndex(int index) {
    currentBannerIndex = index;
    emit(HomeBannersSuccess(banners, currentBannerIndex));
  }

  Future<void> fetchSettings() async {
    emit(HomeSettingsLoading());

    final api_result.ApiResult<SettingsData> result =
        await _homeRepository.fetchSettings();

    if (result is api_result.Success<SettingsData>) {
      settings = result.data;
      emit(HomeSettingsSuccess(result.data));
      return;
    }

    if (result is api_result.Failure<SettingsData>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(HomeSettingsFailure(message));
      return;
    }

    emit(HomeSettingsFailure('unexpectedErrorOccurred'.tr()));
  }

  Future<void> fetchFaqs() async {
    emit(HomeFaqsLoading());

    final api_result.ApiResult<List<FaqModel>> result =
        await _homeRepository.fetchFaqs();

    if (result is api_result.Success<List<FaqModel>>) {
      faqs = result.data;
      emit(HomeFaqsSuccess(faqs));
      return;
    }

    if (result is api_result.Failure<List<FaqModel>>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(HomeFaqsFailure(message));
      return;
    }

    emit(HomeFaqsFailure('unexpectedErrorOccurred'.tr()));
  }

  Future<void> fetchNotifications() async {
    emit(HomeNotificationsLoading());

    final api_result.ApiResult<NotificationData> result =
        await _notificationRepository.getNotifications(perPage: 100, page: 1);

    if (result is api_result.Success<NotificationData>) {
      final data = result.data;
      if (data.items != null) {
        // Count unread notifications (is_read == false)
        unreadNotificationCount = data.items!
            .where((item) => item.isRead == false)
            .length;
        emit(HomeNotificationsSuccess(unreadNotificationCount));
        return;
      }
    }

    // On failure, just set count to 0
    unreadNotificationCount = 0;
    emit(HomeNotificationsSuccess(0));
  }
}
