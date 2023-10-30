import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';

class CustomeMarker extends StatelessWidget {
  CustomeMarker({super.key, required this.title, required this.location});

  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(getSize(context)/16)),
        color: AppColors.white,
        child: Container(
   height: 90,
          width: 300,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(getSize(context) / 16))),
          child: Center(
            child: Row(
              children: [
                Image.asset(ImageAssets.marker2),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(

                           //    fontSize: getSize(context)/100,
                            color: AppColors.black),
                      ),
                      Flexible(
                        child: Text(
                          location,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(

                              //  fontSize: getSize(context)/40,
                              color: AppColors.grey2),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
