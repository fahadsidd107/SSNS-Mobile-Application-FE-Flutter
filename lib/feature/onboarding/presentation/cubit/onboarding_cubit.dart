import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/feature/onboarding/presentation/cubit/onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  final PageController pageController = PageController();

  List<String> titles = [
    'Prediting  temperature, humidity, pressure and particulate matter',
    'Using Sensor',
    'Let\'s go',
  ];

  bool isLast = false;

  void onChangePageView(int index) {
    if (index == titles.length - 1) {
      isLast = true;
      emit(OnChangePageViewState());
    } else {
      isLast = false;
      emit(OnChangePageViewState());
    }
  }
}
