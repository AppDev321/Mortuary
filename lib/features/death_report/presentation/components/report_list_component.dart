import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/enities/death_report_list_reponse.dart';

class ReportListItem extends StatelessWidget {
  final DeathReportListResponse listItem;
  const ReportListItem({Key? key, required this.listItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Stack(
      children:[
        Positioned(
          top: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextWidget(
                  text: convertAppStyleDate(listItem.reportDate),
                  colorText: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.w700,
                  size: 14,
                  textAlign: TextAlign.right,
                ),
                CustomTextWidget(
                  text: listItem.reportTime,
                  colorText: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.right,
                  size: 12,
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 100,
          child:  Container(
            height: Get.height * 0.7,
            width: 1.0,
            color: Colors.grey.shade400,
          ),
        ),
        Positioned(
            left: 90,
            top:80,
            child: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color:AppColors.hexToColor(listItem.status.color), width: 2)),
            )),


        Positioned(
          right: 0,
          left: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: containerReportData(),
          ),
        ),

      ] );


  }

  Widget containerReportData()
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.hexToColor(listItem.status.color),
      ),

      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1,color: Color(0xFFE1E5F0)),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Table(
                children: [
                  rowData(AppStrings.qrNumber,listItem.bandCode),
                  rowData(AppStrings.idType,listItem.visaType),
                  rowData(AppStrings.idNumber,listItem.idNumber),
                  rowData(AppStrings.nationality,listItem.nationality),
                  rowData(AppStrings.gender,listItem.gender),
                  rowData(AppStrings.age,listItem.age),
                  rowData(AppStrings.ageGroup,listItem.ageGroup),
                  rowData(AppStrings.deathType,listItem.deathType),

                ],
              ),
            ),
          ),
          const Padding(
            padding:  EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
            child: CustomTextWidget(text: AppStrings.onWayToProcess,textAlign:TextAlign.center,colorText: AppColors.whiteAccent,fontWeight: FontWeight.w500,size: 14,),
          ),
        ],
      ),
    );
  }
  TableRow rowData(String title,String body)
  {
    return TableRow(
      children: [
        CustomTextWidget(text: title,colorText: AppColors.secondaryTextColor,fontWeight: FontWeight.w600,size: 14,),
        CustomTextWidget(text: body,fontWeight: FontWeight.w500,size: 14,)
      ],);
  }
}
