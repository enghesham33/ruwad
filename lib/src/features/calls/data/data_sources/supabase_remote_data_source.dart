import 'dart:async';

import 'package:rawdat_hufaz/src/features/calls/data/models/call_request_model.dart';
import 'package:rawdat_hufaz/src/shared/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRemoteDataSource {
  late final SupabaseClient _client;

  SupabaseRemoteDataSource()
  {
    _client=SupabaseClient(Constants.supabaseURL,Constants.supabaseAnonKey);
  }

  late final StreamController<List<Map<String, dynamic>>> _dataStreamController =
                                                           StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get dataStream => _dataStreamController.stream;

  Future<void> readRealTime() async {
    try {
      final stream = _client
          .from(Constants.supabaseCollectionName)
          .stream(primaryKey: ['id'])
          .order('created_at')
          .limit(100)
          .listen((snapshot) {
            final filteredSnapshot = snapshot.where((record) => record['evaluatorId'] == null).toList();
            _dataStreamController.add(filteredSnapshot);
           //_dataStreamController.add(snapshot);
      });

      stream.onError((error) {
        print('Real-time stream error: $error');
      });

    } catch (ex) {
      throw Exception('Failed to fetch records: ${ex.toString()}');
    }
  }
 
  Future<void> initialize() async {
    await Supabase.initialize(
      url: Constants.supabaseURL,
      anonKey: Constants.supabaseAnonKey,
    );
        _client=SupabaseClient(Constants.supabaseURL,Constants.supabaseAnonKey);

  }
    
  Future<void> create(Map<String, dynamic> data) async 
  {
    await _client.from(Constants.supabaseCollectionName).insert(data);
   
  }

 Future<void> assignEvaluator(String userId, String evaluatorName, String evaluatorId) async {
  try {
    // Prepare the data to update
    final dataToUpdate = {
      'evaluatorName': evaluatorName,
      'evaluatorId': evaluatorId,
    };

   
        await _client
        .from(Constants.supabaseCollectionName)
        .update(dataToUpdate)
        .eq('userId', userId); 
        
  } catch (ex) {
    throw Exception('Failed to update evaluator info: ${ex.toString()}');
  }
}

 Future<void> updateSoundMistake(String userId,int count) async {
  try {
    final dataToUpdate = {
      'soundsMistakes': count,
    };

     await _client
        .from(Constants.supabaseCollectionName)
        .update(dataToUpdate)
        .eq('userId', userId); 

  } catch (ex) {
    throw Exception('Failed to update evaluator info: ${ex.toString()}');
  }
}

 Future<void> updateMemorizeMistakes(String userId,int count) async {
  try {

    final dataToUpdate = {
      'memorizeMistakes': count,
    };

        await _client
        .from(Constants.supabaseCollectionName)
        .update(dataToUpdate)
        .eq('userId', userId); 

  } catch (ex) {
    throw Exception('Failed to update evaluator info: ${ex.toString()}');
  }
}


  Future<List<Map<String, dynamic>>> read() async 
  {
    try
    {
     //final response = await _client.from(Constants.supabaseCollectionName).select();

      final stream = _client
      .from(Constants.supabaseCollectionName)
      .stream(primaryKey: ['id'])
      .order('created_at')
      .limit(100)
      .listen((snapshot) {
        print('snapshot: $snapshot');
      });
      List<Map<String, dynamic>> response=[];
      stream.onData((data) =>response=data);
      return response;

    }catch(ex)
    {
      throw Exception('Failed to fetch records: ${ex.toString()}');
    }
    
  }

  Future<void> delete(String userId) async {
    try
    {
     await _client.from(Constants.supabaseCollectionName).delete().eq('userId', userId);
    }
    catch (ex) {
    throw Exception('Failed to update evaluator info: ${ex.toString()}');
  }
  }

Stream<CallRequestModel?> getAcceptedUserRequestStream(String userId) {
  return _client
      .from(Constants.supabaseCollectionName)
      .stream(primaryKey: ['id']).eq('userId', userId)
      .order('created_at', ascending: false)
      .limit(1)
      .execute()
      .map((List<dynamic> dataList) {
        if (dataList.isNotEmpty && dataList[0]['evaluatorId'] != null) {
          return CallRequestModel.fromJson(dataList[0] as Map<String, dynamic>);
        }
        return null;
      });
}


  void dispose() {
    _dataStreamController.close();
  }
}
