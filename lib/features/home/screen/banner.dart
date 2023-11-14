import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/home_model.dart';
import '../../../core/widgets/network_image.dart';
import 'dots.dart';


class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key, this.isDotes = true, required this.sliderData})
      : super(key: key);
  final List<SliderModel> sliderData;
  final bool isDotes;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.sliderData.isEmpty) {
      return Container();
    } else {
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                onPageChanged: (int i, CarouselPageChangedReason c) {
                  setState(() {
                    page = i;
                  });
                },
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlay: true,
                height: MediaQuery.of(context).size.height * 0.18,
                reverse: false,
                viewportFraction: 1.0),
            items: widget.sliderData.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(i.link.toString()),
                          mode: LaunchMode.externalApplication);
                    },
                    child: ManageNetworkImage(
                      imageUrl: i.image!,
                      borderRadius: 10,
                      width: MediaQuery.of(context).size.width * 0.85,

                    ),
                  );
                },
              );
            }).toList(),
          ),
          widget.isDotes == true
              ? const SizedBox(height: 18)
              : const SizedBox(height: 0),
          widget.isDotes == true
              ? DotesWidget(
            page: page,
            length: widget.sliderData.length,
          )
              : Container(),
        ],
      );
    }
  }
}
