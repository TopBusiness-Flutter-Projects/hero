import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/homedriver/screen/widgets/enter_client_info_sheet.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/show_bottom_sheet.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/show_loading_indicator.dart';
import '../../../../cubit/home_driver_cubit.dart';

class HomeMapDriver extends StatefulWidget {
  const HomeMapDriver({super.key});

  @override
  State<HomeMapDriver> createState() => _HomeMapDriverState();
}

class _HomeMapDriverState extends State<HomeMapDriver> {
  HomeDriverCubit? cubit;
  @override
  Widget build(BuildContext context) {
    cubit = context.read<HomeDriverCubit>();
    return BlocConsumer<HomeDriverCubit, HomeDriverState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Builder(
                builder: (context) {
                  return cubit!.currentLocation != null ? GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        cubit!.currentLocation != null ? cubit!.currentLocation!
                            .latitude! : 0,
                        cubit!.currentLocation != null ? cubit!.currentLocation!
                            .longitude! : 0,
                      ),
                      zoom: 13.5,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("currentLocation"),
                        icon: cubit!.markerIcon != null
                            ? BitmapDescriptor.fromBytes(cubit!.markerIcon!)
                            : cubit!.currentLocationIcon,
                        position: LatLng(
                          cubit!.currentLocation != null ? cubit!
                              .currentLocation!.latitude! : 0,
                          cubit!.currentLocation != null ? cubit!
                              .currentLocation!.longitude! : 0,
                        ),
                      ),
                      // Rest of the markers...
                    },
                    onMapCreated: (GoogleMapController controller) {
                      cubit!.mapController =
                          controller; // Store the GoogleMapController
                    },
                    onTap: (argument) {
                      // _customInfoWindowController.hideInfoWindow!();
                    },
                    onCameraMove: (position) {
                      if (cubit!.strartlocation!=position.target){
                        print(cubit!.strartlocation);
                        cubit!.strartlocation=position.target;
                        cubit!.getCurrentLocation();}
                      // _customInfoWindowController.hideInfoWindow!();
                    },
                  ):const ShowLoadingIndicator();
                },


              ),
              Positioned(
                  top: 20,
                  width: getSize(context) / 2.5,
                  child: Material(
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 20)),
                    color: AppColors.white,
                    child: Center(
                      child: SizedBox(
                        width: getSize(context) / 2.5,
                        height: 39,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.circle_fill,
                              size: 10,
                              color: cubit!.inService
                                  ? AppColors.success
                                  : AppColors.gray2,
                            ),
                            Text(
                              cubit!.inService
                                  ? "you_conect".tr()
                                  : "you_not_conect".tr(),
                              style: TextStyle(
                                fontSize: getSize(context) / 24,
                                color: cubit!.inService
                                    ? AppColors.success
                                    : AppColors.gray2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              ConditionalBuilder(
                condition: cubit!.driverDataModel.data != null,
                fallback: (context) => SizedBox(height: 10,),
                builder: (context) =>
                 Positioned(
                  bottom: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: LiteRollingSwitch(
                      value: cubit!.inService,
                      width: 150,
                      textOn: 'in_service'.tr(),
                      textOff: 'out_service'.tr(),
                      textOffColor: AppColors.white,
                      textOnColor: AppColors.white,
                      colorOn: AppColors.success,
                      colorOff: AppColors.grey2,
                      iconOff: Icons.power_settings_new,
                      animationDuration: const Duration(milliseconds: 300),
                      onChanged: (bool state) {
                        cubit!.switchInService(state,context);
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {

                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: getSize(context) / 5),
            child:
            cubit!.driverDataModel.data != null ?



            CustomButton(
              width: getSize(context) / 3,
              text: 'immediate_trip'.tr(),
              color: AppColors.primary,
              onClick: () {
                if (cubit!.driverDataModel.data!.driverStatus == 0)
                  errorGetBar('أنت خارج الخدمة الآن');
                else
               Navigator.pushNamed(
                   context, Routes.ImmediateTripDriver);
              },
            ):
            Container(child: null,)
            ,
          ),
        );
      },
    );
  }


}
