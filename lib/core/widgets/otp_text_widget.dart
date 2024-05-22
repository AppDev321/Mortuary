import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ResendOtpText extends StatefulWidget {
  const ResendOtpText({Key? key}) : super(key: key);

  @override
  _ResendOtpTextState createState() => _ResendOtpTextState();
}

class _ResendOtpTextState extends State<ResendOtpText> {
  late Timer _timer;
  int _countdown = 30; // Initial countdown time in seconds
  bool _isResendEnabled = false;
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = () => _handleResend();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _isResendEnabled = true;
          _timer.cancel(); // Stop the timer when countdown reaches 0
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    _tapGestureRecognizer.dispose(); // Dispose of the TapGestureRecognizer
    super.dispose();
  }

  void _handleResend() {
    // Add your logic to handle the "Resend Code" button press here
    // For example, you can trigger the resend process and reset the timer.
    // For simplicity, we will just reset the timer here.
    setState(() {
      _isResendEnabled = false;
      _countdown = 30; // Reset the countdown
      _startCountdown(); // Start the countdown again
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: RichText(
        text: TextSpan(
          text: "Didn't receive the OTP? ",
          style: const TextStyle(fontSize: 13.0, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'Resend Code',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: _isResendEnabled
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey, // Disable the button when not enabled
              ),
              recognizer: _isResendEnabled ? _tapGestureRecognizer : null,
            ),
            TextSpan(
              text: ' in 00:${_countdown.toString().padLeft(2, '0')}',
            ),
          ],
        ),
      ),
    );
  }
}
