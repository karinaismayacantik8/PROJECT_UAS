import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/order_provider.dart';

class AdminOrderPage extends StatefulWidget {
  const AdminOrderPage({super.key});

  @override
  State<AdminOrderPage> createState() =>
      _AdminOrderPageState();
}

class _AdminOrderPageState
    extends State<AdminOrderPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrderProvider>().getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<OrderProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Kelola Order"),
      ),

      body: provider.loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView.builder(

              itemCount:
                  provider.orders.length,

              itemBuilder: (_, index) {

                final order =
                    provider.orders[index];

                return Card(

                  margin:
                      const EdgeInsets.all(10),

                  child: ListTile(

                    leading: const Icon(
                      Icons.shopping_cart,
                    ),

                    title: Text(
                      order.customerName,
                    ),

                    subtitle: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(order.status),

                        Text(
                          "Rp ${order.totalPrice}",
                        ),

                      ],

                    ),

                    trailing: const Icon(
                      Icons.chevron_right,
                    ),

                    onTap: () {

                      // Detail Order
                    },

                  ),

                );

              },

            ),

    );
  }
}