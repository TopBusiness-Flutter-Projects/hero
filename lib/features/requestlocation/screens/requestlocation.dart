import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart'as loc;
class RequestLocation extends StatefulWidget {
  const RequestLocation({super.key});

  @override
  State<RequestLocation> createState() => _RequestLocationState();
}

class _RequestLocationState extends State<RequestLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getSize(context) / 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(context) / 24,
              ),
              Image.asset(
                ImageAssets.backImage,
                height: getSize(context) / 13,
                width: getSize(context) /13,

                // height: getSize(context) / 1.2,
                // width: getSize(context) / 1.2,
              ),
              SizedBox(
                height: getSize(context) / 24,
              ),
              Center(
                child: SizedBox(
                  child: Image.asset(
                    ImageAssets.requestlocationImage,
                    height: getSize(context) / 1.3,
                    width: getSize(context) / 1.1,
                    fit: BoxFit.fill,
                    // height: getSize(context) / 1.2,
                    // width: getSize(context) / 1.2,
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 16,
              ),
              Center(
                child: SizedBox(
                  /// height: getSize(context) / 24,
                  ///width: getSize(context),
                  child: Text("book_toktok_app".tr(),
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: getSize(context) / 22,
                        fontWeight: FontWeight.bold
                      )),
                ),
              ),
              SizedBox(
                height: getSize(context) / 30,
              ),
              Center(
                child: SizedBox(
                  /// height: getSize(context) / 24,
                  ///width: getSize(context),
                  child: Center(
                    child: Text("to_join".tr(),
                        textAlign:TextAlign.center,
                        style: TextStyle(

                          color: AppColors.gray3,
                          fontSize: getSize(context) / 24,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 8,
              ),
              CustomButton(
                width: getSize(context),
                text: "continuation".tr(),
                borderRadius: getSize(context) / 24,
                color: AppColors.primary,
                onClick: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeRoute, (route) => false);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
   // fetchLocation();
    checkAndRequestLocationPermission();
    super.initState();
  }
  Future<void> enableLocationServices() async {
    loc.Location location = loc.Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Location services are still not enabled, handle accordingly (show a message, disable functionality, etc.)
        // ...
        return;
      }
    }

    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isGranted) {

      // Location permission is granted, continue with location-related tasks
      // ...
    } else {
      // Location permission is not granted, handle accordingly (show a message, disable functionality, etc.)
      // ...
    }
  }
  Future<void> checkAndRequestLocationPermission() async {
    // Check the current status of the location permission
    PermissionStatus permissionStatus = await Permission.location.status;

    if (permissionStatus.isDenied) {
      // If the permission is denied, request it from the user
      PermissionStatus newPermissionStatus = await Permission.location.request();

      if (newPermissionStatus.isGranted) {
       await enableLocationServices();
        // Permission granted, continue with location-related tasks
        // Call the function to handle the location-related tasks here
        // ...
      } else if (newPermissionStatus.isDenied) {
        // Permission denied again, handle accordingly (show a message, disable functionality, etc.)
        // ...
      }
    } else if (permissionStatus.isGranted) {
     await enableLocationServices();
      // Permission already granted, continue with location-related tasks
      // Call the function to handle the location-related tasks here
      // ...
    }
  }


}


