import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/presentation/widgets/custom_gender_picker.dart';
import 'package:rawdat_hufaz/src/features/authentication/presentation/widgets/custom_phone_input.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/registration_view_model.dart';
import 'package:rawdat_hufaz/src/shared/alerts/custom_snack_bar.dart';
import 'package:rawdat_hufaz/src/shared/widgets/buttons/custom_main_button.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';

import '../../../../shared/enums.dart';
import '../widgets/custom_birth_year_picker.dart';
import '../widgets/custom_registration_password_input.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static String routeName = "Registration";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {

  late final RegistrationViewModel registrationViewModel;
  final formKey = GlobalKey<FormState>();
  int _index = 0;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    registrationViewModel = Provider.of<RegistrationViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () => registrationViewModel.loadRegistrationData(context: context) );
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  static validateName(String? name, BuildContext context) {
    if (name != null && name != '') {
      RegExp regex = RegExp(r'[a-zA-Zء-ي]');
      if (!regex.hasMatch(name)) {
        return AppLocalizations.of(context)!.validation_format_name;
      }
      if (name.length < 2) {
        return AppLocalizations.of(context)!.validation_format_name;
      }
    } else {
      return AppLocalizations.of(context)!.validation_required;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          opacity: 1,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Consumer<RegistrationViewModel>(
              builder: (context, watch, child) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.registration,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8,),
                  Theme(
                    data: ThemeData(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        secondary: Theme.of(context).focusColor,
                        primary: Theme.of(context).focusColor,
                      ),
                      focusColor: Theme.of(context).focusColor,
                    ),
                    child: Stepper(
                      physics: const NeverScrollableScrollPhysics(),
                      onStepTapped: (int index) {
                        setState(() {
                          _index = index;
                        });
                      },
                      controlsBuilder: (context, _) {
                        return const SizedBox();
                      },
                      currentStep: _index,
                      steps: <Step>[
                        // ==================== Name Step ==================== //
                        Step(
                          state: _index == Steps.name.index ? StepState.editing : StepState.indexed,
                          isActive: _index == Steps.name.index,
                          title: Text(
                            AppLocalizations.of(context)!.name,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          content: Column(
                            children: [
                              TextFormField(
                                cursorColor: Theme.of(context).focusColor,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.first_name,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                ),
                                validator: (String? name) => validateName(name, context),
                                keyboardType: TextInputType.name,
                                controller: firstNameController,
                                maxLength: 50,
                                maxLines: 1,
                                onSaved: (value){
                                  watch.setFirstName(name: value!);
                                },
                              ),
                              TextFormField(
                                cursorColor: Theme.of(context).focusColor,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.last_name,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                ),
                                validator: (String? name) => validateName(name, context),
                                keyboardType: TextInputType.name,
                                controller: lastNameController,
                                maxLength: 50,
                                maxLines: 1,
                                onSaved: (value){
                                  watch.setLastName(name: value!);
                                },
                              ),
                            ],
                          ),
                        ),
                        // ==================== phone Step ==================== //
                        Step(
                          state: _index == Steps.phone.index ? StepState.editing : StepState.indexed,
                          isActive: _index == Steps.phone.index,
                          title: Text(
                            AppLocalizations.of(context)!.phone,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          content: CustomPhoneInput(
                              phoneController: phoneController,
                              onSaved:  (value) {
                                watch.setPhoneNumber(phoneNumber: value);
                              },
                          ),
                        ),
                        // ==================== password Step ==================== //
                        Step(
                          state: _index == Steps.password.index ? StepState.editing : StepState.indexed,
                          isActive: _index == Steps.password.index,
                          title: Text(
                            AppLocalizations.of(context)!.password,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          content: CustomRegistrationPasswordInput(
                            passwordController: passwordController,
                            confirmPasswordController: confirmPasswordController,
                            onSaved:  (value) {
                              watch.setPassword(password: value);
                            },
                          ),
                        ),
                        // ==================== password Step ==================== //
                        Step(
                          state: _index == Steps.birthDate.index ? StepState.editing : StepState.indexed,
                          isActive: _index == Steps.birthDate.index,
                          title: Text(
                            AppLocalizations.of(context)!.birth_year,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          content: Center(
                            child: CustomBirthYearPicker(
                              context: context,
                              value: watch.birthDate.year,
                              onChanged: (value) {
                                watch.setBirthDate(birthDate: DateTime(value));
                              },
                            ),
                          ),
                        ),
                        // ==================== gender Step ==================== //
                        Step(
                            state: _index == Steps.gender.index ? StepState.editing : StepState.indexed,
                            isActive: _index == Steps.gender.index,
                            title: Text(
                              AppLocalizations.of(context)!.gender,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            content: Center(
                              child: CustomGenderPicker(
                                initialValue: watch.gender,
                                context: context,
                                size: size,
                                onSaved: (value) {
                                  watch.setGender(gender: value);
                                },
                              ),
                            )
                        ),
                        // ==================== batch Step ==================== //
                        Step(
                          state: _index == Steps.batch.index ? StepState.editing : StepState.indexed,
                          isActive: _index == Steps.batch.index,
                          title: Text(
                            AppLocalizations.of(context)!.plans,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          content: Column(
                            children: [
                              ...watch.batches!.map((batch) => Row(
                                children: [
                                  Checkbox(
                                    value: watch.batchId == batch.id,

                                    onChanged: (value){
                                      watch.setBatchId(batchId: batch.id!);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      batch.name!,
                                      style: Theme.of(context).textTheme.bodyLarge
                                    ),
                                  ),
                                ],
                              ),
                              ).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  CustomMainButton(
                    title: AppLocalizations.of(context)!.submit_registration,
                    child: watch.isLoading
                        ? SizedBox(
                            width: 30.h,
                            height: 30.h,
                            child: const CustomLoadingIndicator(),
                          )
                        : null,
                    onPress: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        await watch.registerUser(context: context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar.warning(
                            error: AppLocalizations.of(context)!.message_registration_required_fields,
                            context: context,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}