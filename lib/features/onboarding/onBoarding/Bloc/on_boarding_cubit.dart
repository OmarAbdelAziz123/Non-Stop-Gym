import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/features/onboarding/onBoarding/Bloc/on_boarding_states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  int onBoardingIndex = 0;
  void changeOnBoardingIndex(int index) {
    onBoardingIndex = index;

    emit(OnBoardingNextState());
  }

  PageController pageController = PageController(initialPage: 0);

  List<String> onBoardingImageUrls = [
    "assets/pngs/onboarding1.png",
    "assets/pngs/onboarding2.png",
    "assets/pngs/onboarding3.png",

  ];

  List<String> onBoardingTitleStart = [
    'onBoarding.title1'.tr(),
    'onBoarding.title2'.tr(),
    'onBoarding.title3'.tr(),
  ];

  List<String> onBoardingDescriptions = [
    'onBoarding.desc1'.tr(),
    'onBoarding.desc2'.tr(),
    'onBoarding.desc3'.tr(),
  ];
}
