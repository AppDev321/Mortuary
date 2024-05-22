import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/place_holders.dart';

class ImageChoiceDialog extends StatelessWidget {
  const ImageChoiceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Image Source',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize!,
                  fontWeight: FontWeight.bold),
            ),
            sizeFieldLargePlaceHolder,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageOption(
                  onTap: () {
                    Get.back(result: ImageSource.camera);
                  },
                  iconData: Icons.camera_alt_outlined,
                  title: 'Camera',
                ),
                const SizedBox(
                  width: 20.0,
                ),
                ImageOption(
                  onTap: () {
                    Get.back(result: ImageSource.gallery);
                  },
                  iconData: Icons.photo_library,
                  title: 'Gallery',
                )
              ],
            ),
            sizeFieldSmallPlaceHolder
          ],
        ),
      ),
    );
  }
}

class ImageOption extends StatelessWidget {
  const ImageOption(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.iconData})
      : super(key: key);

  final Function() onTap;
  final String title;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(.2),
          borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 25.0,
            ),
            const SizedBox(height: 8.0),
            Text(title),
          ],
        ),
      ),
    );
  }
}
