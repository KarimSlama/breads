import 'package:breads/core/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("SectionHeading shows text and no action by default",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SectionHeading(text: "Categories", isActionButton: false),
      ),
    ));
    expect(find.text("Categories"), findsOneWidget);
    expect(find.byType(TextButton), findsNothing);
    expect(find.byType(TextButton), findsNothing);
  });

  testWidgets("SectionHeading shows action button when enabled",
      (tester) async {
    var pressed = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SectionHeading(
          text: 'Title',
          isActionButton: true,
          buttonText: 'See all',
          onPressed: () => pressed = true,
        ),
      ),
    ));
    expect(find.text("Title"), findsOneWidget);
    expect(find.text("See all"), findsOneWidget);
    await tester.tap(find.text('See all'));
    await tester.pump();
    expect(pressed, isTrue);
  });
}
