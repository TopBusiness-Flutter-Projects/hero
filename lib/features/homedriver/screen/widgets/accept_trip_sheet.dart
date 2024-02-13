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
import 'custom_from_to_widget.dart';

class AcceptTripSheet extends StatefulWidget {
  const AcceptTripSheet({super.key});

  @override
  State<AcceptTripSheet> createState() => _AcceptTripSheetState();
}
class _AcceptTripSheetState extends State<AcceptTripSheet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    HomeDriverCubit cubit = context.read<HomeDriverCubit>();
    return BlocConsumer<HomeDriverCubit,HomeDriverState>(
        listener: (context, state) {
          if (state is SuccessEndQuickTripState){
          // Navigator.pop(context);
          // showMyBottomSheet(FinishTripSheet(), context);
          }
        },
        builder: (context,state) {
          return
            CustomBottomSheetWidget(buttonText: "acceptTrip".tr(),
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


