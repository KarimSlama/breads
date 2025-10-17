import 'package:breads/breads/home/widgets/no_pets_items_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/helper/helper.dart';

void main() {
  testWidgets('NoPetsItemsFound shows icon and text', (tester) async {
    await tester.pumpWidget(
      wrapWithTestMaterialAppWithScreenUtil(
        const NoPetsItemsFound(),
      ),
    );

    expect(find.byIcon(Icons.pets), findsOneWidget);
    expect(find.text('No pets found'), findsOneWidget);
  });
}
