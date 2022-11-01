import 'package:flutter/material.dart';
import 'package:pdd/helpers/route.dart';
import 'package:pdd/model/question.dart';

class ResultPage extends StatefulWidget {
  List<Question> question;
  ResultPage({super.key, required this.question});
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    int trueAnswer = 0;
    for (var element in widget.question) {
      if (element.state!) {
        ++trueAnswer;
      }
    }

    TextStyle textStyle1 = const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$trueAnswer / ${widget.question.length}',
            style: textStyle1,
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRouter.home, (route) => false),
              child: const Text('Выйти'))
        ],
      ),
    );
  }
}
