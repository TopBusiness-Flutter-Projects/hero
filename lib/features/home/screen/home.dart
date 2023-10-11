import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:hero/features/home/screen/home_tab.dart';
import 'package:hero/features/home/screen/without_destination_tab.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_button.dart';
import '../components/drawer_list_item.dart';
import 'add_trip_tab.dart';

class Home extends StatefulWidget {
  // int page = 0;

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
 late TabController controller ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =  TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      body: TabBarView(
        controller: controller,
        children: [
          HomeTab(),
          AddTripTab(),
          TripWithoutDestination()
        ],
      ),


    );
  }
}
