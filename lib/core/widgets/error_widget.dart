import 'package:flutter/material.dart';
import '../error/errors.dart';
import '../styles/styles.dart';
import 'button_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  final Future Function()? reStart;
  final CustomError? customError;
  final Icon? icon;
  final String? text;
  const CustomErrorWidget({
    super.key,
    required this.customError,
    this.icon,
    this.text,
    this.reStart,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              customError!.iconData,
              size: 100.0,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
            Text(
              maxLines: 5,
              customError!.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              maxLines: 5,
              customError!.message!,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25.0,
            ),
            if (reStart != null)
              ButtonWidget(
                height: 50,
                width: 280,
                margin: AppStyles.formMargin,
                text: text ?? 'Refresh',
                expand: true,
                buttonType: ButtonType.fill,
                radius: 10.0,
                icon: icon,
                onPressed: reStart,
                textStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              )
          ],
        ),
      ),
    );
  }
}
