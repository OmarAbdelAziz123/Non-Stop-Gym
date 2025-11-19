import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:non_stop/core/constants/app_colors.dart';
import 'package:non_stop/core/constants/app_styles.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/features/home/bloc/cubit/home_cubit.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int? expandedIndex;

  @override
  void initState() {
    super.initState();
    // Fetch FAQs when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().fetchFaqs();
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
              CustomAppBar(title: 'faqs'.tr()),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      current is HomeFaqsLoading ||
                      current is HomeFaqsSuccess ||
                      current is HomeFaqsFailure,
                  builder: (context, state) {
                    if (state is HomeFaqsLoading) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: _buildSkeletonFaqCard(),
                          );
                        },
                      );
                    }

                    if (state is HomeFaqsFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              style: Styles.featureSemibold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            16.verticalSpace,
                            ElevatedButton(
                              onPressed: () {
                                context.read<HomeCubit>().fetchFaqs();
                              },
                              child: Text('retry'.tr()),
                            ),
                          ],
                        ),
                      );
                    }

                    final cubit = context.read<HomeCubit>();
                    final faqs = cubit.faqs;

                    if (faqs.isEmpty) {
                      return Center(
                        child: Text(
                          'noFaqsAvailable'.tr(),
                          style: Styles.featureSemibold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      itemCount: faqs.length,
                      itemBuilder: (context, index) {
                        final isExpanded = expandedIndex == index;
                        final faq = faqs[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff151515).withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(
                                  0xff151515,
                                ).withValues(alpha: 0.41),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      expandedIndex = isExpanded ? null : index;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 16.h,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            faq.question ?? '',
                                            style: Styles.captionBold.copyWith(
                                              color: AppColors.neutralColor100,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        12.horizontalSpace,
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: const Color(0xff9F5A5B),
                                          size: 24.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isExpanded)
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                      left: 16.w,
                                      right: 16.w,
                                      top: 8.h,
                                      bottom: 16.h,
                                    ),
                                    child: Text(
                                      faq.answer ?? '',
                                      style: Styles.captionBold.copyWith(
                                        color: AppColors.neutralColor300,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonFaqCard() {
    return _ShimmerWrapper(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff151515).withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xff151515).withValues(alpha: 0.41),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    8.verticalSpace,
                    Container(
                      width: 200.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              12.horizontalSpace,
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerWrapper extends StatefulWidget {
  const _ShimmerWrapper({required this.child});

  final Widget child;

  @override
  State<_ShimmerWrapper> createState() => _ShimmerWrapperState();
}

class _ShimmerWrapperState extends State<_ShimmerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 - _controller.value * 2, 0.0),
              end: Alignment(1.0 - _controller.value * 2, 0.0),
              colors: [
                Colors.grey[800]!,
                Colors.grey[700]!,
                Colors.grey[800]!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
