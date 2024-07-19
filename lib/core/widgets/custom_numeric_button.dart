import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/widgets/small_progress_indicator.dart';

class NumericStepButton extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final int counter;

  final AsyncValueSetter<int> onChanged;

  const NumericStepButton(
      {Key? key,
      this.minValue = 1,
      this.maxValue = 10,
      required this.counter,
      required this.onChanged})
      : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  LoadingState addButtonLoadingState = LoadingState.loaded;
  LoadingState subtractButtonLoadingState = LoadingState.loaded;

  late int tempCounter;

  @override
  void initState() {
    super.initState();
    tempCounter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * .6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () async {
              setState(() {
                subtractButtonLoadingState = LoadingState.loading;
                if (tempCounter > widget.minValue) {
                  tempCounter--;
                }
              });
              await widget.onChanged(tempCounter);

              setState(() {
                subtractButtonLoadingState = LoadingState.loaded;
              });
            },
            child: subtractButtonLoadingState == LoadingState.loaded
                ? Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black87,
                    ),
                  )
                : const SmallProgressIndicator(
                    size: 15.0,
                  ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$tempCounter',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                addButtonLoadingState = LoadingState.loading;
                if (widget.counter < widget.maxValue) {
                  tempCounter++;
                }
              });

              await widget.onChanged(tempCounter);

              setState(() {
                addButtonLoadingState = LoadingState.loaded;
              });
            },
            child: addButtonLoadingState == LoadingState.loaded
                ? Container(
                    decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    padding: const EdgeInsets.all(3),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                    ),
                  )
                : const SmallProgressIndicator(
                    size: 15.0,
                  ),
          ),
        ],
      ),
    );
  }
}
