import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/error/errors.dart';
import 'package:mortuary/core/popups/show_popups.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/get/auth_controller.dart';
import 'package:mortuary/features/death_report/presentation/widget/authorized_person/reporter_map_view.dart';
import 'package:mortuary/features/processing_unit_report/presentation/get/processing_unit_controller.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../common/death_report_list_screen.dart';

class ProcessDepartment{

  ProcessDepartment({
    required this.id,
    required this.name,
    required this.image,
    this.status = "",
  });

  final int id;
  final String name;
  final String image;
  final String status;
}

class ProcessingDepartmentScreen extends StatelessWidget {
  final UserRole currentUserRole;
  final String bodyScanCode;

  List<ProcessDepartment> departmentList = [
    ProcessDepartment(id: 1,image: AppAssets.icCleaningBody,name:AppStrings.processingCenter),
    ProcessDepartment(id: 2,image: AppAssets.icAutopsy,name:AppStrings.autopsyPostMartam),
    ProcessDepartment(id: 3,image: AppAssets.icRefrigerator,name:AppStrings.refrigerator),
    ProcessDepartment(id: 4,image: AppAssets.icCementry,name:AppStrings.cementry),
    ProcessDepartment(id: 5,image: AppAssets.icCoffin,name:AppStrings.shipToLocal),

  ];

  ProcessingDepartmentScreen({Key? key, required this.currentUserRole, required this.bodyScanCode})
      : super(key: key);

  AuthController authController = Get.find();



  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcessingUnitController>(
      initState: (_){
        Get.find<ProcessingUnitController>().currentUserRole = currentUserRole;
      },
      builder: (controller) {
        return CustomScreenWidget(
            crossAxisAlignment: CrossAxisAlignment.center,
            titleText:  AppStrings.processingDepartment.toUpperCase(),
            children: [
              ...departmentList.map((item) {
                return GestureDetector(
                    onTap: (){
                      controller.showQRCodeScannerScreen(currentUserRole, -111,
                          isMorgueScannedProcessingDepartment: true,
                          onApiCallBack: (response){
                        print("bodyCode =>$bodyScanCode");
                        print("unintCode =>${response['qr_code']}");
                      });
                    },
                    child: createContainerView(item.id,item.image,item.name));
              }).toList(),



              sizeFieldMediumPlaceHolder,

          ]);


      }
    );
  }

  Widget createContainerView(int departmentCodeId, String image, String title,
      {String status = "", Color color = Colors.amber}) {
    return  Container(
        width: Get.width,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.hexToColor("#E1E5F0"),width: 1),
          borderRadius: BorderRadius.circular(20),
            color: Colors.white
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                SvgPicture.asset(image),
                sizeFieldMediumPlaceHolder,
                CustomTextWidget(text: title,size: 13,fontWeight: FontWeight.w600,colorText: AppColors.secondaryTextColor,)
              ],),
          ),
            Visibility(
              visible: status != "",
              child: Positioned(
                  right: 0,
                  top:20,
                  child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                  color: color,
                ),
                child: Padding(
                    padding:const EdgeInsets.only(left: 15),
                    child:CustomTextWidget(
                  text: status,
                  colorText: Colors.white,

                )),
              )),
            )
        ],)
    );
  }
}
