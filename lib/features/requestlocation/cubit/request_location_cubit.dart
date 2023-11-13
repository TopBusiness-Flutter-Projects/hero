import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart'as loc;
part 'request_location_state.dart';

class RequestLocationCubit extends Cubit<RequestLocationState> {
  RequestLocationCubit() : super(RequestLocationInitial());
  loc.LocationData? currentLocation;


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
      else{
        //todo=>save current location
        getCurrentLocation();
      }
    }

    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isGranted) {
      //todo=>save current location
      // Location permission is granted, continue with location-related tasks
      getCurrentLocation();
      // ...
    } else {
      // Location permission is not granted, handle accordingly (show a message, disable functionality, etc.)
      // ...
    }
  }

  void getCurrentLocation() async {
    loc.Location location = loc.Location();
    // we can remove this future method because we listen on data in the onLocationChanged.listen
    location.getLocation().then(
          (location) {
        currentLocation = location;

        // if(strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){
        //   strartlocation=  LatLng(
        //     currentLocation!.latitude!,
        //     currentLocation!.longitude!,
        //   );
        //   //get the address and draw route
        //   getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
        //   // move the camera to the current location
        //   updateLocation();
        //
        //   emit(UpdateCurrentLocationState());
        //
        // }
      },
    );

    // location.onLocationChanged.listen(
    //       (newLoc) {
    //     currentLocation = newLoc;
    //
    //     if(currentLocation==null||strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){
    //
    //       strartlocation=  LatLng(
    //         currentLocation!.latitude!,
    //         currentLocation!.longitude!,
    //       );
    //       getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
    //
    //       // move the camera to the current location
    //       updateLocation();
    //       emit(UpdateCameraPosition());}
    //   },
    // );
  }
}
