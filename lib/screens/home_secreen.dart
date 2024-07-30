// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/quiz_controller.dart';

// class QuizScreen extends StatelessWidget {
//   final QuizController quizController = Get.put(QuizController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[100],
//       appBar: AppBar(
//         backgroundColor: Colors.green[900],
//         centerTitle: true,
//         title: Text(
//           "Savol-Javob",
//           style: TextStyle(
//               fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
//         ),
//       ),
//       body: Obx(
//         () {
//           final question = quizController.currentQuestion;
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   question.question,
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green[700]),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset(question.imageUrl, height: 400),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   question.answer.length,
//                   (index) => Container(
//                     width: 35,
//                     height: 35,
//                     margin: EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.green),
//                     ),
//                     child: Center(
//                       child: Obx(() => Text(
//                             quizController.selectedLetters.length > index
//                                 ? quizController.selectedLetters[index]
//                                 : '',
//                             style: TextStyle(fontSize: 24.0),
//                           )),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Wrap(
//                 spacing: 8.0,
//                 runSpacing: 4.0,
//                 children: quizController.allLetters
//                     .map((letter) => ElevatedButton(
//                           onPressed: () => quizController.selectLetter(letter),
//                           child: Text(
//                             letter,
//                             style: TextStyle(color: Colors.green[900]),
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }



















import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          centerTitle: true,
          title: Text(
            "Savol-Javob",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
          ),
        ),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            final question = state.questions[state.currentQuestionIndex];
            final quizBloc = BlocProvider.of<QuizBloc>(context);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question.question,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(question.imageUrl, height: 400),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    question.answer.length,
                    (index) => Container(
                      width: 35,
                      height: 35,
                      margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                      ),
                      child: Center(
                        child: Text(
                          state.selectedLetters.length > index
                              ? state.selectedLetters[index]
                              : '',
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: quizBloc.allLetters
                      .map((letter) => ElevatedButton(
                            onPressed: () {
                              quizBloc.add(SelectLetter(letter));
                            },
                            child: Text(
                              letter,
                              style: TextStyle(color: Colors.green[900]),
                            ),
                          ))
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
