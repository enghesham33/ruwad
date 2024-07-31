import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<LeaderboardEntry> entries = [
    LeaderboardEntry(name: 'لينه البارودي', score: 1000),
    LeaderboardEntry(name: 'نور شاكر', score: 900),
    LeaderboardEntry(name: 'هبة حجازي', score: 800),
    LeaderboardEntry(name: 'أسيل العمري', score: 700),
    LeaderboardEntry(name: 'سارة الدوسري', score: 600),
  ];

  LeaderboardScreen({super.key});

  static String routeName = "LeaderBoard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لوحة الشرف'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(children: [
                      Positioned(
                          bottom: 0,
                          child: Container(
                            width: 126,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Palette.gray.withOpacity(0.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 16,),
                                Text("هبة حجازي",
                                    style: Theme.of(context).textTheme.bodyLarge),

                                Text("800",
                                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Palette.black)),
                              ],
                            ),
                          )),
                      Positioned(
                        top: 70,
                        // left: 0,
                        right: -5,
                        width: MediaQuery.of(context).size.width / 3,
                        child: Center(
                          child: CircleAvatar(
                            radius: 30,
                            child: Image.asset("assets/images/user.jpg"),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Stack(children: [
                      Positioned(
                          bottom: 0,
                          child: Container(
                            width: 126,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Palette.accentColor.withOpacity(0.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 16,),
                                Text("لينه البارودي",
                                    style: Theme.of(context).textTheme.bodyLarge),

                                Text("1000",
                                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Palette.primaryColor)),
                              ],
                            ),
                          )),
                      Positioned(
                        top: 20,
                        // left: 0,
                        right: -5,
                        width: MediaQuery.of(context).size.width / 3,
                        child: Center(
                          child: CircleAvatar(
                            radius: 30,
                            child: Image.asset("assets/images/user.jpg"),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Stack(children: [
                      Positioned(
                          bottom: 0,
                          child: Container(
                            width: 125,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Palette.gray.withOpacity(0.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 16,),
                                Text("نور شاكر",
                                    style: Theme.of(context).textTheme.bodyLarge),

                                Text("900",
                                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Palette.black)),
                              ],
                            ),
                          )),
                      Positioned(
                        top: 70,
                        // left: 0,
                        right: -5,
                        width: MediaQuery.of(context).size.width / 3,
                        child: Center(
                          child: CircleAvatar(
                            radius: 30,
                            child: Image.asset("assets/images/user.jpg"),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Card(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Palette.lightPrimaryColor,
                      child: Text(
                        entry.name[0].toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    title: Text(entry.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    trailing: SizedBox(
                      // width: 150,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Icon(Icons.keyboard_arrow_up, color: Colors.green,),
                          Text(entry.score.toString(),
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardEntry {
  final String name;
  final int score;

  LeaderboardEntry({required this.name, required this.score});
}
