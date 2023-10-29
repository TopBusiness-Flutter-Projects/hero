import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/getsize.dart';

class WidgetMarker extends Marker {
  final Widget widget;

  WidgetMarker({
    required this.widget,
    required MarkerId markerId,
    required LatLng position,
  }) : super(
    markerId: markerId,
    position: position,
    icon: BitmapDescriptor.defaultMarker,
  );

  Future<BitmapDescriptor> getMarkerIcon() async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Size size = Size(150, 150); // Adjust the size as needed

    final widgetSpan = WidgetSpan(child: widget);
    final textPainter = TextPainter(
      text: TextSpan(children: [widgetSpan]),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth:300);

    canvas.drawParagraph(textPainter as Paragraph, Offset.zero);
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(
      size.width.toInt(),
      size.height.toInt(),
    );

    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);

    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }
}