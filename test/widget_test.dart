// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:uyishi_83/bloc/quiz_bloc.dart';
// import 'package:uyishi_83/models/question.dart';
// import 'package:uyishi_83/screens/home_secreen.dart';

// void main() {
//   testWidgets('QuizScreen has an Image, a TextButton, and a Text widget', (WidgetTester tester) async {
//     // Create a mock state to provide to the QuizBloc
//     final mockState = QuizLoadSuccess(
//       questions: [
//         Question(question: 'Test savoli', answer: 'SUV', imageUrl: 'assets/suv.png'),
//       ],
//       currentQuestionIndex: 0,
//       selectedLetters: [],
//     );

//     // Provide the necessary dependencies
//     await tester.pumpWidget(
//       BlocProvider(
//         create: (context) => QuizBloc()..emit(mockState),
//         child: MaterialApp(
//           home: QuizScreen(),
//         ),
//       ),
//     );

//     // Allow the Bloc to load the initial state
//     await tester.pumpAndSettle();

//     // Verify the presence of an Image widget
//     expect(find.byType(Image), findsOneWidget);

//     // Verify the presence of a Text widget (the question text)
//     expect(find.byType(Text), findsWidgets);

//     // Verify the presence of at least one TextButton (elevated button for letter selection)
//     expect(find.byType(ElevatedButton), findsWidgets);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uyishi_83/bloc/quiz_bloc.dart';
import 'package:uyishi_83/models/question.dart';
import 'package:uyishi_83/screens/home_secreen.dart';

void main() {
  testWidgets("QuizScreen-da rasm, matn tugmasi va matn vidjeti mavjud",
      (WidgetTester tester) async {
    // Create a mock state to provide to the QuizBloc
    final mockState = QuizState(
      questions: [
        Question(
            question: 'Test savoli', answer: 'SUV', imageUrl: 'assets/suv.png'),
      ],
      currentQuestionIndex: 0,
      selectedLetters: [],
    );

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => QuizBloc()..emit(mockState),
        child: MaterialApp(
          home: QuizScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);

    expect(find.text('Test savoli'), findsOneWidget);

    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
