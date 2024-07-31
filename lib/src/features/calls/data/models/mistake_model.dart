class MistakeModel {
  String type;
  int count;

  MistakeModel({
    required this.type,
    required this.count,
  });

  factory MistakeModel.fromJson(Map<String, dynamic> json) => MistakeModel(
        type: json['type'],
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'count': count,
      };
}