import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/profile/presentation/widgets/custom_update_profile_form.dart';
import '../../view_model/profile_view_model.dart';
import '../widgets/custom_levels_widget.dart';
import '../widgets/custom_user_info_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String routeName = "ProfileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late final ProfileViewModel profileViewModel;

  @override
  initState() {
    profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    Future.delayed(
      Duration.zero,
      () => profileViewModel.loadProfileData(context: context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProfileViewModel>(
      builder: (context, watch, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.profile,
            ),
            elevation: 0,
          ),
          body:  watch.isLoading || watch.user == null
                ? SizedBox(
                    height: size.height * 0.8,
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : ListView(
                    children: [
                      const SizedBox(height: 24,),
                      CustomUserInfoTile(user: watch.user, size: size),
                      CustomLevelsList(levels: watch.levels, size: size),
                    ],
                  ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: const CustomUpdateProfileForm()
      ),
    );
  }
}