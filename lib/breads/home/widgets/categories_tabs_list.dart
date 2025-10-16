import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'category_tab.dart';

class CategoriesTabsList extends StatefulWidget {
  final Function(String)? onCategorySelected;

  const CategoriesTabsList({
    super.key,
    this.onCategorySelected,
  });

  @override
  State<CategoriesTabsList> createState() => _CategoriesTabsListState();
}

class _CategoriesTabsListState extends State<CategoriesTabsList> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Cats',
    'Dogs',
    'Birds',
    'Fish',
    'Reptiles',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return CategoryTab(
            label: category,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
              widget.onCategorySelected?.call(category);
            },
          );
        },
      ),
    );
  }
}
