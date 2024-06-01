import 'package:flutter/material.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/custom_screen_widget.dart';
import '../../../domain/enities/processing_center.dart';
import '../../components/processing_center_list_component.dart';

class ProcessingUnitListScreen extends StatelessWidget {
  final List<ProcessingCenter> processingCenters;
  final int deathReportId;
  final int deathCaseId;

  const ProcessingUnitListScreen(
      {Key? key, required this.processingCenters, required this.deathReportId , required this.deathCaseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScreenWidget(
        titleText: AppStrings.processingCenter,
        children: [
          processingCenters.isEmpty
              ? const Center(
                  child: CustomTextWidget(
                    text: ApiMessages.dataNotFound,
                  ),
                )
              : ListView.separated(
                  itemCount: processingCenters.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {

                    return ProcessingCenterRowItemWidget(
                      listItem: processingCenters[index],
                      deathReportId: deathReportId,
                      deathCaseId: deathCaseId,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                )
        ]);
  }
}
