
class BatchModel {
  num? id;
  num? number;
  String? name;
  String? description;

  BatchModel({required this.id, required this.number, required this.name, required this.description});

  BatchModel.fromJson({required Map<String, dynamic> json}){
    id = json["id"];
    number = json["batch_number"];
    name = json["name"];
    description = json["description"] ?? "";
  }
}