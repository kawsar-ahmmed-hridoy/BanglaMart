import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';

class MobileBankingPage extends StatelessWidget {
  final double amount;
  const MobileBankingPage({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flutterBkash = FlutterBkash();

    return Scaffold(
      appBar: AppBar(title: const Text('bKash Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final result = await flutterBkash.pay(
                context: context,
                amount: amount,
                merchantInvoiceNumber: 'INV-${DateTime.now().millisecondsSinceEpoch}',
              );

              if (result.trxId != null && result.paymentId != null) {
                Navigator.pop(context, {
                  'success': true,
                  'paymentId': result.paymentId,
                  'trxId': result.trxId,
                });
              } else {
                Navigator.pop(context, {'success': false});
              }
            } catch (e) {
              Navigator.pop(context, {'success': false, 'error': e.toString()});
            }
          },
          child: Text("Pay ৳${amount.toStringAsFixed(2)} via bKash"),
        ),
      ),
    );
  }
}
