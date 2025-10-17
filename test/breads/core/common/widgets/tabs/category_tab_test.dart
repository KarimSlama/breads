import 'package:breads/core/common/widgets/tabs/category_tab.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helper/helper.dart';

void main() {
  testWidgets('CategoryTab renders selected/unselected styles and taps',
      (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrapWithTestMaterialAppWithScreenUtil(
        CategoryTab(
          label: 'Cats',
          isSelected: true,
          onTap: () => tapped = true,
        ),
      ),
    );

    expect(find.text('Cats'), findsOneWidget);
    await tester.tap(find.text('Cats'));
    await tester.pump();
    expect(tapped, isTrue);
  });
}
