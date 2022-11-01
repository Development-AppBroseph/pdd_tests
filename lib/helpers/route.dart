import 'package:flutter/material.dart';
import 'package:pdd/model/question.dart';
import 'package:pdd/ui/main_common.dart';
import 'package:pdd/ui/training/exam/exam.dart';
import 'package:pdd/ui/training/result/result_page.dart';
import 'package:pdd/ui/training/exam/start_exam.dart';
import 'package:pdd/ui/training/test/start_test.dart';
import 'package:pdd/ui/training/test/training.dart';

class AppRouter {
  static const home = '/';
  static const training = '/training';
  static const exam = '/exam';
  static const startTest = '/startTest';
  static const startExam = '/startExam';
  static const result = '/result';

  static Route<dynamic>? onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case training:
        return MaterialPageRoute(builder: (_) => Training());
      case exam:
        return MaterialPageRoute(builder: (_) => ExamPage());
      case startTest:
        return MaterialPageRoute(builder: (_) => StartTestPage());
      case startExam:
        return MaterialPageRoute(builder: (_) => StartExamPage());
      case result:
        List<Question> value = route.arguments as List<Question>;
        return MaterialPageRoute(builder: (_) => ResultPage(question: value));
      default:
        return null;
    }
  }
}
