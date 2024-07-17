import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/widgets/background_widget.dart';
import 'package:weather/core/widgets/loading_indicator_widget.dart';
import 'package:weather/core/widgets/logo_widget.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, bottom: 70.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoWidget(),
              LoadingIndicatorWidget(strokeWidth: 3.5.h),
            ],
          ),
        ),
      ),
    );
  }
}
