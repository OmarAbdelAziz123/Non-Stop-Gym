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

