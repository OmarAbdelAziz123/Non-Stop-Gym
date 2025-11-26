import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/errors/failures.dart' as errors;
import 'package:non_stop/core/network/api_result.dart' as api_result;
import 'package:non_stop/core/services/di/dependency_injection.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/features/notification/data/models/notification_response.dart';
import 'package:non_stop/features/notification/data/repos/notification_repository.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationRepository _notificationRepository =
      getIt<NotificationRepository>();
  final ScrollController _scrollController = ScrollController();

  List<NotificationItem> _notifications = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _errorMessage;
  int _currentPage = 1;
  bool _hasMorePages = true;
  PaginationModel? _pagination;

  @override
  void initState() {
    super.initState();
    _markAllAsRead();
    _fetchNotifications();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _markAllAsRead() async {
    await _notificationRepository.markAllNotificationsAsRead();
  }

  Future<void> _deleteAllNotifications() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('deleteAllNotifications'.tr()),
        content: Text('areYouSureDeleteAllNotifications'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final result = await _notificationRepository.deleteAllNotifications();

    if (result is api_result.Success<void>) {
      setState(() {
        _notifications = [];
        _currentPage = 1;
        _hasMorePages = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('allNotificationsDeletedSuccessfully'.tr())),
        );
      }
    } else if (result is api_result.Failure<void>) {
      final error = result.errorHandler;
      final message = error is errors.Failure
          ? error.message
          : error.toString();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (!_isLoadingMore && _hasMorePages) {
        _fetchNotifications(loadMore: true);
      }
    }
  }

  Future<void> _fetchNotifications({bool loadMore = false}) async {
    if (loadMore) {
      if (_isLoadingMore || !_hasMorePages) return;
      setState(() {
        _isLoadingMore = true;
      });
      _currentPage++;
    } else {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        _currentPage = 1;
        _hasMorePages = true;
      });
    }

    final api_result.ApiResult<NotificationData> result =
        await _notificationRepository.getNotifications(
          perPage: 15,
          page: _currentPage,
        );

    if (result is api_result.Success<NotificationData>) {
      final data = result.data;
      _pagination = data.pagination;

      setState(() {
        if (loadMore) {
          _notifications.addAll(data.items ?? []);
          _isLoadingMore = false;
        } else {
          _notifications = data.items ?? [];
          _isLoading = false;
        }
        _hasMorePages =
            (_pagination?.currentPage ?? 0) < (_pagination?.lastPage ?? 0);
      });
      return;
    }

    if (result is api_result.Failure<NotificationData>) {
      final error = result.errorHandler;
      final message = error is errors.Failure
          ? error.message
          : error.toString();
      setState(() {
        if (loadMore) {
          _isLoadingMore = false;
          _currentPage--; // Revert page increment
        } else {
          _errorMessage = message;
          _isLoading = false;
        }
      });
      return;
    }

    setState(() {
      if (loadMore) {
        _isLoadingMore = false;
        _currentPage--; // Revert page increment
      } else {
        _errorMessage = 'unexpectedErrorOccurred'.tr();
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: linearGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "notifications".tr(),
                actionIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 20.sp,
                ),
                onActionPressed: _deleteAllNotifications,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: _buildBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              style: Styles.contentBold.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            ElevatedButton(
              onPressed: _fetchNotifications,
              child: Text('retry'.tr()),
            ),
          ],
        ),
      );
    }

    if (_notifications.isEmpty) {
      return Center(
        child: Text(
          'noNotifications'.tr(),
          style: Styles.contentBold.copyWith(color: Colors.white),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _fetchNotifications(),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _notifications.length + (_isLoadingMore ? 1 : 0),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          if (index == _notifications.length) {
            // Loading indicator at the bottom
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          final item = _notifications[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff02040B),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  width: 0.5.w,
                  color: const Color(0xff151515).withValues(alpha: 0.41),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            style: Styles.contentBold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          item.timeAgo ?? '',
                          style: Styles.contentBold.copyWith(
                            color: const Color(0xff9F5A5B),
                          ),
                        ),
                      ],
                    ),
                    11.verticalSpace,
                    Text(
                      item.body ?? '',
                      style: Styles.footnoteBold.copyWith(
                        height: 1.5.h,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
