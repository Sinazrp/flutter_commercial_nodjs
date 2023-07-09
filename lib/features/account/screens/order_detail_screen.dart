import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/account/widget/order_product_list.dart';
import 'package:intl/intl.dart';

import '../../../model/order.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;
  static const String route = "/orderDetails";
  final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  // ignore: prefer_function_declarations_over_variables
  final String Function(Match) mathFunc = (Match match) => '${match[1]},';

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
    var date24 = DateFormat('dd/MM/yyyy').format(date);
    return Scaffold(
      appBar: AppBar(
        title: const Text('جزئیات سفارش'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            OrderProductList(order: order),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 226, 225, 225),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(' : ارسال به ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Center(
                          child: Text(order.address,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text.rich(TextSpan(
                    children: [
                      TextSpan(text: 'تاریخ ارسال'),
                    ],
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                Text(date24)
              ],
            ),
            Column(
              children: [
                const Text.rich(TextSpan(
                    children: [
                      TextSpan(text: ' جمع کل'),
                    ],
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                Text(
                    ' ${order.totalPrice.round().toString().replaceAllMapped(reg, mathFunc)} ')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
