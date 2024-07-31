

import 'package:rawdat_hufaz/src/features/calls/data/data_sources/supabase_remote_data_source.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/call_request_model.dart';
import 'package:rawdat_hufaz/src/shared/connectivity_checker.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';

class SupabaseRepository {
  SupabaseRepository({
    required this.remoteDataSource,
    required this.connectivity,
  });

  final ConnectivityChecker connectivity;
  final SupabaseRemoteDataSource remoteDataSource;

  Future<Stream<List<Map<String, dynamic>>>> readRealTime() async {
    if (await connectivity.isNotConnected) {
      throw NetworkException();
    }
    try
    {
     await remoteDataSource.readRealTime();
      return  remoteDataSource.dataStream;
    }catch(ex)
    {
        return remoteDataSource.dataStream;
    }
  
  }

  Future<void> addRequest({required CallRequestModel request}) async
  {
    await remoteDataSource.create(request.toJson());
  }

Future<Stream<CallRequestModel?>> getAcceptedUserRequestStream(String userId) async {
  if (await connectivity.isNotConnected) {
    throw NetworkException();
  }
  return remoteDataSource.getAcceptedUserRequestStream(userId);
}

  Future<void> assignEvaluator({required String userId, required String evaluatorName, required String evaluatorId}) async
  {
    await remoteDataSource.assignEvaluator(userId,evaluatorName,evaluatorId);
  }

  Future<void> updateMemorizeMistakes({required String userId, required int count}) async
  {
    await remoteDataSource.updateMemorizeMistakes(userId,count);
  }

  Future<void> updateSoundMistake({required String userId, required int count}) async
  {
    await remoteDataSource.updateSoundMistake(userId,count);
  }

  Future<void> delete({required String userId}) async
  {
    await remoteDataSource.delete(userId);
  }

}
