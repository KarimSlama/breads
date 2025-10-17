import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'controller/navigation_cubit.dart';
import '../../core/constants/app_colors.dart';

class NavigationMenu extends StatelessWidget {
  final Widget child;

  const NavigationMenu({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        child: Container(
          height: 80.h,
          decoration: const BoxDecoration(),
          child: BlocBuilder<NavigationCubit, NavigationItem>(
            builder: (context, currentIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    context: context,
                    icon: Iconsax.home_1,
                    index: NavigationItem.home,
                    currentIndex: currentIndex,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Iconsax.heart_copy,
                    index: NavigationItem.favorites,
                    currentIndex: currentIndex,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Iconsax.messages_2_copy,
                    index: NavigationItem.messages,
                    currentIndex: currentIndex,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Iconsax.user_copy,
                    index: NavigationItem.profile,
                    currentIndex: currentIndex,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required NavigationItem index,
    required NavigationItem currentIndex,
  }) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => context.read<NavigationCubit>().changeTab(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Icon(
          icon,
          size: 26.sp,
          color: isActive ? AppColors.primary : AppColors.lightGrey,
        ),
      ),
    );
  }
}
