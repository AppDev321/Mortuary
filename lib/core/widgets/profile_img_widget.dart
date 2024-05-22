import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/utils/validators.dart';
import 'package:mortuary/core/widgets/network_img_loader.dart';
import 'package:mortuary/features/authentication/presentation/get/auth_controller.dart';

/// This widget is built on top of [ProfileImageWidget], and enables
/// error messages in case the [image] is not null. This functionality
/// is decided by [validate] param.
///
class ProfileImageField extends FormField<File> {
  final File? image;
  final bool validate;

  ProfileImageField({super.key, this.image, this.validate = true})
      : super(
            initialValue: image,
            validator: validate ? DynamicFieldValidator.validator : null,
            builder: (state) {
              return Column(
                children: [
                  ProfileImageWidget(
                    imageFile: image,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  if (state.hasError) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Builder(
                            builder: (context) => Text(
                                  state.errorText ?? "Validation Error",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.red),
                                )),
                      ],
                    ),
                  ],
                ],
              );
            });
}

/// Uses [NetworkImageLoader] and [Image.file] to display user's image,
/// from [imageUrl] and [imageFile] respectively.
/// If both of the image sources are null, an [Icon] is displayed.
/// The profile icon is set according to the signup screen, because it
/// will only be displayed on [UserRegisterPage], that uses
/// [ProfileImageField], that is built on top of this widget
class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({Key? key, this.imageFile, this.imageUrl})
      : super(key: key);

  final File? imageFile;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double longestSide = screenSize.longestSide;

    // Calculate the width based on the screen's longest side
    double containerSize = longestSide * 0.12; // Adjust this factor as needed
    containerSize =
        containerSize.clamp(50, 60); // Clamp the value between 50 and 120
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      child: Container(
          height: containerSize,
          width: containerSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // image: DecorationImage(
            //   fit: imageUrl != null || imageFile != null ? BoxFit.cover : BoxFit.scaleDown,
            //   image: ,
            // ),
          ),
          clipBehavior: Clip.hardEdge,
          child: imageUrl != null || imageFile != null
              ? imageUrl != null
                  ? imageUrl!.isNotEmpty
                      ? NetworkImageLoader(
                          imageUrl: imageUrl!,
                          progressType: ImageProgressType.circular,
                          headers: {
                            'Cookie':
                                'session_id=${Get.find<AuthController>().session!.sessionId!}',
                          },
                        )
                      : const Icon(
                          Icons.person_outline,
                          size: 50.0,
                          color: Colors.blueGrey,
                        )
                  : Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    )
              : const Icon(
                  Icons.add_a_photo_outlined,
                  size: 50.0,
                  color: Colors.blueGrey,
                )
          // Image.asset(icon_person, fit: BoxFit.scaleDown),
          ),
    );
  }
}
