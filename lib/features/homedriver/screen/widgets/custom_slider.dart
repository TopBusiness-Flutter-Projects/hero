import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/utils/app_colors.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    this.items,

  });


  final List<Widget>? items;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width/4,
          //height: 180,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            items: widget.items,
            options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
               // height: 200 ,
              //  height: MediaQuery.of(context).size.width/2 ,
                clipBehavior: Clip.none,
                autoPlay: true,

                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.linear,
                autoPlayInterval: const Duration(seconds: 3),
                scrollDirection: Axis.horizontal),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: widget.items!.asMap().entries.map((entry) {
        //     return Container(
        //       width: 10.0,
        //       height: 10.0,
        //       margin: const EdgeInsets.symmetric(
        //           vertical: 8.0, horizontal: 4.0),
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color:_current == entry.key ? (AppColors.primary)
        //               .withOpacity( 0.4):AppColors.secondPrimary
        //       ),
        //     );
        //   }).toList(),
        // )
      ],
    );
  }
}
