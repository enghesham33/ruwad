class BadgeType {
  final String imageURL;
  final String descriptionAr;
  final String descriptionEn;

  const BadgeType({
    required this.imageURL,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  static const BadgeType fullMark = BadgeType(imageURL: "assets/images/full-mark-badge.png", descriptionAr: "أحسنت! لقد حصلت على علامة كاملة في الاختبار.", descriptionEn: "Well Done! You got full marks in this exam.");
  static const BadgeType hardWorker = BadgeType(imageURL: "assets/images/good-work-badge.png", descriptionAr: "أحسنت! أنت طالب مجتهد.", descriptionEn: "Well done! You are a hard-worker.");
  static const BadgeType highestMark = BadgeType(imageURL: "assets/images/highest-mark-badge.png", descriptionAr: "رائع! لقد حصلت على أعلى علامة في هذا الاختبار.", descriptionEn: "Good Job! You scored the highest mark in this exam.");

}
