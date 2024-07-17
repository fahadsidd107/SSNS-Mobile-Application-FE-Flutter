import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather/config/local/cache_helper.dart';
import 'package:weather/config/routes/app_routes.dart';
import 'package:weather/config/themes/app_theme.dart';
import 'package:weather/core/utils/service_locator.dart';
import 'package:weather/feature/home/presentation/views/API/API_Response.dart';

import 'feature/home/presentation/views/API/graphApi.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  setupServiceLocator();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'Weather',
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
