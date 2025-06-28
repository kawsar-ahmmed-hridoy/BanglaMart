import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';

class MobileBankingPage extends StatelessWidget {
  final double amount;
  const MobileBankingPage({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flutterBkash = FlutterBkash();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'bKash Payment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.pink, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/bkash.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 12),
                Text(
                  'Pay ৳${amount.toStringAsFixed(2)} via bKash',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
