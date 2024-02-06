import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hero/core/utils/app_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/my_svg_widget.dart';

class CustomMyWalletWidget extends StatelessWidget {
  const CustomMyWalletWidget({
    super.key, required this.time, required this.vat,
  });
final String time;
final String vat;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(
          vertical: 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(
                0, 0, 0, 0.1),
            blurRadius: 20,
            offset: Offset(
                0, 0), // Shadow position
          ),
          BoxShadow(
            color: Color.fromRGBO(
                0, 0, 0, 0.1),
            blurRadius: 10,
            offset: Offset(
                0, 0), // Shadow position
          ),
        ],
        color: AppColors.white,
        borderRadius:
        BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            Image.asset(ImageAssets.tuktukWallet,width: 47,height: 47),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("tripPrices".tr(),style: getRegularStyle(fontSize: 14,color: AppColors.grey4),),
                    Text(time,style: getRegularStyle(fontSize: 14,color: AppColors.grey2),),
                  ],
                ),
              ),
            ),
            Spacer()
,            Text('$vat ',style: getRegularStyle(color: AppColors.primary,fontSize: 20),),
            Text('currency'.tr(),style: getRegularStyle(color: AppColors.primary,fontSize: 20),)
          ],
        ),
      ),


    );
  }
}