part of 'packages_cubit.dart';

sealed class PackagesState {}

final class PackagesInitial extends PackagesState {}

final class PackagesLoading extends PackagesState {}

final class PackagesSuccess extends PackagesState {
  PackagesSuccess(this.subscriptions);

  final List<SubscriptionModel> subscriptions;
}

final class PackagesFailure extends PackagesState {
  PackagesFailure(this.message);

  final String message;
}

final class PackagesSubscribeLoading extends PackagesState {}

final class PackagesSubscribeSuccess extends PackagesState {
  PackagesSubscribeSuccess(this.message);

  final String message;
}

final class PackagesSubscribeFailure extends PackagesState {
  PackagesSubscribeFailure(this.message);

  final String message;
}

