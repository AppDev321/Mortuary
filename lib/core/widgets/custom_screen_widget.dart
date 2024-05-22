import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/app_assets.dart';
import '../styles/colors.dart';
import 'custom_text_widget.dart';


class CustomScreenWidget extends StatelessWidget {
  final List<Widget> children;
  final Widget? drawer;
  final bool isDrawerEnabled;
  final String? titleText;
  final List<Widget>? actions;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  bool isBiographyScreen;

  CustomScreenWidget(
      {Key? key,
      this.drawer,
      this.titleText,
      this.actions,
      this.isDrawerEnabled = false,
      this.isBiographyScreen = false,
      required this.children,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: key,
        // drawer: drawer,
        backgroundColor: Colors.transparent,
        appBar: AppBar(

            elevation: 0.0,
            backgroundColor:Colors.white,
            actions: actions,
            leading: SizedBox(),
            //leading:
                // isDrawerEnabled
                //     ? IconButton(
                //         icon: SvgPicture.asset(
                //           AppAssets.icon_drawer,
                //         ),
                //         onPressed: () {
                //           Scaffold.of(context).openDrawer();
                //           // Handle drawer button tap
                //           // Add your logic here to open the drawer
                //         },
                //       )
                //     :
            //     Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: GestureDetector(
            //     onTap: () {
            //       Get.back();
            //     },
            //     child: SvgPicture.asset(
            //       AppAssets.icAppBackArrow,
            //     ),
            //   ),
            // ),
            centerTitle: true,
            title: CustomTextWidget(
                    maxLines: 1,
                    // Limit the title to one line
                    text: titleText,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    size: 24,
                  )),
        body:  Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: AppColors.appBackgroundColor,
          ),
          child:  SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 20,
                  left: isBiographyScreen ? 0 : 12,
                  right: isBiographyScreen ? 0 : 12),
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ),
          ),
        ));
  }
}
