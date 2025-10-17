import 'package:breads/breads/home/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/helper/helper.dart';

void main() {
  testWidgets('SearchBarWidget shows hint and disabled by default',
      (tester) async {
    await tester
        .pumpWidget(wrapWithTestMaterialAppWithScreenUtil(SearchBarWidget()));

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);

    final textField = tester.widget<TextFormField>(find.byType(TextFormField));
    expect(textField.enabled, isFalse);
  });

  testWidgets('SearchBarWidget calls onSearchChanged when typing',
      (tester) async {
    String? latest;
    final controller = TextEditingController();

    await tester
        .pumpWidget(wrapWithTestMaterialAppWithScreenUtil(SearchBarWidget(
      controller: controller,
      enabled: true,
      onSearchChanged: (value) => latest = value,
    )));

    await tester.enterText(find.byType(TextFormField), 'cat');
    await tester.pump();
    expect(latest, 'cat');
  });

  testWidgets('SearchBarWidget calls onFilterTap when filter icon tapped',
      (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrapWithTestMaterialAppWithScreenUtil(SearchBarWidget(
        enabled: true,
        onFilterTap: () => tapped = true,
      )),
    );
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(tapped, isTrue);
  });
}
