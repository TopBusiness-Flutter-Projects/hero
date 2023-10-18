import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomMarkerWidget1 extends StatelessWidget {
  final Uint8List markerIcon;
  final String text1;
  final String text2;

  CustomMarkerWidget1({
    required this.markerIcon,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.memory(
          markerIcon,
          width: 40,
          height: 40,
        ),
     Column(
       children: [
         Text(text1),
         Text(text2),
       ],
     )
      ],
    );
  }
}


// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
//
// class CustomMarkerWidget extends StatelessWidget {
//   final Uint8List markerIcon;
//   final String text1;
//   final String text2;
//
//   CustomMarkerWidget({
//     required this.markerIcon,
//     required this.text1,
//     required this.text2,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       key: GlobalKey(),
//       child: Column(
//         children: [
//           Image.memory(
//             markerIcon,
//             width: 40,
//             height: 40,
//           ),
//           Text(text1),
//           Text(text2),
//         ],
//       ),
//     );
//   }
// }



