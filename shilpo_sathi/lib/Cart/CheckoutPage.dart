import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'CartProvider.dart';
import 'MobileBankingPage.dart';

// Helper: Parse string price to double, ignoring any non-numeric chars
double parsePrice(String priceStr) {
  final cleaned = priceStr.replaceAll(RegExp(r'[^0-9.]'), '');
  return double.tryParse(cleaned) ?? 0.0;
}

// Helper: Format number as Taka currency
String formatTaka(double amount) => '৳${amount.toStringAsFixed(2)}';

class CheckoutPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();

  String selectedPayment = '';

  @override
  void initState() {
    super.initState();
    _addressController.text = '1233, Akhaliya, Sylhet';
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = ref.watch(cartProvider.notifier).totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Enter your delivery address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),

            const Text('Promo Code', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promoCodeController,
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF252C35),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  onPressed: () {
                    final promoCode = _promoCodeController.text;
                    if (promoCode.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Promo code "$promoCode" applied!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a promo code.')),
                      );
                    }
                  },
                  child: const Text('Apply', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Payment Methods', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            PaymentMethodCard(
              icon: Icons.credit_card,
              title: 'Credit/Debit Card',
              selected: selectedPayment == 'card',
              onTap: () => setState(() => selectedPayment = 'card'),
            ),
            const SizedBox(height: 8),
            PaymentMethodCard(
              icon: Icons.mobile_friendly,
              title: 'Mobile Banking',
              selected: selectedPayment == 'mobile',
              onTap: () async {
                setState(() => selectedPayment = 'mobile');
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MobileBankingPage(amount: totalPrice + 5.0),
                  ),
                );

                if (result != null && result['success'] == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment successful! TrxID: ${result['trxId']}')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment failed or cancelled')),
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            PaymentMethodCard(
              icon: Icons.account_balance,
              title: 'Bank Transfer',
              selected: selectedPayment == 'bank',
              onTap: () => setState(() => selectedPayment = 'bank'),
            ),
            const SizedBox(height: 8),
            PaymentMethodCard(
              icon: Icons.money,
              title: 'Cash on Delivery',
              selected: selectedPayment == 'cash',
              onTap: () => setState(() => selectedPayment = 'cash'),
            ),
            const SizedBox(height: 24),

            const Text('Order Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    summaryRow('Subtotal', formatTaka(totalPrice)),
                    const SizedBox(height: 8),
                    summaryRow('Shipping', formatTaka(5.0)),
                    const Divider(),
                    summaryRow('Total', formatTaka(totalPrice + 5.0), bold: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            if (selectedPayment == 'cash')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF252C35),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    final address = _addressController.text;
                    if (address.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a delivery address.')),
                      );
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).pop();
                            setState(() {
                              _addressController.clear();
                              _promoCodeController.clear();
                              selectedPayment = '';
                            });
                            ref.read(cartProvider.notifier).clearCart();
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                title: const Text('Order Confirmed!', textAlign: TextAlign.center),
                                content: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green, size: 50),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            );
                          });

                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                CircularProgressIndicator(color: Colors.green),
                                SizedBox(height: 16),
                                Text('Placing your order...', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Place Order', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: bold ? 18 : 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: bold ? 18 : 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;

  const PaymentMethodCard({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected ? Colors.green.shade100 : Colors.white,
      elevation: selected ? 6 : 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: selected ? Colors.green : const Color(0xFF252C35)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.green.shade900 : Colors.black87,
          ),
        ),
        trailing: selected ? const Icon(Icons.check_circle, color: Colors.green) : const Icon(Icons.arrow_forward_ios, color: Color(0xFF252C35)),
        onTap: onTap,
      ),
    );
  }
}