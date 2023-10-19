import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_manager.dart';
import '../utils/getsize.dart';

class CloseWidget extends StatelessWidget {
  const CloseWidget({super.key,this.onTap});
 final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:onTap,
        child: SvgPicture.asset(
          ImageAssets.close,
          width: getSize(context) * 0.04,
        ));
  }
}
