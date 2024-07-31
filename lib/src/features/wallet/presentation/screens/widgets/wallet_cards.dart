import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/home/presentation/screens/home_screen.dart';
import 'package:rawdat_hufaz/src/features/settings/view_model/settings_view_model.dart';
import 'package:rawdat_hufaz/src/features/wallet/view_model/wallet_view_model.dart';
import 'package:rawdat_hufaz/src/shared/themes/app_styles.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';
import '../../../data/models/wallet_card.dart';

class WalletCards extends StatelessWidget{
  const WalletCards(
      {super.key,
      required this.cards,
      required this.position,
      });

  final List<WalletCardModel> cards;
  final int position;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: _buildCards(size, context),
    );
  }

  List<Widget> _buildCards(Size size, BuildContext context) {
    List<Widget> tempCards = [];
    List<WalletCardModel> reversedCards = List.from(cards.reversed);
    for (int i = 0; i < reversedCards.length; i++) {
      WalletCardModel card = reversedCards[i];
      tempCards.add(
        Positioned(
          width: size.width,
          top: (position * i * 0.4) + (50 * i),
          child: SizedBox(
            height: (size.height * (3 / 7)) - (16 * 4) - (50 * 2),
            child: _buildCard(card, size, context),
          ),
        ),
      );
    }
    return tempCards;
  }

  Widget _buildCard(WalletCardModel card, Size size, BuildContext context) {
    return Consumer<WalletViewModel>(
      builder: (context, watch, child) => GestureDetector(
        onVerticalDragUpdate: (details) => watch.onVerticalDragUpdate(height: size.height),
        onVerticalDragEnd: (details) => watch.onVerticalDragEnd(height: size.height),
        onTap: () => watch.onTapCard(card: card),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [card.type!.color, Palette.lightAccentColor],
              // colors: [Palette.darkOlive, Palette.lightAccentColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              tileMode: TileMode.mirror
            ),
            boxShadow: [
              BoxShadow(
                color: Palette.black.withOpacity(0.3),
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
            border: Border.all(
              color: Theme.of(context).hoverColor, // Border color
              width: 2, // Border width
            ),
            borderRadius: BorderRadius.circular(AppStyles.walletCardBorderRadius),
          ),
          alignment: Alignment.topCenter,
          child: Consumer<SettingsViewModel>(
            builder: (context, watch, child) => watch.isEnglish()
                ? _cardContent(
                    size: size,
                    context: context,
                    card: card,
                    typeTitle: card.type!.getTitle(ctx: context),
                  )
                : _cardContent(
                    size: size,
                    context: context,
                    card: card,
                    typeTitle: card.titleAr!,
                    // typeDescription: card.type!.getDescription(ctx: context),
                    // buttonText: card.type!.getButtonText(ctx: context),
                    // points: card.points!,
                  ),
          ),
        ),
      ),
    );
  }

  Column _cardContent({
    required Size size,
    required BuildContext context,
    required WalletCardModel card,
    required String typeTitle,
  }) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              typeTitle,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Palette.black),
            ),
            Row(
              children: [
                Text(
                  "${card.points}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Palette.black),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Icon(
                  Icons.monetization_on,
                  color: Palette.black,
                  size: 24.h,
                ),
              ],
            ),
          ],
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                card.type!.getDescription(ctx: context),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Palette.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            GestureDetector(
              child: Container(
                width: size.height * 0.3,
                height: size.height * 0.04,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Palette.darkOlive.withAlpha(80)),
                child: Center(
                  child: Text(
                    card.type!.getButtonText(ctx: context),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Palette.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onTap: () {
                if (card.type!.routeName == HomeScreen.routeName) {
                  Navigator.of(context).pushNamedAndRemoveUntil(card.type!.routeName, (route) => false,);
                }
                Navigator.of(context).pushReplacementNamed(card.type!.routeName);
              },
            )
          ],
        ),
      ),
    ]);
  }
}
