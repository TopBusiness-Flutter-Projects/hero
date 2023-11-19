import 'dart:async';
import 'dart:ui';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/features/home/screen/home.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../components/drawer_list_item.dart';
import '../cubit/home_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddTripTab extends StatefulWidget {
  AddTripTab({super.key});

  @override
  State<AddTripTab> createState() => _AddTripTabState();
}

class _AddTripTabState extends State<AddTripTab> with TickerProviderStateMixin {
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  late FlutterGifController gifController;

  @override
  void dispose() {
    _customInfoWindowController.dispose();
   _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().destination=LatLng(0, 0);
    context.read<HomeCubit>().getCurrentLocation();
    gifController = FlutterGifController(vsync: this);
    context.read<HomeCubit>().checkAndRequestLocationPermission();
    startTimer();

  }
  double _progressValue = 0.0;
  late Timer _timer;
  final Duration _duration = const Duration(minutes: 1);
  void startTimer() {
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue += 1.0 / (_duration.inSeconds);
        } else {
          _timer.cancel();
          context.read<HomeCubit>().bottomContainerLoadingState = false;
          context.read<HomeCubit>().bottomContainerFailureState = true;


        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeCubit>().latLngList = [];
        context.read<HomeCubit>().tabsController.animateTo(0);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //  key: scaffoldKey,
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            HomeCubit cubit = context.read<HomeCubit>();
            return Stack(
              children: [
                cubit.currentLocation == null
                    ? const Center(child: Text("Loading"))
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            cubit.currentLocation != null
                                ? cubit.currentLocation!.latitude!
                                : 0,
                            cubit.currentLocation != null
                                ? cubit.currentLocation!.longitude!
                                : 0,
                          ),
                          zoom: 13.5,
                        ),
                        markers: cubit.markers,
                        //       {
                        //         Marker(
                        //           markerId: const MarkerId("currentLocation"),
                        //           icon: cubit.currentLocationIcon,
                        //
                        //           position: LatLng(cubit.currentLocation!.latitude!,
                        //               cubit.currentLocation!.longitude!),
                        //         ),
                        //         // Marker(
                        //         //   markerId: const MarkerId("source"),
                        //         //   infoWindow: InfoWindow(
                        //         //     title: "from",
                        //         //   ),
                        //         //  // icon: customMarkerIcon,
                        //         //   icon: cubit.sourceIcon,
                        //         //   position: cubit.sourceLocation,
                        //         // ),
                        //         Marker(
                        //           markerId: MarkerId("destination"),
                        //           infoWindow: InfoWindow(
                        //             title: "to",
                        //           ),
                        //           icon: cubit.destinationIcon,
                        //           position: cubit.destinationH,
                        //         ),
                        //       //  markers.first
                        //       },
                        onMapCreated: (GoogleMapController mapController) {
                          cubit.mapController = mapController;
                        },
                        onTap: (argument) {

                          if (context.read<HomeCubit>().flag == 1) {
                            //   cubit.getLocation(argument);
                            cubit.getLocation(argument, "to");
                          } else {}

                          //  _customInfoWindowController.hideInfoWindow!();
                        },
                        onCameraMove: (position) {
                          if (cubit.strartlocation != position.target) {
                           // print(cubit.strartlocation);
                            cubit.strartlocation = position.target;
                            cubit.getCurrentLocation();
                          }
                          // _customInfoWindowController.hideInfoWindow!();

                          //  _customInfoWindowController.hideInfoWindow!();
                        },
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("route"),
                            points: cubit.latLngList,
                            color: const Color(0xFF7B61FF),
                            width: 6,
                          ),
                        },
                      ),

                Visibility(
                  visible: cubit.bottomContainerInitialState,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        height: getSize(context) * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(0.25),
                                  blurRadius: 10,
                                  spreadRadius: 10,
                                  offset: Offset(4, 4))
                            ],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: getSize(context) * 0.1,
                            ),
                            //search field
                            Visibility(
                              visible: context.read<HomeCubit>().flag == 1,
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: CustomTextField(
                                  title: 'search_location'.tr(),
                                  backgroundColor: AppColors.white,
                                  prefixWidget: MySvgWidget(
                                    path: ImageAssets.mapIcon,
                                    imageColor: AppColors.black,
                                    size: 10,
                                  ),
                                  validatorMessage: 'loaction_msg'.tr(),
                                  horizontalPadding: 2,
                                  textInputType: TextInputType.text,
                                  onchange: (p0) {
                                    cubit.search(p0);
                                  },
                                  controller: cubit.location_control,
                                ),
                              ),
                              // InkWell(
                              //
                              //     onTap: () async {
                              //
                              //      // await cubit.searchOnMapH();
                              //     },
                              //     child: Padding(
                              //       padding: EdgeInsets.all(15),
                              //       child: Card(
                              //         child: Container(
                              //
                              //             padding: EdgeInsets.all(0),
                              //             width: MediaQuery.of(context).size.width -
                              //                 40,
                              //             child: ListTile(
                              //               title: Text(
                              //                 cubit.location,
                              //                 style: TextStyle(fontSize: 18),
                              //               ),
                              //               trailing: Icon(Icons.search),
                              //               dense: true,
                              //              // leading: TextField(),
                              //             )),
                              //       ),
                              //     )
                              //
                              //     ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //payment_method
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("payment_method").tr(),
                              ],
                            ),
                            //cash
                            RadioListTile(
                              title: Text("cash").tr(),
                              value: cubit.payment,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              tileColor: AppColors.black1,
                              activeColor: AppColors.primary,
                              selected: true,
                              groupValue: cubit.payment,
                              onChanged: (value) {
                                cubit.changeRadioButton(value);
                              },
                            ),
                            //SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //ride_later
                                CustomButton(
                                  text: "ride_later".tr(),
                                  color: AppColors.primary,
                                  borderRadius: 16,
                                  onClick: () async {
                                    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                                    await cubit.selectDateAndTime(context);
                                  },
                                  width: getSize(context) / 2,
                                ),
                                //  ride_now"
                                Container(
                                  //   padding: EdgeInsets.symmetric(horizontal: 1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          width: 3, color: AppColors.primary)),
                                  child: CustomButton(
                                    borderRadius: 16,
                                    text: "ride_now".tr(),
                                    color: AppColors.white,
                                    textcolor: AppColors.primary,
                                    onClick: () async {
                                    await  cubit.createTrip(tripType: cubit.flag==1?"with":"without",context: context);
                                     // cubit.changeToRideNowState();
                                    },
                                    width: getSize(context) / 3,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
                // loading state
                Visibility(
                  visible: cubit.bottomContainerLoadingState,
                  //visible: false,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: getSize(context) * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              ImageAssets.search,
                              width: getSize(context) / 4,
                            ),
                            //progress indicator
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(20),
                                value: _progressValue,
                                color: AppColors.primary, //<-- SEE HERE
                                backgroundColor: AppColors.grey1, //<-- SEE HERE
                              ),
                            ),
                            //rich text
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                      text: "search_for_drivers".tr(),
                                      style: TextStyle(
                                        color: AppColors.black2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: getSize(context) * 0.04,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "appreciate_your_patience".tr(),
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: getSize(context) * 0.04,
                                          ),
                                        )
                                      ])),
                            ),
                            //button
                            CustomButton(
                              text: "cancel".tr(),
                              color: AppColors.red,
                              onClick: () {
                                cubit.tabsController.animateTo(0);
                                cubit.bottomContainerLoadingState = false;
                                cubit.bottomContainerInitialState = true;
                              },
                              width: getSize(context) * 0.9,
                              borderRadius: 16,
                            )
                          ],
                        ),
                      )),
                ),
                //success state
                Visibility(
                  visible: cubit.bottomContainerSuccessState,
                  //visible: false,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: getSize(context) * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              ImageAssets.success,
                              width: getSize(context) / 4,
                            ),

                            //rich text
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text("confirm_driver".tr())),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "محمد محمود",
                                  style: TextStyle(color: AppColors.black3),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                ),
                //failure state
                Visibility(
                  visible: cubit.bottomContainerFailureState,
                  //visible: false,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: getSize(context) * 0.55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              ImageAssets.failure,
                              width: getSize(context) / 4,
                            ),

                            //rich text
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text("no_drivers".tr())),
                            //button
                            CustomButton(
                              text: "try_again".tr(),
                              color: AppColors.red,
                              onClick: () {
                                cubit.tabsController.animateTo(0);
                                cubit.bottomContainerLoadingState = false;
                                cubit.bottomContainerFailureState = false;
                                cubit.bottomContainerSuccessState = false;
                                cubit.bottomContainerInitialState = true;
                              },
                              width: getSize(context) * 0.9,
                              borderRadius: 16,
                            )
                          ],
                        ),
                      )),
                ),

                //back button
                Positioned(
                  top: getSize(context) * 0.01,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12),
                    child: Row(
                      children: [
                        CustomBackButton(),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

//
// Future<BitmapDescriptor> createCustomMarkerIcon() async {
//   final Uint8List markerIconBytes = await loadImageData('path_to_your_image.png');
//
//   final CustomMarkerWidget customMarker = CustomMarkerWidget(
//     markerIcon: markerIconBytes,
//     text1: 'Text 1',
//     text2: 'Text 2',
//   );
//
//   final Uint8List markerBytes = await captureWidgetToBytes(customMarker);
//
//   // Use the markerBytes as BitmapDescriptor in Google Maps
//   final BitmapDescriptor customMarkerIcon = BitmapDescriptor.fromBytes(markerBytes);
//
//   return customMarkerIcon;
// }
//
// Future<Uint8List> loadImageData(String imagePath) async {
//   final ByteData byteData = await rootBundle.load(imagePath);
//   return byteData.buffer.asUint8List();
// }

//
//   // Future<void> createCustomMarkerIcon() async {
//   //   final Uint8List markerIconBytes = await _getMarkerIconBytes();
//   //   final WidgetMarker = CustomMarkerWidget(
//   //     markerIcon: markerIconBytes,
//   //     text1: 'Text 1',
//   //     text2: 'Text 2',
//   //   );
//   //
//   //  // final ByteData byteData = await WidgetMarker.toImage(pixelRatio: 3.0);
//   //   customMarkerIcon = BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
//   // }
//   Future<void> createCustomMarkerIcon() async {
//     final Uint8List? markerIconBytes = await _getMarkerIconBytes();
//     final WidgetMarker = CustomMarkerWidget(
//       markerIcon: markerIconBytes!,
//       text1: 'Text 1',
//       text2: 'Text 2',
//     );
//
//     final ByteData byteData = await WidgetMarker.toImage(pixelRatio: 3.0);
//     customMarkerIcon = BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
//   }
//   Future<Uint8List?> _getMarkerIconBytes() async {
//     // Load and process your image to Uint8List
//     // Example: Use the `flutter_image_compress` package to compress the image
//     // ...
//     File imageFile = await getImageFileFromAssets();
//     Uint8List? imageFileCompressed = await loadImageData(imageFile);
//     return imageFileCompressed;
//   }
//
//   Future<Uint8List?> loadImageData(File imageFile) async {
//     final compressedImageBytes = await FlutterImageCompress.compressWithFile(
//       imageFile.path,
//       quality: 80, // Set the desired image quality (0-100)
//     );
//
//     return compressedImageBytes;
//   }
// // step 2 -  compress the image file
// //   Future<Uint8List?> loadImageData(File imageFile)async{
// //    final compressedImageFile = await FlutterImageCompress.compressWithFile(
// //     imageFile.path ,
// //      quality: 90
// //    );
// //    return compressedImageFile;
// //   }
//
// //step 1 - convert the image to file
// //   Future<File> convertImageToFIle(String imagePath) async {
// //     // Read the image file as bytes
// //     final imageBytes = await File(imagePath).readAsBytes();
// //
// //     // Get the temporary directory path
// //     final tempDir = await getTemporaryDirectory();
// //
// //     // Create a unique file name using a timestamp
// //     final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.png';
// //
// //     // Create a new file in the temporary directory
// //     final File imageFile = File('${tempDir.path}/$fileName');
// //
// //     // Write the image bytes to the file
// //     await imageFile.writeAsBytes(imageBytes);
// //
// //     return imageFile;
// //   }
//
//   // Future<Uint8List> captureWidgetToBytes(Widget widget) async {
//   //   final RenderRepaintBoundary boundary =
//   //   (widget.key as GlobalKey).currentContext!.findRenderObject() as RenderRepaintBoundary;
//   //   final image = await boundary.toImage(pixelRatio: 3.0);
//   //   final byteData = await image.toByteData(format: ImageAssets.marker);
//   //
//   //   return imageData.buffer.asUint8List();
//   // }
// //eng.ahmed method (convert png image to file )
//   Future<File> getImageFileFromAssets() async {
//     final byteData = await rootBundle.load(ImageAssets.marker);
//     final file = File('${(await getTemporaryDirectory()).path}/');
//     await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//     return file;
//   }
//
//   Future<Uint8List> captureWidgetToBytes(Widget widget) async {
//     final RenderRepaintBoundary boundary =
//     (widget.key as GlobalKey).currentContext!.findRenderObject() as RenderRepaintBoundary;
//     final image = await boundary.toImage(pixelRatio: 3.0);
//     final byteData = await image.toByteData(format: ImageByteFormat.png);
//
//     return byteData!.buffer.asUint8List();
//   }

//
//
// Future<Uint8List> loadImageData(String imagePath) async {
//   final ByteData byteData = await rootBundle.load(imagePath);
//   return byteData.buffer.asUint8List();
// }
}


