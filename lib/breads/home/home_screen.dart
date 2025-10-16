import 'package:breads/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/common/widgets/texts/section_heading.dart';
import '../../core/routing/routes.dart';
import 'widgets/categories_tabs_list.dart';
import 'widgets/pets_list.dart';
import 'widgets/search_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Your Forever Pet'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.notification_copy),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 14, vertical: 10),
            child: Column(
              spacing: 30.h,
              children: [
                GestureDetector(
                    onTap: () => context.pushNamed(Routes.searchScreen),
                    child: SearchBarWidget(onFilterTap: () {})),
                SectionHeading(text: 'Categories', isActionButton: false),
                CategoriesTabsList(),
              ],
            ),
          ),
          Expanded(child: PetsList()),
        ],
      ),
    );
  }
}
