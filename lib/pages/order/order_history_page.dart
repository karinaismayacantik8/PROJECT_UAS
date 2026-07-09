import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() =>
      _OrderHistoryPageState();
}

class _OrderHistoryPageState
    extends State<OrderHistoryPage> {

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
        title: const Text("Riwayat Pesanan"),
      ),

      body: provider.loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : provider.orders.isEmpty

              ? const Center(
                  child: Text(
                    "Belum ada pesanan",
                  ),
                )

              : RefreshIndicator(

                  onRefresh: () =>
                      provider.getOrders(),

                  child: ListView.builder(

                    itemCount:
                        provider.orders.length,

                    itemBuilder: (_, index) {

                      final order =
                          provider.orders[index];

                      return Card(

                        margin:
                            const EdgeInsets.all(10),

                        child: ListTile(

                          leading: const CircleAvatar(
                            child:
                                Icon(Icons.receipt),
                          ),

                          title: Text(
                            order.id,
                          ),

                          subtitle: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(
                                  "Status : ${order.status}"),

                              Text(
                                  "Total : Rp ${order.totalPrice}"),

                              Text(
                                  order.createdAt),

                            ],

                          ),

                        ),

                      );

                    },

                  ),

                ),

    );
  }
}