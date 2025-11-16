import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/errors/failures.dart' as errors;
import 'package:non_stop/core/network/api_result.dart' as api_result;
import 'package:non_stop/core/services/di/dependency_injection.dart';
import 'package:non_stop/features/packages/data/models/subscription_response.dart';
import 'package:non_stop/features/packages/data/models/user_subscription_response.dart';
import 'package:non_stop/features/packages/data/repos/packages_repository.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit({PackagesRepository? packagesRepository})
      : _packagesRepository = packagesRepository ?? getIt<PackagesRepository>(),
        super(PackagesInitial());

  final PackagesRepository _packagesRepository;

  List<SubscriptionModel> subscriptions = [];
  List<UserSubscriptionModel> userSubscriptions = [];
  int? subscribingSubscriptionId;

  Future<void> fetchSubscriptions() async {
    emit(PackagesLoading());

    final api_result.ApiResult<List<SubscriptionModel>> result =
        await _packagesRepository.fetchSubscriptions();

    if (result is api_result.Success<List<SubscriptionModel>>) {
      subscriptions = result.data;
      emit(PackagesSuccess(subscriptions));
      return;
    }

    if (result is api_result.Failure<List<SubscriptionModel>>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(PackagesFailure(message));
      return;
    }

    emit(PackagesFailure('حدث خطأ غير متوقع'));
  }

  Future<void> subscribe({
    required int subscriptionId,
    String paymentMethod = 'cash',
  }) async {
    subscribingSubscriptionId = subscriptionId;
    emit(PackagesSubscribeLoading());

    final api_result.ApiResult<Map<String, dynamic>> result =
        await _packagesRepository.subscribe(
      subscriptionId: subscriptionId,
      paymentMethod: paymentMethod,
    );

    if (result is api_result.Success<Map<String, dynamic>>) {
      subscribingSubscriptionId = null;
      final message = result.data['message'] as String? ?? 'تم الاشتراك بنجاح';
      emit(PackagesSubscribeSuccess(message));
      return;
    }

    if (result is api_result.Failure<Map<String, dynamic>>) {
      subscribingSubscriptionId = null;
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      // Emit failure but keep subscriptions visible by emitting success state after
      emit(PackagesSubscribeFailure(message));
      // After showing error, restore subscriptions view
      if (subscriptions.isNotEmpty) {
        // Small delay to ensure snackbar is shown, then restore subscriptions view
        Future.delayed(const Duration(milliseconds: 100), () {
          emit(PackagesSuccess(subscriptions));
        });
      }
      return;
    }

    subscribingSubscriptionId = null;
    emit(PackagesSubscribeFailure('حدث خطأ غير متوقع'));
  }

  Future<void> fetchUserSubscriptions() async {
    emit(PackagesUserSubscriptionsLoading());

    final api_result.ApiResult<List<UserSubscriptionModel>> result =
        await _packagesRepository.getUserSubscriptions();

    if (result is api_result.Success<List<UserSubscriptionModel>>) {
      userSubscriptions = result.data;
      emit(PackagesUserSubscriptionsSuccess(userSubscriptions));
      return;
    }

    if (result is api_result.Failure<List<UserSubscriptionModel>>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(PackagesUserSubscriptionsFailure(message));
      return;
    }

    emit(PackagesUserSubscriptionsFailure('حدث خطأ غير متوقع'));
  }
}

