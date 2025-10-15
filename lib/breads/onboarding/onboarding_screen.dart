import 'package:breads/core/constants/app_colors.dart';
import 'package:breads/core/constants/app_strings.dart';
import 'package:breads/core/constants/spacing.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:breads/core/routing/routes.dart';
import 'package:breads/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 20.h,
          children: [
            Image.asset(Assets.images.animal.path),
            Text(AppStrings.findYourBestCompanionWithUs,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
            Text(
                textAlign: TextAlign.center,
                AppStrings
                    .joinDiscoverTheBestSuitablePetsAsPerYourPreferencesInYourLocation,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(color: AppColors.grey)),
            verticalSpace(26),
            ElevatedButton(
              onPressed: () => context.pushNamed(Routes.navigationMenu),
              child: Row(
                spacing: 10.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.icons.pet),
                  Text(
                    AppStrings.getStarted,
                    style: Theme.of(context).textTheme.titleMedium!.apply(
                          color: AppColors.white,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
