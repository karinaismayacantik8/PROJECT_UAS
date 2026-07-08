import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/cart_model.dart';

class CartItemCard extends StatelessWidget {
  final CartModel cart;

  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.cart,
    required this.onPlus,
    required this.onMinus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final rupiah = NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp ",
      decimalDigits: 0,
    );

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [

            /// ======================
            /// IMAGE
            /// ======================

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cart.product.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            /// ======================
            /// INFO
            /// ======================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    cart.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    rupiah.format(cart.product.price),
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      IconButton(
                        onPressed: onMinus,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),

                      Text(
                        cart.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: onPlus,
                        icon: const Icon(Icons.add_circle_outline),
                      ),

                    ],
                  ),

                ],
              ),
            ),

            /// ======================
            /// DELETE
            /// ======================

            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}