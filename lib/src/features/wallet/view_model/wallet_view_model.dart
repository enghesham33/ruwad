import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/wallet/data/models/wallet_card.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/api/api_keys.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../data/repositories/wallet_repository.dart';
import '../../../shared/di/get_di.dart' as di;

class WalletViewModel extends ChangeNotifier {
  static num? _points;
  static List<WalletCardModel> _cards = [];
  static WalletCardModel _selectedCard = _cards[0];
  static int _position = 0;
  bool _loading = false;

  num? get points => _points;
  List<WalletCardModel> get cards => [..._cards];
  WalletCardModel get selectedCard => _selectedCard;
  int get position => _position;
  bool get isLoading => _loading;

  changeLoadingStatus(bool loadingStatus) {
    _loading = loadingStatus;
    notifyListeners();
  }

  onVerticalDragUpdate({required double height}) {
    if (_position < height * 0.2) {
      _position = _position + 3;
      notifyListeners();
    }
  }

  onVerticalDragEnd({required double height}) {
    _position = 0;
    notifyListeners();
  }

  onTapCard({required WalletCardModel card}) {
    _selectedCard = card;
    _cards.remove(card);
    _cards.insert(0, card);
    notifyListeners();
  }

  Future<void> loadWallet({
    required context,
  }) async {
    try {
      changeLoadingStatus(true);

      final data = await di.getItInstance<WalletRepository>().loadWallet();
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(message: data[ApiKeys.message]);
      }

      _points = data["totalCredits"];

      _cards = (data["cards"] as List).map((exam) {
        return WalletCardModel.fromJson(json: exam);
      }).toList();

      changeLoadingStatus(false);
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeLoadingStatus(false);
    }
  }
}
