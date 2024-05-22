import 'package:flutter/material.dart';

enum PaymentResult {
  success("Payment Successful", Icons.check_circle, Colors.green),
  failure("Payment Failed", Icons.cancel, Colors.red);

  const PaymentResult(this.message, this.icon, this.color);
  final String message;
  final IconData icon;
  final Color color;
}

class PaymentResultDialog extends StatelessWidget {
  const PaymentResultDialog({Key? key, required this.paymentResult})
      : super(key: key);

  final PaymentResult paymentResult;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            paymentResult.icon,
            color: paymentResult.color,
            size: 100.0,
          ),
          const SizedBox(height: 10.0),
          Text(paymentResult.message),
        ],
      ),
    );
  }
}
