import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}
class _MyOrdersPageState extends State<MyOrdersPage> {
  List<Order> orders = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    orders = [
      Order(
        orderId: 'ORD12345',
        date: DateTime.now().subtract(Duration(days: 1)),
        totalAmount: 2500.0,
        paymentMethod: 'Cash on Delivery',
        status: 'Delivered',
        deliveryAddress: '1233, Akhaliya, Sylhet',
      ),
      Order(
        orderId: 'ORD12346',
        date: DateTime.now().subtract(Duration(days: 4)),
        totalAmount: 1800.0,
        paymentMethod: 'Mobile Banking',
        status: 'Shipped',
        deliveryAddress: '456, Green Road, Dhaka',
      ),
    ];

    setState(() => isLoading = false);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadOrders,
            tooltip: 'Refresh Orders',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'You have no orders yet.\nStart shopping now!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${order.orderId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${dateFormat.format(order.date)}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Payment: ${order.paymentMethod}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Delivery Address:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.deliveryAddress,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ৳${order.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Text(
                          order.status,
                          style: TextStyle(
                            color: _getStatusColor(order.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Order {
  final String orderId;
  final DateTime date;
  final double totalAmount;
  final String paymentMethod;
  final String status;
  final String deliveryAddress;

  Order({
    required this.orderId,
    required this.date,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    required this.deliveryAddress,
  });
}
