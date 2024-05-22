import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';

import '../../../../core/constants/app_strings.dart';

class ReportListItem extends StatelessWidget {
  ReportListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Stack(
      children:[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextWidget(
                text: "15th May\n2024",
                colorText: AppColors.secondaryTextColor,
                fontWeight: FontWeight.w700,
                size: 14,
              ),
              CustomTextWidget(
                text: "102:14:21 Am",
                colorText: AppColors.secondaryTextColor,
                fontWeight: FontWeight.w500,
                size: 12,
              )
            ],
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
            bottom: 10,
            child: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueAccent, width: 2)),
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
        color: Colors.amber,
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
                  rowData(AppStrings.idType,"123123"),
                  rowData(AppStrings.idNumber,"123123123123123123123123123123123123"),
                  rowData(AppStrings.gender,"AMle"),
                  rowData(AppStrings.ageGroup,"12"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
            child: CustomTextWidget(text: AppStrings.onWayToProcess,textAlign:TextAlign.center,colorText: AppColors.whiteAccent,fontWeight: FontWeight.bold,size: 14,),
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
