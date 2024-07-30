// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:uyishi_83/bloc/quiz_bloc.dart';

// void main() {
//   group('QuizBloc', () {
//     late QuizBloc quizBloc;

//     setUp(() {
//       quizBloc = QuizBloc();
//     });

//     tearDown(() {
//       quizBloc.close();
//     });

//     test("boshlang'ich holati to'g'ri", () {
//       expect(quizBloc.state, isA<QuizState>());
//       expect(quizBloc.state.questions.length,
//           4); // Assuming you have 4 questions in initial state
//       expect(quizBloc.state.currentQuestionIndex, 0);
//       expect(quizBloc.state.selectedLetters, isEmpty);
//       expect(quizBloc.state.score, 0);
//     });

//     blocTest<QuizBloc, QuizState>(
//      "SelectLetter qo'shilganda yangilangan tanlangan harflar bilan holat chiqaradi",
//       build: () => quizBloc,
//       act: (bloc) => bloc.add(SelectLetter('S')),
//       expect: () => [
//         isA<QuizState>()
//             .having((state) => state.selectedLetters, 'selectedLetters', ['S']),
//       ],
//     );

//     blocTest<QuizBloc, QuizState>(
//       "qo'shilganda o'sgan savol indeksiga ega holatni chiqaradi",
//       build: () => quizBloc,
//       seed: () => quizBloc.state.copyWith(currentQuestionIndex: 0),
//       act: (bloc) => bloc.add(NextQuestion()),
//       expect: () => [
//         isA<QuizState>().having(
//             (state) => state.currentQuestionIndex, 'currentQuestionIndex', 1),
//       ],
//     );
//   });
// }
