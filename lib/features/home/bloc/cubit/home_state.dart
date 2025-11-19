part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class BookChangeDateState extends HomeState {}

final class HomeBannersLoading extends HomeState {}

final class HomeBannersSuccess extends HomeState {
  HomeBannersSuccess(this.banners, this.currentIndex);

  final List<BannerModel> banners;
  final int currentIndex;
}

final class HomeBannersFailure extends HomeState {
  HomeBannersFailure(this.message);

  final String message;
}

final class HomeSettingsLoading extends HomeState {}

final class HomeSettingsSuccess extends HomeState {
  HomeSettingsSuccess(this.settings);

  final SettingsData settings;
}

final class HomeSettingsFailure extends HomeState {
  HomeSettingsFailure(this.message);

  final String message;
}

final class HomeSlotsLoading extends HomeState {}

final class HomeSlotsSuccess extends HomeState {
  HomeSlotsSuccess(this.slots);

  final List<AvailableSlotModel> slots;
}

final class HomeSlotsFailure extends HomeState {
  HomeSlotsFailure(this.message);

  final String message;
}

final class HomeBookingLoading extends HomeState {}

final class HomeBookingSuccess extends HomeState {
  HomeBookingSuccess(this.message);

  final String message;
}

final class HomeBookingFailure extends HomeState {
  HomeBookingFailure(this.message);

  final String message;
}

final class HomeFaqsLoading extends HomeState {}

final class HomeFaqsSuccess extends HomeState {
  HomeFaqsSuccess(this.faqs);

  final List<FaqModel> faqs;
}

final class HomeFaqsFailure extends HomeState {
  HomeFaqsFailure(this.message);

  final String message;
}

