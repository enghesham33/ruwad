class CallRequestModel
{
   final String name;
   final String userId;
   final String gender;
   final num? weekId; //used as examId in oral assesment and weeklt task id in weekly assesment
   final String quorum;
   final String roomId;
   late String? evaluatorId;
   late String? evaluatorName;
   final int? memorizeMistakes;
   final int? soundsMistakes;
   final bool isOralAssesmant;

  CallRequestModel(
    {
       required this.name,
       required this.userId,
       required this.gender,
       required this.weekId, 
       required this.quorum, 
       required this.roomId,
       this.evaluatorId,
       this.evaluatorName,
       this.memorizeMistakes,
       this.soundsMistakes,
       required this.isOralAssesmant

    });

   
   
   Map<String, dynamic> toJson() => {
    'name': name,
    'userId':userId,
    'gender': gender,
    'weekId':weekId,
    'quorum': quorum,
    'roomId':roomId,
    'evaluatorId':evaluatorId,
    'evaluatorName':evaluatorName,
    'memorizeMistakes':memorizeMistakes,
    'soundsMistakes':soundsMistakes,
    'isOralAssesmant':isOralAssesmant


  };

    factory CallRequestModel.fromJson(Map<String, dynamic> json) {
    return CallRequestModel(
      name: json['name'],
      userId: json['userId'],
      gender: json['gender'],
      weekId: json['weekId'],
      quorum: json['quorum'],
      roomId:json['roomId'],
      evaluatorId:json['evaluatorId'],
      evaluatorName:json['evaluatorName'],
      memorizeMistakes:json['memorizeMistakes'],
      soundsMistakes:json['soundsMistakes'],
      isOralAssesmant:json['isOralAssesmant']
      
    );


  }
 
}



