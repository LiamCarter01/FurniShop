import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furnishop/core/theme/app_theme.dart';
import 'package:furnishop/core/widgets/app_button.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('AppButton Widget Tests', () {
    testWidgets('should render with label', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const AppButton(
            label: 'Test Button',
            onPressed: null,
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Test Button',
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.text('Test Button'));
      expect(pressed, true);
    });

    testWidgets('should not call onPressed when disabled', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Test Button',
            onPressed: () => pressed = true,
            isDisabled: true,
          ),
        ),
      );

      await tester.tap(find.text('Test Button'));
      expect(pressed, false);
    });

    testWidgets('should show loading indicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Test Button',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show leading icon when provided', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Test Button',
            onPressed: () {},
            leadingIcon: Icons.shopping_cart,
          ),
        ),
      );

      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });

    testWidgets('should show trailing icon when provided', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Test Button',
            onPressed: () {},
            trailingIcon: Icons.arrow_forward,
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('should render full width when fullWidth is true',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Test Button',
            onPressed: () {},
            fullWidth: true,
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.width, double.infinity);
    });

    testWidgets('should render different sizes correctly', (tester) async {
      // Small
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Small',
            onPressed: () {},
            size: AppButtonSize.small,
          ),
        ),
      );
      var sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.height, 36);

      // Medium
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Medium',
            onPressed: () {},
            size: AppButtonSize.medium,
          ),
        ),
      );
      sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.height, 44);

      // Large
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Large',
            onPressed: () {},
            size: AppButtonSize.large,
          ),
        ),
      );
      sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.height, 52);
    });

    testWidgets('should render primary variant with ElevatedButton',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Primary',
            onPressed: () {},
            variant: AppButtonVariant.primary,
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should render outlined variant with OutlinedButton',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Outlined',
            onPressed: () {},
            variant: AppButtonVariant.outlined,
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('should render text variant with TextButton', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          AppButton(
            label: 'Text',
            onPressed: () {},
            variant: AppButtonVariant.text,
          ),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
    });
  });
}
