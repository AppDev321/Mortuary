import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mortuary/core/constants/app_lottie.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AppLottie.noDataFound, repeat: true),
            // const SizedBox(
            //   height: 10.0,
            // ),
            // const CustomTextWidget(
            //   text: ApiMessages.dataNotFound,
            // )
          ],
        ),
      ),
    );
  }
}


