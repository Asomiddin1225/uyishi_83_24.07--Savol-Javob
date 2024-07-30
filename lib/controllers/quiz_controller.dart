import 'package:get/get.dart';
import '../models/question.dart';
import 'dart:math';

class QuizController extends GetxController {
  var questions = [
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
        answer: 'Issiq',
        imageUrl: 'assets/hod.jpg'),
  ].obs;

  var currentQuestionIndex = 0.obs;
  var selectedLetters = <String>[].obs;
  var score = 0.obs;

  Question get currentQuestion => questions[currentQuestionIndex.value];

  List<String> get allLetters {
    List<String> answerLetters = currentQuestion.answer.split('');
    List<String> extraLetters = _generateExtraLetters(3); // Add 3 extra letters
    List<String> allLetters = [...answerLetters, ...extraLetters];
    allLetters.shuffle();
    return allLetters;
  }

  void selectLetter(String letter) {
    if (selectedLetters.length < currentQuestion.answer.length) {
      selectedLetters.add(letter);
      if (selectedLetters.length == currentQuestion.answer.length) {
        if (selectedLetters.join() == currentQuestion.answer) {
          score++;
        }
        nextQuestion();
      }
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex++;
    } else {
      Get.defaultDialog(
        title: 'Quiz Finished',
        middleText:
            "To'g'ri javob:${score.value}👍\n Nato'g'ri Javoblar ${5 - score.value}❌",
        textConfirm: 'Takrolash',
        onConfirm: () {
          currentQuestionIndex.value = 0;
          score.value = 0;
          selectedLetters.clear();
          Get.back();
        },
      );
    }
    selectedLetters.clear();
  }

  List<String> _generateExtraLetters(int count) {
    const letters = "ABDEFGHIJKLMNOPQRSTUVWXWZ";
    Random random = Random();
    return List.generate(
        count, (index) => letters[random.nextInt(letters.length)]);
  }
}
