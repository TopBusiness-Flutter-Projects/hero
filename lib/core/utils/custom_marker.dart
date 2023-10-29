import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';

class CustomeMarker extends StatefulWidget {
  const CustomeMarker({super.key, required this.title, required this.location});
final String title;
final String location;
  @override
  State<CustomeMarker> createState() => _CustomeMarkerState();
}

class _CustomeMarkerState extends State<CustomeMarker> {
  @override
  Widget build(BuildContext context) {
    return
      RepaintBoundary(
      child: Material(
      color: AppColors.white,
      borderRadius: BorderRadius.all(Radius.circular(getSize(context)/22)),
      child: Row(
        children: [
          Image.asset(ImageAssets.marker),
          Expanded(
            child: Column(
              children: [
                Text(widget.title,
                style: TextStyle(
                  fontSize: getSize(context)/22,
                  color: AppColors.black
                ),),
                Text(widget.location,
                style: TextStyle(
                  fontSize: getSize(context)/22,
                  color: AppColors.grey2
                ),),

              ],
            ),
          )
        ],
      ),
    ));
  }
}
