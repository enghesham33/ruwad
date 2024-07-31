import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/authentication/view_model/authentication_view_model.dart';
import 'package:rawdat_hufaz/src/features/calls/data/models/call_request_model.dart';
import 'package:rawdat_hufaz/src/features/calls/presentation/screens/evaluator_call_screen.dart';
import 'package:rawdat_hufaz/src/features/calls/view_model/call_request_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_big_container.dart';
import 'package:rawdat_hufaz/src/shared/widgets/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});
  static String routeName = "RequestListScreen";

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CallRequestViewModel>().get();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
     appBar: AppBar(
       title: Text(AppLocalizations.of(context)!.current_requests),
     ),
     body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
       children: [
       
         Consumer<CallRequestViewModel>(
          builder: (context, watch, child) =>
           watch.isLoading
            ?  Center(
              child: Column
              (
                children: 
                [
                  Text(AppLocalizations.of(context)!.call_waiting_description,
                 style: Theme.of(context).textTheme.headlineLarge,
                 ),
                 Text(AppLocalizations.of(context)!.please_wait,
                 style: Theme.of(context).textTheme.headlineLarge,
                 ),
                 const CustomLoadingIndicator()
                   ],
                 ) )
            : Expanded(
              child: StreamBuilder<List<CallRequestModel>>(
                  stream: watch.dataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top:25, left: 10, right: 10),
                            child: CustomBigContainer
                            (
                              title: data[index].name,
                              color: index%2==0? Palette.lightAccentColor.withOpacity(0.7):Palette.primaryColor.withOpacity(0.7),
                              size: MediaQuery.of(context).size/2,
                              child: Column
                              (
                                children: 
                                [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text( data[index].quorum
                                  ),
                                ),
                                const SizedBox(height: 40,)
                                ],
                          
                              ),
                              onTap: () async
                              {
                               
                                //assign evaluator 
                                data[index].evaluatorId=AuthenticationViewModel.user!.personId!;
                                data[index].evaluatorName=AuthenticationViewModel.user!.name!;
                                var request =data[index];
                                watch.setRequest(request);
                                
                                await watch.assignEvaluator(   
                                evaluatorName: AuthenticationViewModel.user!.name!,
                                evaluatorId: AuthenticationViewModel.user!.personId!,)
                                .then((value) async 
                                {
                                 watch.notify();
                                 Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) =>  EvaluatorCallScreen(roomId:data[index].roomId ,)),
                                 );
                                });
                            
     
                              },
                          
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return const Center(child: CustomLoadingIndicator());
                    }
                  },
                ),
            ),
     ),
       ],
     ),
);

  }
}