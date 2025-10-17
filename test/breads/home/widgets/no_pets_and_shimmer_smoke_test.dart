import 'package:breads/breads/home/widgets/no_pets_items_found.dart';
import 'package:breads/core/common/widgets/loading/pet_card_shimmer_loading.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/helper/helper.dart';

void main() {
  testWidgets('NoPetsItemsFound renders basic UI', (tester) async {
    await tester.pumpWidget(
      wrapWithTestMaterialAppWithScreenUtil(const NoPetsItemsFound()),
    );

    expect(find.text('No pets found'), findsOneWidget);
  });

  testWidgets('PetCardShimmerLoading renders placeholder items',
      (tester) async {
    await tester.pumpWidget(
      wrapWithTestMaterialAppWithScreenUtil(const PetCardShimmerLoading()),
    );

    // Expect at least one shimmering placeholder to be present
    expect(find.byType(PetCardShimmerLoading), findsOneWidget);
  });
}
