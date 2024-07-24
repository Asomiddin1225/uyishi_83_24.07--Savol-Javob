import 'package:get/get.dart';
import '../models/question.dart';
import 'dart:math';

class QuizController extends GetxController {
  var questions = [
    Question(question: 'Yer tagida oltin Qoziq', answer: 'SABZI'),
    Question(question: "Qat qat qatlama aqling bo'lsa tashma", answer: 'KITOB'),
    Question(
        question: "Yelkasi bor, boshi yo‘q,Oyog‘i bor, qo‘li yo‘q.",
        answer: 'STUL'),
    Question(
        question:
            "Aqlga do‘st tutsang,a’lo so‘zlar, Yo‘qsa u suyaksiz balo so‘zlar",
        answer: 'TIL'),
    Question(
        question: "Jonsiz, tinglaydi, Qo‘lsiz, yozadi, Tilsiz, so‘zlaydi",
        answer: 'MAGNITOFON')
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
