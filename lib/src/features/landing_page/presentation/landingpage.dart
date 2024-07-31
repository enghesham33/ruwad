import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/widgets/custom_day_date_row.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/daily_tasks_view_model.dart';
import 'package:rawdat_hufaz/src/features/home/view_model/home_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:rawdat_hufaz/src/shared/widgets/drawer/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  static String routeName = "Landingpage";

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController textController = TextEditingController();
 final List<String> filter=
  [
    'مراجعة',
    'إجازات قرآن',

  ];
   List<String> selectedList=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.5,
            title: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Consumer<HomeViewModel>(
                builder: (context, watch, child) => Text(
                  watch.currentLevel?.name ?? AppLocalizations.of(context)!.rawdat_alhufaz,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
           
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column
              (
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: 
             [
             
             Padding(
               padding: const EdgeInsets.only(top:30, bottom: 60, right: 20, left: 20),
               child: CustomDayDateRow(date:DateTime.now()),
               
             ),
             Container(
              decoration:const BoxDecoration
              (
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.black12
              ),
              height: 330,
              width: 400,
             child:  Padding(
               padding: EdgeInsets.all(8.0),
               child: Column
               (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: 
                [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('حلقاتي', 
                    style: Theme.of(context).textTheme.displayLarge,),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                  
                      children: 
                      [
                        MyCard(),
                        MyCard(),
                      ],
                  
                    ),
                  ),
                  
                  

                ],
               ),
             ),
             ),
             Padding(
                    padding: const EdgeInsets.only(top:40),
                    child: Text('استكشف مراكز التحفيظ', 
                    style: Theme.of(context).textTheme.displayLarge,),
                  ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimSearchBar(
                           width: 300,
                           textController: textController,
                           onSubmitted: (x){},
                           helpText: 'البحث',
                           onSuffixTap: () {
                          setState(() {
                            textController.clear();
                           });
                           }),
                    ),
                    ...filter.map((e) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FilterChip(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(16), ),
                    selectedColor: Palette.accentColor,
                     label: SizedBox(
                      width: 80,
                      height: 30,
                      child: Center(child: Text(e,style: Theme.of(context).textTheme.labelMedium))),
                     selected: selectedList.contains(e),
                     onSelected: (selected)
                     {
                      setState(() {
                      if(selected)
                      {
                        selectedList.add(e);
                      }
                      else
                      {
                        selectedList.remove(e);

                      }
                      });
                     }),
                  )),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                 return Card
                 (
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: 
                    [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text('مراجعة',style: Theme.of(context).textTheme.labelSmall),
                           ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text('دار الهداية',style: Theme.of(context).textTheme.headlineLarge)),
                          
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          "assets/images/dar1.jpg",
                          fit: BoxFit.fill,
                             height: 100,
                             width: 100,
                         ),
                                  ),
                      ),
                    ],
                  ),
                  );
                  }
                  ),
              )
             ],
              ),
          )
        );
  }



}

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Palette.accentColor.withOpacity(0.8),
      elevation: 4.0,
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: ()
              {
                Navigator.of(context).pushNamed("Home");

              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  "assets/images/dar1.jpg",
                  fit: BoxFit.fill,
                     height: 150,
                  width: 150,
                 ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'دار الذكر',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}