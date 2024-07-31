import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/features/exams/data/models/question.dart';
import 'package:rawdat_hufaz/src/features/exams/data/repositories/exams_repository.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/home_view_model.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_dialogs.dart';
import 'package:rawdat_hufaz/src/shared/errors/exceptions.dart';
import '../../../shared/api/api_keys.dart';
import '../../../shared/di/get_di.dart' as di;
import '../data/models/exam.dart';
import '../data/models/exams_summary.dart';
import '../data/models/types/exam_status.dart';
import '../data/models/types/exam_type.dart';
import '../data/models/types/question_type.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ExamsViewModel extends ChangeNotifier {
  static ExamsSummaryModel? _examsSummary;
  static List<ExamModel> _exams = [];
  static ExamModel? _exam;
  static List<QuestionModel> _questions = [];
  bool _loadingExams = false;
  bool _loadingExamDetails = false;

  ExamsSummaryModel get examsSummary => _examsSummary!;

  List<ExamModel> get exams => [..._exams];

  ExamModel? get exam => _exam;

  List<QuestionModel> get questions => [..._questions];

  bool get isLoadingExams => _loadingExams;

  bool get isLoadingExamDetails => _loadingExamDetails;

  bool get showAttemptExamButton {
    return !(_exam!.isDone!) &&
        (_exam!.isActive!) &&
        (_exam!.type == ExamType.mawdoaat ||
            _exam!.type == ExamType.mutshabhat);
  }

  changeExamsLoadingStatus(bool loadingStatus) {
    _loadingExams = loadingStatus;
    notifyListeners();
  }

  changeExamDetailsLoadingStatus(bool loadingStatus) {
    _loadingExamDetails = loadingStatus;
    notifyListeners();
  }

  Future<void> loadExams({
    required context,
  }) async {
    try {
      changeExamsLoadingStatus(true);

      if (HomeViewModel.level?.id == null) {
        throw GeneralExceptions(message: AppLocalizations.of(context)!.message_title_activate_level );
      }

      final data =
          await di.getItInstance<ExamsRepository>().getExamsAndScores();
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(message: data[ApiKeys.message] );
      }

      _examsSummary = ExamsSummaryModel.fromJson(data);
      _exams = (data["exams"] as List).map((exam) {
        return ExamModel.fromJson(json: exam);
      }).toList();

      changeExamsLoadingStatus(false);
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeExamsLoadingStatus(false);
    }
  }

  loadExamDetails({required context, required int examId}) async {
    try {
      changeExamDetailsLoadingStatus(true);

      final data = await di.getItInstance<ExamsRepository>().getExamDetails(
            examID: examId,
          );
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(message: data[ApiKeys.message]);
      }

      _exam = ExamModel.fromJson(json: data, examID: examId);

      if(_exam!.type! == ExamType.mutshabhat){
        print("data['questions'] ==> ${data["questions"]}");
      }

      _questions = (data["questions"] as List).map((questionData) {
        // print("ExamsViewModel ==> $questionData");
        return QuestionModel.fromJson(json: questionData);
      }).toList();

      changeExamDetailsLoadingStatus(false);
    } catch (e) {
      CustomDialog(context).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeExamDetailsLoadingStatus(false);
    }
  }

  Future<void> submitExam(
      {required List<QuestionModel> answeredQuestions,
      required ctx}) async {
    try {
      changeExamsLoadingStatus(true);

      List<QuestionModel> submitData = [...answeredQuestions];
      for (var question in submitData) {
          if(question.type == QuestionType.choices){
            question.userAnswer = (int.parse(question.userAnswer) + 1).toString() ;
          }
      }

      final data = await di.getItInstance<ExamsRepository>().submitExam(
          answers: submitData.map((e) => e.toJson()).toList());
      if (data[ApiKeys.code] == ApiValues.failedCode) {
        throw GeneralExceptions(message: data[ApiKeys.message]);
      }
      changeExamsLoadingStatus(false);
    } catch (e) {
      CustomDialog(ctx).showMessage(
        message: Errors.getErrorMessage(exception: e),
      );
    } finally {
      changeExamsLoadingStatus(false);
    }
  }

  // ========== filter controller ========== //
  static bool _showAll = true;
  static List<ExamStatus> _selectedExamStatuses = [..._examStatus];
  static List<ExamType> _selectedExamTypes = [..._examTypes];
  static final List<ExamStatus> _examStatus = [
    ExamStatus.future,
    ExamStatus.available,
    ExamStatus.pendingGrading,
    ExamStatus.graded,
    ExamStatus.missed,
  ];
  static final List<ExamType> _examTypes = [
    ExamType.ayat,
    ExamType.mawdoaat,
    ExamType.mutshabhat,
    ExamType.review
  ];

  bool get showAll => _showAll;

  List<ExamStatus> get examsStatusList => _examStatus;

  List<ExamStatus> get selectedExamStatuses => _selectedExamStatuses;

  List<ExamType> get examsTypeList => _examTypes;

  List<ExamType> get selectedExamTypes => _selectedExamTypes;

  List<ExamModel> get filteredExams {
    if (showAll) {
      return _exams;
    }
    return _exams.where((exam) {
      return _selectedExamStatuses.contains(exam.status) ||
          _selectedExamTypes.contains(exam.type);
    }).toList();
  }

  selectStatus(ExamStatus status) {
    if (showAll) {
      _showAll = false;
    }
    if (_selectedExamStatuses.contains(status)) {
      _selectedExamStatuses.remove(status);
      notifyListeners();
      return;
    }
    _selectedExamStatuses.add(status);
    notifyListeners();
  }

  selectType(ExamType type) {
    if (showAll) {
      _showAll = false;
    }
    if (_selectedExamTypes.contains(type)) {
      _selectedExamTypes.remove(type);
      notifyListeners();
      return;
    }
    _selectedExamTypes.add(type);
    notifyListeners();
  }

  selectAll() {
    if (showAll) {
      _showAll = false;
      _selectedExamStatuses = [];
      _selectedExamTypes = [];
      notifyListeners();
      return;
    }
    _showAll = true;
    _selectedExamStatuses = [..._examStatus];
    _selectedExamTypes = [..._examTypes];
    notifyListeners();
    return;
  }
}
