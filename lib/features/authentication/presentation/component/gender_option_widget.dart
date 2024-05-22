import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';

class CustomGenderRadio extends StatelessWidget {
  Gender _gender;

  CustomGenderRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2,color: _gender.isSelected ?Theme.of(context).primaryColor:Colors.grey.withOpacity(0.5))
      ),
      alignment: Alignment.center,
      margin:  EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            _gender.icon,
            height: 40,
            width: 40,
          ),
         sizeHorizontalFieldMediumPlaceHolder,
          CustomTextWidget(
            text:     _gender.name,
            size: 13,
            fontWeight: FontWeight.w600,
          )

        ],
      ),
    );
  }
}


class Gender {
  String name;
  String icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}