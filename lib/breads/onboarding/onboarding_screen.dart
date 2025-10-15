import 'package:breads/core/constants/app_colors.dart';
import 'package:breads/core/constants/app_strings.dart';
import 'package:breads/core/constants/spacing.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:breads/core/routing/routes.dart';
import 'package:breads/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _titleController;
  late AnimationController _subtitleController;
  late AnimationController _buttonController;

  late Animation<Offset> _imageSlide;
  late Animation<double> _imageFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _titleFade;
  late Animation<Offset> _subtitleSlide;
  late Animation<double> _subtitleFade;
  late Animation<Offset> _buttonSlide;
  late Animation<double> _buttonFade;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _subtitleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeOutBack,
    ));

    _imageFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: Curves.easeIn,
      ),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeOutCubic,
    ));

    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _titleController,
        curve: Curves.easeIn,
      ),
    );

    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _subtitleController,
      curve: Curves.easeOutCubic,
    ));

    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _subtitleController,
        curve: Curves.easeIn,
      ),
    );

    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeOutBack,
    ));

    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeIn,
      ),
    );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await _imageController.forward();
    
    await Future.delayed(const Duration(milliseconds: 200));
    await _titleController.forward();
    
    await Future.delayed(const Duration(milliseconds: 200));
    await _subtitleController.forward();
    
    await Future.delayed(const Duration(milliseconds: 200));
    await _buttonController.forward();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 20.h,
          children: [
            FadeTransition(
              opacity: _imageFade,
              child: SlideTransition(
                position: _imageSlide,
                child: Image.asset(Assets.images.animal.path),
              ),
            ),
            
            FadeTransition(
              opacity: _titleFade,
              child: SlideTransition(
                position: _titleSlide,
                child: Text(
                  AppStrings.findYourBestCompanionWithUs,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            
            FadeTransition(
              opacity: _subtitleFade,
              child: SlideTransition(
                position: _subtitleSlide,
                child: Text(
                  AppStrings
                      .joinDiscoverTheBestSuitablePetsAsPerYourPreferencesInYourLocation,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: AppColors.grey),
                ),
              ),
            ),
            
            verticalSpace(26),
            
            FadeTransition(
              opacity: _buttonFade,
              child: SlideTransition(
                position: _buttonSlide,
                child: ElevatedButton(
                  onPressed: () => context.pushNamed(Routes.navigationMenu),
                  child: Row(
                    spacing: 10.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.icons.pet),
                      Text(
                        AppStrings.getStarted,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}