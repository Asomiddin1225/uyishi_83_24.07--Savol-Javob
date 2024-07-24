import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quiz_controller.dart';

class QuizScreen extends StatelessWidget {
  final QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 112, 59, 177),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 94, 20, 184),
        centerTitle: true,
        title: Text(
          "Savol-Javob",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
        ),
      ),
      body: Obx(() {
        var currentQuestion = quizController.currentQuestion;
        List<String> allLetters = quizController.allLetters;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currentQuestion.question,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                currentQuestion.answer.length,
                (index) => Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                  ),
                  child: Center(
                    child: Obx(() => Text(
                          quizController.selectedLetters.length > index
                              ? quizController.selectedLetters[index]
                              : '',
                          style: TextStyle(fontSize: 24.0),
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(height: 300),
            Wrap(
              children: allLetters.map((letter) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      quizController.selectLetter(letter);
                    },
                    child: Text(letter),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
  }
}
