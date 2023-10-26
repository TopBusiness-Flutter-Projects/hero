import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/app_colors.dart';

class MarkersWithLabel {
  static Future<Uint8List?> getBytesFromCanvasDynamic(
      {required String iconPath,
        required String plateReg,
        required double fontSize,
        required Size iconSize}) async {
    final Paint paint = Paint()
      ..color = const Color.fromARGB(255, 240, 200, 50);
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    //The label code
    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: fontSize,
        color: AppColors.black,
        letterSpacing: 1.0,
      ),
      text: plateReg.length > 15 ? plateReg.substring(0, 15) + '...' : plateReg,
    );

    TextPainter painter = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr);
    painter.text = TextSpan(
        text:
        plateReg.length > 15 ? plateReg.substring(0, 15) + '...' : plateReg,
        style: TextStyle(
            fontSize: fontSize,
            letterSpacing: 2,
            color: AppColors.black,
            fontWeight: FontWeight.w600));

    painter.layout(
      minWidth: 0,
    );
    int halfTextHeight = painter.height ~/ 2;
    double fortyPercentWidth = painter.width * 0.20;
    int textWidth = painter.width.toInt() + fortyPercentWidth.toInt();
    int textHeight = painter.height.toInt() + halfTextHeight;

    // Text box rectangle for Vehicle registration label
    Rect rect =
    Rect.fromLTWH(0, 0, textWidth.toDouble(), textHeight.toDouble());
    RRect rectRadius = RRect.fromRectAndRadius(rect, const Radius.circular(10));

    canvas.drawRRect(rectRadius, paint);
    painter.paint(
        canvas, Offset(fortyPercentWidth / 2, halfTextHeight.toDouble() / 2));

    double x = (textWidth) / 2;
    double y = textHeight.toDouble();

    Path arrow = Path()
      ..moveTo(x - 25, y)
      ..relativeLineTo(50, 0)
      ..relativeLineTo(-25, 25)
      ..close();

    // Draw an arrow under the Text Box Label
    canvas.drawPath(arrow, paint);

    // Load the icon from the path as a list of bytes
    final ByteData dataStart = await rootBundle.load(iconPath);

    // Resize the icon to a smaller size. If the icons by default have a huge size will be crazy big on the screen.
    // I discovered in my case that the best iconSize for a custom marker is width = 75 and height = 100.
    ui.Codec codec = await ui.instantiateImageCodec(
        dataStart.buffer.asUint8List(),
        targetWidth: iconSize.width.toInt());
    ui.FrameInfo fi = await codec.getNextFrame();

    Uint8List dataEnd =
    ((await fi.image.toByteData(format: ui.ImageByteFormat.png)) ??
        ByteData(0))
        .buffer
        .asUint8List();

    ui.Image image = await _loadImage(Uint8List.view(dataEnd.buffer));

    //Move the icon from left to right or up to down
    canvas.drawImage(image, Offset(x - (image.width / 2), y + 25), Paint());

    ui.Picture p = pictureRecorder.endRecording();

    //This sets the total height of the icon along with the text
    ByteData? pngBytes = await (await p.toImage(
      textWidth < image.width ? image.width : textWidth,
      textHeight + image.height + 25,
    ))
        .toByteData(format: ui.ImageByteFormat.png);

    return pngBytes?.buffer.asUint8List();
  }

  static Future<ui.Image> _loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}
