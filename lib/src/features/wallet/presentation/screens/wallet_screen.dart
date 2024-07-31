import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawdat_hufaz/src/features/wallet/presentation/screens/widgets/pionts_transactions_widget.dart';
import 'package:rawdat_hufaz/src/shared/widgets/custom_no_data_widget.dart';
import '../../view_model/wallet_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/wallet_cards.dart';

class WalletScreen extends StatefulWidget {
  static String routeName = "points";

  const WalletScreen({super.key});

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  late final WalletViewModel walletViewModel;

  @override
  void initState() {
    walletViewModel = Provider.of<WalletViewModel>(context, listen: false);
    Future.delayed(
      Duration.zero,
      () => walletViewModel.loadWallet(
        context: context,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.wallet,
        ),
      ),
      body: Consumer<WalletViewModel>(
        builder: (context, watch, child) => watch.isLoading
            ? SizedBox(
                height: size.height * 0.8,
                child: const Center(child: CircularProgressIndicator()),
              )
            : watch.cards.isEmpty
                ? SizedBox(
                    height: size.height * 0.8,
                    child: CustomNoDataWidget(
                      text: AppLocalizations.of(context)!.message_no_data_title,
                      displayImage: false,
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        color: Theme.of(context).hoverColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32.h),
                        child: Padding(
                          padding: const EdgeInsets.only(left:15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.my_points,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge),
                              Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .color,
                                    size: 24.h,
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Text("${watch.points}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                              fontSize: 24.h,
                                              fontWeight: FontWeight.w900)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        flex: (watch.position > 2 ? 3 : 0) + 3,
                        child: WalletCards(
                          cards: watch.cards,
                          position: watch.position,
                        ),
                      ),
                      watch.selectedCard.transactions.isEmpty
                          // ? SizedBox(
                          //     height: size.height*0.2,
                          //     child: CustomNoDataWidget(
                          //       text: AppLocalizations.of(context)!
                          //       .message_no_data_title,
                          //       displayImage: false,
                          //     ),
                          //   )
                          ?SizedBox()
                          : Expanded(
                        flex: 3,
                        child:
                        ListView.separated(
                          itemCount: watch.selectedCard.transactions.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                              child: const Divider(),
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                                return TransactionWidget(
                                  size: size,
                                  color: watch.selectedCard.type!.color,
                                  title: watch.selectedCard.titleAr!,
                                  transaction:
                                      watch.selectedCard.transactions[index],
                                );
                          },
                        )
                      ),
                    ],
                  ),
      ),
    );
  }
}
