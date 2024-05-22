import 'package:flutter/material.dart';

Widget get sizeSectionSmallPlaceHolder => const SizedBox(
      height: 20.0,
    );

Widget get sizeSectionMediumPlaceHolder => const SizedBox(
      height: 30.0,
    );

Widget get minPlaceHolder => const SizedBox(
      height: 5.0,
    );

Widget get sizeFieldMinPlaceHolder => const SizedBox(
      height: 10.0,
    );

Widget get sizeHorizontalMinPlaceHolder => const SizedBox(
      width: 5.0,
    );

Widget get sizeHorizontalFieldMinPlaceHolder => const SizedBox(
      width: 10.0,
    );

Widget get sizeFieldSmallPlaceHolder => const SizedBox(
      height: 15.0,
    );

Widget get sizeHorizontalFieldSmallPlaceHolder => const SizedBox(
      width: 15.0,
    );

Widget get sizeFieldMediumPlaceHolder => const SizedBox(
      height: 20.0,
    );

Widget get sizeHorizontalFieldMediumPlaceHolder => const SizedBox(
      width: 20.0,
    );

Widget get sizeHorizontalFieldLargePlaceHolder => const SizedBox(
      width: 30.0,
    );

Widget get sizeFieldLargePlaceHolder => const SizedBox(
      height: 30.0,
    );

Widget get sizePageTopSmallPlaceHolder => const SizedBox(
      height: 15.0,
    );

Widget get sizePageTopPlaceHolder => const SizedBox(
      height: 20.0,
    );

Widget get sizePageTopLargePlaceHolder => const SizedBox(
      height: 30.0,
    );

Widget get sizePageBottomPlaceHolder => const SizedBox(
      height: 20.0,
    );

Widget get sizePageBottomLargePlaceHolder => const SizedBox(
      height: 30.0,
    );

Widget get equivalentOfIconButton => const SizedBox(
      height: 48.0,
      width: 48.0,
    );

Widget divider(context) => Column(
  children: [
    sizeFieldMinPlaceHolder,
        Divider(
          color: Theme.of(context).colorScheme.outlineVariant,
          height: 1,
        ),
    sizeFieldMinPlaceHolder,
  ],
);
