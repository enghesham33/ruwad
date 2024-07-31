class QuestionType {
  final String value;

  const QuestionType({
    required this.value,
  });

  static const QuestionType written = QuestionType(value: 'W',);
  static const QuestionType choices = QuestionType(value: 'S', );

  static QuestionType? map(String type) {
    switch (type) {
      case 'W':
        return QuestionType.written;
      case 'S':
        return QuestionType.choices;
      default:
        return null;
    }
  }
}

