import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/errors/failures.dart' as errors;
import 'package:non_stop/core/network/api_result.dart' as api_result;
import 'package:non_stop/core/services/di/dependency_injection.dart';
import 'package:non_stop/features/packages/data/models/subscription_response.dart';
import 'package:non_stop/features/packages/data/repos/packages_repository.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit({PackagesRepository? packagesRepository})
      : _packagesRepository = packagesRepository ?? getIt<PackagesRepository>(),
        super(PackagesInitial());

  final PackagesRepository _packagesRepository;

  List<SubscriptionModel> subscriptions = [];

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
}

