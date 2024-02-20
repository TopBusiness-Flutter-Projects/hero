import 'dart:async';
import 'dart:ui';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/core/widgets/custom_button.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../components/default_widget.dart';
import '../components/failure_widget.dart';
import '../components/loading_widget.dart';
import '../components/show_trip_widget.dart';
import '../components/success_widget.dart';
import '../cubit/home_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowTripScreen extends StatefulWidget {
  ShowTripScreen({
    super.key,
    required this.trip,
  });

  final NewTrip trip;

  @override
  State<ShowTripScreen> createState() => _ShowTripScreenState();
}

class _ShowTripScreenState extends State<ShowTripScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().destination = LatLng(0, 0);
    context.read<HomeCubit>().location_control.text = "";
    context.read<HomeCubit>().setMyMarker(widget.trip);
    context.read<HomeCubit>().checkAndRequestLocationPermission();
    context.read<HomeCubit>().getDirectionFromTo(
        //widget.trip
        LatLng(double.parse(widget.trip.fromLat ?? "31.98354"),
            double.parse(widget.trip.fromLong ?? "31.1234065")),
        LatLng(double.parse(widget.trip.toLat ?? "31.98354"),
            double.parse(widget.trip.toLong ?? "31.1234065")));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeCubit>().latLngList = [];
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //  key: scaffoldKey,
          body: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is SuccessCreateSchedualTripState) {
                Navigator.pop(context);
              }
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
                              double.parse(widget.trip.fromLat ?? '0'),
                              double.parse(widget.trip.fromLong ?? '0'),
                            ),
                            zoom: 13.5,
                          ),
                          markers: // cubit.tripMarkers,

                              widget.trip.toAddress != null
                                  ? {
                                      Marker(
                                        markerId: const MarkerId("from"),
                                        icon: cubit.markerIcon != null
                                            ? BitmapDescriptor.fromBytes(
                                                cubit.markerIcon!)
                                            : cubit.currentLocationIcon,
                                        position: LatLng(
                                            double.parse(widget.trip.fromLat!),
                                            double.parse(
                                                widget.trip.fromLong!)),
                                      ),
                                      Marker(
                                        markerId: MarkerId("to"),
                                        infoWindow: InfoWindow(
                                          title: "to",
                                        ),
                                        // icon: cubit.destinationIcon,
                                        position: LatLng(
                                            double.parse(widget.trip.toLat!),
                                            double.parse(widget.trip.toLong!)),
                                      ),
                                      //  markers.first
                                    }
                                  // without
                                  : {
                                      Marker(
                                        markerId: const MarkerId("from"),
                                        icon: cubit.markerIcon != null
                                            ? BitmapDescriptor.fromBytes(
                                                cubit.markerIcon!)
                                            : cubit.currentLocationIcon,
                                        position: LatLng(
                                            double.parse(widget.trip.fromLat!),
                                            double.parse(
                                                widget.trip.fromLong!)),
                                      )
                                    },
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
                            //  cubit.getLocation(argument, "to");
                            //  if(cubit.currentEnumStatus == MyEnum.defaultState){
                            // if (context.read<HomeCubit>().flag == 1) {
                            //   //   cubit.getLocation(argument);
                            //
                            // } else {}
                            // // }

                            //  _customInfoWindowController.hideInfoWindow!();
                          },
                          onCameraMove: (position) {
                            //  if (cubit.strartlocation != position.target) {
                            //   // print(cubit.strartlocation);
                            //    cubit.strartlocation = position.target;
                            //    cubit.getCurrentLocation();
                            //  }
                            // _customInfoWindowController.hideInfoWindow!();

                            //  _customInfoWindowController.hideInfoWindow!();
                          },
                          polylines: widget.trip.toAddress == null
                              ? {}
                              : {
                                  Polyline(
                                    polylineId: const PolylineId("routes"),
                                    points: cubit.latLngListFromTo,
                                    color: const Color(0xFF7B61FF),
                                    width: 6,
                                  ),
                                },
                        ),
                  ShowTripWidget(
                      isWith: widget.trip.toAddress != null, trip: widget.trip),

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
