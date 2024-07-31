class QuraanModel
{
  final int number;
  final String name;
  final String englishName;
  final int numberOfAyahs;

  QuraanModel(
  {
     required this.number,
     required this.name,
     required this.englishName,
     required this.numberOfAyahs
  });

   
   
   Map<String, dynamic> toJson() => {
    'number': number,
    'name':name,
    'englishName': englishName,
    'numberOfAyahs':numberOfAyahs
  };

    factory QuraanModel.fromJson(Map<String, dynamic> json) {
    return QuraanModel(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      numberOfAyahs: json['numberOfAyahs'],

      );


  }
  
}