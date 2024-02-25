import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/config/routes/app_routes.dart';
import 'package:hero/core/widgets/custom_bottom_sheet_widget.dart';
import 'package:hero/core/widgets/custom_text_form_field.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/getsize.dart';
import '../../../../core/utils/show_bottom_sheet.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../cubit/home_driver_cubit.dart';
import 'custom_from_to_widget.dart';

class FinishTripSheet extends StatefulWidget {
  const FinishTripSheet({super.key});
  @override
  State<FinishTripSheet> createState() => _FinishTripSheetState();
}
class _FinishTripSheetState extends State<FinishTripSheet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    HomeDriverCubit cubit = context.read<HomeDriverCubit>();
    return BlocConsumer<HomeDriverCubit,HomeDriverState>(
        listener: (context, state) {
        // if (state is SuccessEndQuickTripState){
        //   Navigator.pop(context);
        //   showMyBottomSheet(FinishTripSheet(), context);
        // }
        },
        builder: (context,state) {
          return
            cubit.startQuickTripModel.data == null ?
            SizedBox(height: 5,)
                :
            CustomBottomSheetWidget(

              buttonText: "confirm".tr(),
              widget: Container(
                width: double.maxFinite,
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(

                    children: [

                      CustomFromToWidget(
                        withName: false,
                        name: cubit.startQuickTripModel.data!.name!,
                        to: cubit.startQuickTripModel.data!.toAddress!,
                        from: cubit.startQuickTripModel.data!.fromAddress!,) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ Column(children: [
                        Text("rideTime".tr()),
                        Text('${cubit.startTime!.hour}:${cubit.startTime!.minute}'),


                      ],),

                        Image.asset(
                          ImageAssets.finishTripBike,
                        ),
                        Column(children: [
                          Text("arrivalTime".tr()),
                          Text('${cubit.arrivalTime!.hour}:${cubit.arrivalTime!.minute}'),

                        ],),
                      ],),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FinishTripColumn(
                          path: ImageAssets.finishTripMap,
                          text: cubit.tripDistance,

                        ), FinishTripColumn(
                          path: ImageAssets.finishTripTime,
                          text: cubit.tripTime,

                        ), FinishTripColumn(
                          path: ImageAssets.finishTripMoney,
                          text: cubit.endQuickTripModel.data!.price!.toString(),

                        ),
                      ],

                      )


                    ],
                  ),
                ),
              )

              ,
              onPressed: () {

                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.homedriverRoute, (route) => false);
                cubit.setInitial();

              },);
        }
    );
  }
}

class FinishTripColumn extends StatelessWidget {
  const FinishTripColumn({
    super.key, required this.path, required this.text,
  });
final String path;
final String text;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          MyCustomSvgWidget(
            path:
            path,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }
}


