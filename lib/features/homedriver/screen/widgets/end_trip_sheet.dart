import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/widgets/custom_bottom_sheet_widget.dart';
import 'package:hero/core/widgets/custom_text_form_field.dart';
import 'package:hero/features/homedriver/screen/widgets/finish_trip_sheet.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/getsize.dart';
import '../../../../core/utils/show_bottom_sheet.dart';
import '../../cubit/home_driver_cubit.dart';

class EndTripSheet extends StatefulWidget {
  const EndTripSheet({super.key});

  @override
  State<EndTripSheet> createState() => _EndTripSheetState();
}
class _EndTripSheetState extends State<EndTripSheet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    HomeDriverCubit cubit = context.read<HomeDriverCubit>();
    return BlocConsumer<HomeDriverCubit,HomeDriverState>(
        listener: (context, state) {
          if (state is SuccessEndQuickTripState){
            Navigator.pop(context);
            showMyBottomSheet(FinishTripSheet(), context);
          }
        },
        builder: (context,state) {
          return
            cubit.startQuickTripModel.data == null ?
                SizedBox(height: 5,)

                :

            CustomBottomSheetWidget(buttonText: "endTrip".tr(),
            widget:
            CustomFromToWidget(
              name: cubit.startQuickTripModel.data!.name!,
              to: cubit.startQuickTripModel.data!.toAddress!,
                from: cubit.startQuickTripModel.data!.fromAddress!,)

            ,
            onPressed: () {

                cubit.endQuickTrip(context);

            },);
        }
    );
  }
}

class CustomFromToWidget extends StatelessWidget {
  const CustomFromToWidget({

    super.key, required this.from, required this.to, required this.name,
  });
final String from;
final String to;
final String name;

  @override
  Widget build(BuildContext context) {
    return Column
      (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            Icon(
              CupertinoIcons.person_circle_fill,
              color: Colors.grey,
              size: 45,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
            name,
    style: TextStyle(
    color: AppColors.black1,
    fontSize: getSize(context) * 0.04,
    fontWeight: FontWeight.w400),
            )  ],),

        SizedBox(
          height: 15,
        ),
        //from
        Row(
          children: [
            SvgPicture.asset(ImageAssets.fromToIcon),
            SizedBox(
              width: 10,
            ),
            Text(
              "from".tr(),
              style: TextStyle(
                  color: AppColors.black1,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Row(children: [
          SizedBox(
            width: getSize(context) * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Dash(
                direction: Axis.vertical,
                length: 40,
                dashLength: 4,
                dashColor: Colors.black),
          ),
          SizedBox(
            width: 3,
          ),
          Expanded(
            child: Text(
             from,
              // " برج الهيلتون الدور الخامس بجوار حتحوت ",

              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.gray,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ]),
        Row(
          children: [
            SvgPicture.asset(ImageAssets.toIcon),
            SizedBox(
              width: 10,
            ),
            Text(
              "to".tr(),
              style: TextStyle(
                  color: AppColors.black1,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          children: [
            SizedBox(
              width: getSize(context) * 0.03,
            ),
            Expanded(
              child: Text(
          to,
             //    "معهد الكبد القومى ",

                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.gray,
                    fontSize: getSize(context) * 0.04,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ],);
  }
}
