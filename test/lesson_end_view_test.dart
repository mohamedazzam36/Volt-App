import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/features/lessons/presentation/views/lesson_end_view.dart';

void main() {
  testWidgets('Lesson end screen centers the robot and keeps the action callback wired', (
    tester,
  ) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: LessonEndView(
          onShowResultsPressed: () => pressed = true,
        ),
      ),
    );

    final robot = tester.widget<SpeakingRobot>(find.byType(SpeakingRobot));
    expect(robot.messageHorizontalOffset, 0);
    expect(robot.messageShiftingRatio, 0.5);

    await tester.tap(find.text('عرض النتائج'));
    await tester.pump();

    expect(pressed, isTrue);
  });
}
