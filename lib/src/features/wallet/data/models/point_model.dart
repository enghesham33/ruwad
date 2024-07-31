class PointsModel
{
  final String personalID;
  final num  points;
  final int cardType;

   PointsModel({
    required this.personalID,
    required this.points,
    required this.cardType
    });


    Map<String, dynamic> toJson() => {
    "personalID": personalID,
    "points": points,
    "cardType": cardType,
  };

    factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel
    (
      personalID: json['personalID'],
      points: json['points'],
      cardType: json['cardType'],
    );
  }
}