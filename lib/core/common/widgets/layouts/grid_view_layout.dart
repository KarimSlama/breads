import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewLayout extends StatelessWidget {
  final int itemCount;
  final double mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  const GridViewLayout(
      {super.key,
      required this.itemCount,
      this.mainAxisExtent = 288,
      required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.shortestSide < 800 ? 2 : 4,
        crossAxisSpacing: 16.h,
        mainAxisSpacing: 16.w,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
