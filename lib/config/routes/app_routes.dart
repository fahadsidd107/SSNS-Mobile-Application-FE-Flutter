import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/animations/page_fade_transition.dart';
import 'package:weather/core/animations/page_slide_transition.dart';
import 'package:weather/core/utils/app_strings.dart';
import 'package:weather/core/utils/service_locator.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';
import 'package:weather/feature/home/data/repository/home_repository_implementation.dart';
import 'package:weather/feature/home/presentation/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather/feature/home/presentation/cubits/weather_for_four_cities_cubit/weather_for_four_cities_cubit.dart';
import 'package:weather/feature/home/presentation/views/details_view.dart';
import 'package:weather/feature/splash/presentation/views/WeatherApp/home_view.dart';
import 'package:weather/feature/onBoarding/presentation/cubit/onBoarding_cubit.dart';
import 'package:weather/feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:weather/feature/splash/presentation/views/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String onBoardingView = '/onBoarding_view';
  static const String homeView = '/home_view';
  static const String detailsView = '/details_view';
}

class ScreenArguments {
  final String? cityName;
  final String? latitude;
  final String? longitude;
  final WeatherModel? weatherModel;

  ScreenArguments({
    this.cityName,
    this.latitude,
    this.longitude,
    this.weatherModel,
  });
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case Routes.onBoardingView:
        return PageFadeTransition(
          page: BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingView(),
          ),
        );
      case Routes.homeView:
        return PageFadeTransition(
          page:  BlocProvider(
            create: (context) => WeatherForFourCitiesCubit(
              getIt.get<HomeRepositoryImplementation>(),
            ),
            child: const HomeView(),
          ),
        );
      case Routes.detailsView:
        final arguments = settings.arguments as ScreenArguments?;
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
            create: (context) => WeatherCubit(
              getIt.get<HomeRepositoryImplementation>(),
            ),
            child: DetailsView(
              cityName: arguments!.cityName ?? '',
              latitude: arguments.latitude ?? '',
              longitude: arguments.longitude ?? '',
              weatherModel: arguments.weatherModel ?? const WeatherModel(),
            ),
          ),
        );
    }
    return undefinedRoute();
  }

  static Route undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text(AppStrings.noRouteFound),
            ),
          )),
    );
  }
}
