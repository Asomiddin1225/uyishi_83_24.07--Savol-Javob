import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/question.dart';
import 'dart:math';

class QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final List<String> selectedLetters;
  final int score;

  QuizState({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.selectedLetters = const [],
    this.score = 0,
  });

  QuizState copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    List<String>? selectedLetters,
    int? score,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedLetters: selectedLetters ?? this.selectedLetters,
      score: score ?? this.score,
    );
  }
}

abstract class QuizEvent {}

class SelectLetter extends QuizEvent {
  final String letter;

  SelectLetter(this.letter);
}

class NextQuestion extends QuizEvent {}

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc()
      : super(QuizState(questions: [
          Question(
              question: 'Rasimdan Nimani tushindingiz',
              answer: 'SUT',
              imageUrl: 'assets/sut.jpg'),
          Question(
              question: "Rasimdan Nimani tushindingiz",
              answer: 'SUV',
              imageUrl: 'assets/suv.jpg'),
          Question(
              question: "Rasimdan Nimani tushindingiz",
              answer: 'TELEFON',
              imageUrl: 'assets/telefon.jpg'),
          Question(
              question: "Rasimdan Nimani tushindingiz",
              answer: 'ISSIQ',
              imageUrl: 'assets/hod.jpg'),
        ]));

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is SelectLetter) {
      List<String> updatedSelectedLetters = List.from(state.selectedLetters);
      if (updatedSelectedLetters.length <
          state.questions[state.currentQuestionIndex].answer.length) {
        updatedSelectedLetters.add(event.letter);
        if (updatedSelectedLetters.length ==
            state.questions[state.currentQuestionIndex].answer.length) {
          if (updatedSelectedLetters.join() ==
              state.questions[state.currentQuestionIndex].answer) {
            yield state.copyWith(
              score: state.score + 1,
              selectedLetters: updatedSelectedLetters,
            );
          }
          add(NextQuestion());
        } else {
          yield state.copyWith(selectedLetters: updatedSelectedLetters);
        }
      }
    } else if (event is NextQuestion) {
      if (state.currentQuestionIndex < state.questions.length - 1) {
        yield state.copyWith(
          currentQuestionIndex: state.currentQuestionIndex + 1,
          selectedLetters: [],
        );
      } else {
        // Show Dialog (Handled in the UI)
      }
    }
  }

  List<String> get allLetters {
    List<String> answerLetters =
        state.questions[state.currentQuestionIndex].answer.split('');
    List<String> extraLetters = _generateExtraLetters(3); // Add 3 extra letters
    List<String> allLetters = [...answerLetters, ...extraLetters];
    allLetters.shuffle();
    return allLetters;
  }

  List<String> _generateExtraLetters(int count) {
    const letters = "ABDEFGHIJKLMNOPQRSTUVWXWZ";
    Random random = Random();
    return List.generate(
        count, (index) => letters[random.nextInt(letters.length)]);
  }
}
