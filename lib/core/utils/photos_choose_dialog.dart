import 'package:flutter/material.dart';

import 'app_colors.dart';


choosePhoto(
    BuildContext context, VoidCallback cameraClick, VoidCallback photoClick) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text('Choose'),
      ),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        child: Row(
          children: [
            const Spacer(),
            InkWell(
              onTap: cameraClick,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 45, color: AppColors.gray),
                    Text('camera')
                  ],
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: photoClick,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo, size: 45, color: AppColors.gray),
                    Text('Gallery')
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'))
      ],
    ),
  );
}
