import 'package:flutter/material.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';

class CustomExpansionTile extends StatelessWidget {
  final String tileText;
  final List<Widget> children;

  const CustomExpansionTile(
      {super.key, required this.tileText, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:  const BorderRadius.all(Radius.circular(15),),
        border: Border.all(color: AppColors.hexToColor("#E1E5F0"),width: 1)

      ),
      child: Theme(
        data:Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Set divider color to transparent
        ),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.all(15),
          title: CustomTextWidget(text: tileText,size: 15,fontWeight: FontWeight.w600,),
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children),
          ],
        ),
      ),
    );
  }
}
