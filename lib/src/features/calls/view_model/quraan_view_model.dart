import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/quraan_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/repositories/quraan_repository.dart';
import '../../../shared/di/get_di.dart' as di;

class QuranProvider with ChangeNotifier {
  List<QuraanModel> _surahs = [];
  bool _loading = false;
  bool get isLoading => _loading;

  List<QuraanModel> get surahs => _surahs;

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

Future<void> fetchQuraanSourah() async { 
   changeLoadingStatus(true);
final responseData = await di.getItInstance<QuraanRepository>().getQuraansurah();
if (responseData['data'] != null) {
  final surahsData = List<Map<String, dynamic>>.from(responseData['data']);
  _surahs = surahsData.map((surahData) => QuraanModel.fromJson(surahData)).toList();
}

   changeLoadingStatus(false);
  }
  
}
