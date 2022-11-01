class Question {
  String image;
  String question;
  Map<String, bool> answer;
  bool? state;

  Question({
    required this.image,
    required this.question,
    required this.answer,
  });
}
