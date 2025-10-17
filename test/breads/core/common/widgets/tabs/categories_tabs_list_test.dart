import 'package:breads/core/common/widgets/tabs/categories_tabs_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helper/helper.dart';

void main() {
  testWidgets('CategoriesTabsList renders and toggles selection',
      (tester) async {
    String? selected;
    await tester.pumpWidget(wrapWithTestMaterialAppWithScreenUtil(
      CategoriesTabsList(
        onCategorySelected: (categorySelected) => selected = categorySelected,
      ),
    ));
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Cats'), findsOneWidget);

    await tester.tap(find.text('Cats'));
    await tester.pump();
    expect(selected, 'Cats');

    await tester.tap(find.text('Dogs'));
    await tester.pump();
    expect(selected, 'Dogs');
  });
}
