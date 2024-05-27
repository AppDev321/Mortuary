import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/popups/show_popups.dart';
import 'package:mortuary/core/utils/app_config_service.dart';
import 'package:mortuary/core/utils/validators.dart';
import 'package:mortuary/core/widgets/button_widget.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/place_holders.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/custom_screen_widget.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../../qr_scanner/presentation/widget/ai_barcode_scanner.dart';
import '../get/document_controller.dart';

class DocumentUploadScreen extends StatelessWidget {
  final UserRole currentUserRole;

  DocumentUploadScreen({Key? key, required this.currentUserRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(

        builder: (controller) {
         return CustomScreenWidget(
           titleText: AppStrings.documents.toUpperCase(),
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Center(
                  child: const CustomTextWidget(
                    text: AppStrings.documentsLabel,
                    colorText: AppColors.secondaryTextColor,
                    textAlign: TextAlign.center,
                  ),
                ),

              ]);
        });
  }
}
