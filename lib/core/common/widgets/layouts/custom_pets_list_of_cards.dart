import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../breads/home/data/model/pet_model_response.dart';
import '../../../../breads/home/widgets/pet_card.dart';

class CustomPetsListOfCards extends StatelessWidget {
  final List<PetModelResponse> pets;
  const CustomPetsListOfCards({
    super.key,
    required this.pets,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: PetCard(pets: pets[index]),
        ),
      ),
    );
  }
}
