import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/exams/data/models/types/question_type.dart';
import 'package:rawdat_hufaz/src/features/exams/view_model/questions_stepper_provider.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/home_screen.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../shared/alerts/custom_dialogs.dart';
import '../../data/models/question.dart';
import '../widgets/custom_answer_button.dart';
import 'exams_list_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({
    super.key,
    required this.examName,
    required this.questions,
    required this.onSubmitQuiz,
  });

  final String examName;
  final List<QuestionModel> questions;
  final Future<void> Function(
      {required List<QuestionModel> answeredQuestions,
      required BuildContext ctx}) onSubmitQuiz;

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late final QuestionsStepperProvider stepperProvider;
  final PageController _pageController = PageController();
  final List<TextEditingController?> controllers = [];

  @override
  void initState() {
    stepperProvider = Provider.of<QuestionsStepperProvider>(context, listen: false);
    Future.delayed(
        Duration.zero, () => stepperProvider.setQuestions(widget.questions));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onEndExam(
    BuildContext context,
    List<QuestionModel> answeredQuestions,
  ) async {
    final backNavigationAllowed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.end_exam_confirmation,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              AppLocalizations.of(context)!.no,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () async {
              CustomDialog(context).showLoadingSpinner();
              await widget.onSubmitQuiz(
                  answeredQuestions: answeredQuestions, ctx: context);
              Navigator.of(context).pop(true);
              Navigator.of(context).popUntil(
                ModalRoute.withName(HomeScreen.routeName),
                // ModalRoute.withName(ExamsListScreen.routeName),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.yes,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
    // if (backNavigationAllowed) {
    //   if (mounted) {
    //     print("you ARE HERE !!");
    //     Navigator.of(context).popUntil(
    //       ModalRoute.withName(ExamsListScreen.routeName),
    //     );
    //   }
    // }
  }

  Widget _backButton() {
    return stepperProvider.index >= 1 &&
            stepperProvider.index < widget.questions.length
        ? TextButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              stepperProvider.back(context);
            },
            child: Text(AppLocalizations.of(context)!.back,
                style: Theme.of(context).textTheme.bodyLarge),
          )
        : const SizedBox();
  }

  Widget _nextButton() {
    if (stepperProvider.index >= 0 &&
        stepperProvider.index < (stepperProvider.questionsCount - 1)) {
      return ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          stepperProvider.next(context);
        },
        child: Text(
          AppLocalizations.of(context)!.next,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Palette.white),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _submitButton(List<QuestionModel> answeredQuestions) {
    if (stepperProvider.index == (widget.questions.length - 1)) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).focusColor),
        ),
        onPressed: () async {
          await _onEndExam(context, answeredQuestions);
        },
        child: Text(
          AppLocalizations.of(context)!.submit,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Palette.white),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<QuestionsStepperProvider>(
      builder: (context, watch, _) {

        // Initialize controllers with initial values
        for (int i = 0; i < watch.questionsCount; i++) {
          if(watch.questions![i].type == QuestionType.written){
            controllers.add(TextEditingController(text: watch.questions![i].userAnswer ));
          }
        }

        return Scaffold(
        appBar: AppBar(
          title: Text(widget.examName),
          automaticallyImplyLeading: false,
        ),
        //body: Container(),
         body: PopScope(
           canPop: false,
           onPopInvoked: (didPop) async {
             await _onEndExam(context, watch.questions!);
           },
           child: SizedBox(
             width: MediaQuery.of(context).size.width,
             child: Flex(
               direction: Axis.vertical,
               children: [
                 Expanded(
                   flex: 1,
                   child: SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Container(
                       margin: const EdgeInsets.symmetric(horizontal: 24.0),
                       child: Row(
                         children: List.generate(
                           watch.questionsCount,
                           (index) => Row(
                             children: [
                               GestureDetector(
                                 child: CircleAvatar(
                                   backgroundColor: watch.index == index
                                       ? Theme.of(context).focusColor
                                       : watch.questions![index].isAnswered!
                                           ? Theme.of(context).primaryColor
                                           : Palette.gray,
                                   child: Text('${index + 1}',
                                       style: Theme.of(context)
                                           .textTheme
                                           .bodyLarge!
                                           .copyWith(
                                               decoration: watch
                                                       .questions![index]
                                                       .isAnswered!
                                                   ? null
                                                   : TextDecoration.underline,
                                               color:
                                                   Theme.of(context).canvasColor,
                                               decorationThickness: 4)),
                                 ),
                                 onTap: () {
                                   watch.goToStep(index, context);
                                   _pageController.animateToPage(
                                     index,
                                     duration: const Duration(milliseconds: 500),
                                     curve: Curves.easeInOut,
                                   );
                                 },
                               ),
                               if (index != watch.questionsCount - 1)
                                 Container(
                                   width: 80,
                                   height: 4,
                                   margin:
                                       const EdgeInsets.symmetric(horizontal: 8),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(4),
                                     color: watch.questions![index].isAnswered!
                                         ? Theme.of(context).primaryColor
                                         : Palette.gray,
                                   ),
                                 ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
                 Expanded(
                   flex: 6,
                   child: PageView(
                     scrollDirection: Axis.horizontal,
                     controller: _pageController,
                     onPageChanged: (value) {
                       watch.goToStep(value, context);
                     },
                     children: watch.questions!
                         .map(
                           (e) => SingleChildScrollView(
                             child: Padding(
                               padding: EdgeInsets.all(24.0.h),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.stretch,
                                 children: [
                                   Text(
                                     "${AppLocalizations.of(context)!.question} ${watch.index + 1}",
                                     style:
                                         Theme.of(context).textTheme.labelMedium,
                                   ),
                                   const SizedBox(
                                     height: 16,
                                   ),
                                   Text(
                                     watch.questions![watch.index].text!,
                                     style:
                                         Theme.of(context).textTheme.bodyLarge,
                                   ),
                                   const SizedBox(
                                     height: 16,
                                   ),
                                   if (watch.questions![watch.index].type == QuestionType.choices)
                                   ...List.generate(
                                     watch.questions![watch.index].answers!.length,
                                     (answerIndex) => CustomAnswerButton(
                                       onPressed: () {
                                         watch.answerQuestion(answer: answerIndex.toString());
                                       },
                                       answer: watch.questions![watch.index].answers![answerIndex],
                                       selected: watch.questions![watch.index].userAnswer == answerIndex.toString(),
                                     ),
                                   ),
                                   if (watch.questions![watch.index].type == QuestionType.written)
                                     TextField(
                                       controller: controllers[watch.index],
                                       maxLines: 3,
                                       decoration: const InputDecoration(
                                         border: OutlineInputBorder(),
                                       ),
                                       onChanged: (value){
                                         watch.answerQuestion(answer: value);
                                       },
                                     ),
                                 ],
                               ),
                             ),
                           ),
                         )
                         .toList(),
                   ),
                 )
               ],
             ),
           ),
         ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(24.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _backButton(),
              stepperProvider.index == (widget.questions.length - 1)
                  ? _submitButton(watch.questions!)
                  : _nextButton(),
            ],
          ),
        ),
      );
      },
    );
  }
}
