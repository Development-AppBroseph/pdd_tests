// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

List<Question> questionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
    required this.title,
    required this.ticketNumber,
    required this.ticketCategory,
    required this.image,
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.answerTip,
    required this.topic,
    required this.id,
    this.state,
  });

  String title;
  String ticketNumber;
  String ticketCategory;
  String image;
  String question;
  List<Answer> answers;
  String correctAnswer;
  String answerTip;
  List<String> topic;
  String id;
  bool? state;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        title: json["title"],
        ticketNumber: json["ticket_number"],
        ticketCategory: json["ticket_category"],
        image: json["image"],
        question: json["question"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        correctAnswer: json["correct_answer"],
        answerTip: json["answer_tip"],
        topic: List<String>.from(json["topic"].map((x) => x)),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "ticket_number": ticketNumber,
        "ticket_category": ticketCategory,
        "image": image,
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "correct_answer": correctAnswer,
        "answer_tip": answerTip,
        "topic": List<dynamic>.from(topic.map((x) => x)),
        "id": id,
      };
}

class Answer {
  Answer({
    required this.answerText,
    required this.isCorrect,
  });

  String answerText;
  bool isCorrect;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answerText: json["answer_text"],
        isCorrect: json["is_correct"],
      );

  Map<String, dynamic> toJson() => {
        "answer_text": answerText,
        "is_correct": isCorrect,
      };
}
