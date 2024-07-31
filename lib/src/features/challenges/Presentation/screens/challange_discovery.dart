import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallangeDicovery extends StatefulWidget {
  const ChallangeDicovery({super.key});

  static String routeName = "ChallangeDicovery";

  @override
  State<ChallangeDicovery> createState() => _ChallangeDicoveryState();
}

class _ChallangeDicoveryState extends State<ChallangeDicovery> {
  List<ChallangeDicoveryModel> newChallanges = [
    ChallangeDicoveryModel(
        title: 'تحدي متشابهات سورة البقرة', points: 15, level: 'مستوى متوسط'),
    ChallangeDicoveryModel(
        title: 'تحدي آيات سورة النمل', points: 10, level: 'مستوى مبتدئ'),
    ChallangeDicoveryModel(
        title: 'تحدي أحكام سورة النساء', points: 30, level: 'مستوى متقدم'),
    ChallangeDicoveryModel(
        title: 'تحدي متشابهات سورة هود', points: 15, level: 'مستوى متوسط'),
    ChallangeDicoveryModel(
        title: 'تحدي أحكام سورة الأنفال', points: 15, level: 'مستوى متوسط'),
  ];

  final List<String> filterItem = [
    'الكل',
    'متشابهات',
    'آيات',
    'موضوعات',
  ];
  List<String> selectedfilterItem = ['الكل'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التحديات'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'التحديات الجديدة',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            CarouselSlider.builder(
              itemCount: newChallanges.length,
              itemBuilder: (context, index, realIndex) {
                return InkWell(
                  onTap: () {},
                  child: NewChallangeContainer(model: newChallanges[index]),
                );
              },
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                initialPage: 0,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.easeOut,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                viewportFraction: 0.50,
                scrollDirection: Axis.horizontal,
                pauseAutoPlayOnTouch: true,
              ),
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'التحديات المفتوحة',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            filter(context),
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //primary: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
                itemCount: newChallanges.length,
                itemBuilder: (context, index) {
                  var item = newChallanges[index];
                  return GestureDetector(
                    child: Card(
                      elevation: 2,
                      shadowColor: Palette.gray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      // color: item.type.color,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(item.title,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('عدد المشاركين'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                  child: Text((item.points - 5).toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Palette.orange,
                                      ),
                                  ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${item.points}',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge,
                                ),
                                Lottie.asset('assets/Animated-star.json',
                                    height: 20, width: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("MultiplayerChallengeWidget");
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  SizedBox filter(BuildContext context) {
    return SizedBox(
      // height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: filterItem
              .map((e) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FilterChip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        selectedColor: Palette.lightOlive,
                        label: SizedBox(
                            width: 90,
                            height: 40,
                            child: Center(
                                child: Text(e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium))),
                        selected: selectedfilterItem.contains(e),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              if (e == 'الكل') {
                                selectedfilterItem
                                    .removeWhere((element) => true);
                              }
                              selectedfilterItem.add(e);
                            } else {
                              selectedfilterItem.remove(e);
                            }
                          });
                        }),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class NewChallangeContainer extends StatelessWidget {
  final ChallangeDicoveryModel model;

  const NewChallangeContainer({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Stack(fit: StackFit.passthrough, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${model.points} نقاط',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    model.level,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('ابدأ'),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ChallangeDicoveryModel {
  final String title;
  final int points;
  final String level;

  ChallangeDicoveryModel(
      {required this.title, required this.points, required this.level});
}
