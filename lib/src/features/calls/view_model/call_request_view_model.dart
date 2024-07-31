import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/call_request_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/mistake_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/oral_assesment_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/test.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/week_assesment_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/repositories/assesment_repository.dart';
import 'package:rawdat_hufaz/src/features/calls/data/repositories/supabase_repository.dart';
import '../../../shared/di/get_di.dart' as di;


class CallRequestViewModel extends ChangeNotifier{
  List<CallRequestModel> list= [];

  static CallRequestModel? _request;
  StreamSubscription<CallRequestModel?>? _requestSubscription;

  late final StreamController<List<CallRequestModel>> _dataStreamController = StreamController<List<CallRequestModel>>.broadcast();
  bool _loading = false;

  Stream<List<CallRequestModel>> get dataStream => _dataStreamController.stream;

  CallRequestModel? get request => _request;

  bool get isLoading => _loading;
  

changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

 Future<void> get() async {

  changeLoadingStatus(true);

   final data = await di.getItInstance<SupabaseRepository>().readRealTime();
   data.listen((event) 
   {
     list.clear();
     for (var element in event) {
       var value =CallRequestModel.fromJson(element);
       list.add(value);
       _dataStreamController.add(list);
     }
   //list=[];
    notifyListeners(); 
   });
    changeLoadingStatus(false);
  }

 Future<void>create({required examId, required quorum, required isOralAssesment }) async
 {
   var roomId=AuthenticationViewModel.user!.personId!+DateTime.now().microsecond.toString();
    var request= CallRequestModel(
    name:  AuthenticationViewModel.user!.firstName!,
    userId: AuthenticationViewModel.user!.personId!,
    gender: AuthenticationViewModel.user!.gender.toString(),
    weekId: examId,
    quorum: quorum,
    roomId: roomId,
    soundsMistakes: 0,
    memorizeMistakes: 0,
    isOralAssesmant: isOralAssesment);
   await di.getItInstance<SupabaseRepository>().addRequest(request: request).then((value)
   {
     setRequest(request);
   });
 }

Future<void>assignEvaluator({ required String evaluatorName, required String evaluatorId}) async
 {
   String userId = request!.userId.toString();
   await di.getItInstance<SupabaseRepository>().assignEvaluator(userId: userId,evaluatorName:evaluatorName ,evaluatorId: evaluatorId);
   //notifyListeners();
 }

 void notify()
 {
  notifyListeners();
 }

Future<void>updateMemorizeMistakes({ required int count}) async
 {
   String userId = request!.userId.toString();
   await di.getItInstance<SupabaseRepository>().updateMemorizeMistakes(userId: userId,count: count);
   notifyListeners();
 }

 Future<void>updateSoundMistake({ required int count}) async
 {
   String userId = request!.userId.toString();
   await di.getItInstance<SupabaseRepository>().updateSoundMistake(userId: userId,count: count);
   notifyListeners();
 }

Future<void> listenToAcceptedUserRequest(String userId) async{
    _requestSubscription?.cancel();
    _requestSubscription = await di.getItInstance<SupabaseRepository>()
        .getAcceptedUserRequestStream(userId)
        .then((data) {
          data.listen((event) 
          {
           _request=event;
          notifyListeners(); 
          });
        });
  }

void setRequest(CallRequestModel request)
  {
    _request=request;
    listenToAcceptedUserRequest(_request!.userId);
  }

Future<void>delete(String userId) async
 {
   //String userId = request!.userId.toString();
   await di.getItInstance<SupabaseRepository>().delete(userId: userId);
   
 }


Future submitExam() async 
{
  if(request!.isOralAssesmant) {
    await submitOralExam();
  } 
  else submitWeeklyExam();
}

Future submitOralExam() async
{
  List<MistakeModel> mistakes = [];
  mistakes.add(MistakeModel(type: MistakeType.memorization.toString(), count: request!.memorizeMistakes!));
  var assessment = OralAssesmentModel
  (
    evaluaterID: int.parse(request!.evaluatorId!),
    personID: int.parse(request!.userId),
    examID: int.parse(request!.weekId.toString()),//todo
    mistakes: mistakes
  );
  
  await di.getItInstance<AssesmentRepository>().postOralAssesment(evaluation: assessment);
}


Future submitWeeklyExam() async
{
  List<MistakeModel> mistakes = [];
  mistakes.add(MistakeModel(type: MistakeType.memorization.toString(), count: request!.memorizeMistakes!));
    mistakes.add(MistakeModel(type: MistakeType.missSpelling.toString(), count: request!.soundsMistakes!));

  var assessment = WeekAssesmentModel
  (
    evaluaterID: int.parse(request!.evaluatorId!),
    weeklyTaskID: int.parse(request!.weekId.toString()),//todo
    mistakes: mistakes
  );
  
  await di.getItInstance<AssesmentRepository>().postWeekAssesment(evaluation: assessment);
}


@override
void dispose() async {
   await delete(request!.userId.toString());
   super.dispose();
}
}