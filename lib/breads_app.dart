import 'package:breads/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_strings.dart';
import 'core/routing/routes.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

class BreadsApp extends StatelessWidget {
  final AppRouter appRouter;
  const BreadsApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 914),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        title: AppStrings.appName,
        theme: themeLight,
        darkTheme: themeDark,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.onboardingScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
