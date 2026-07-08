import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product_model.dart';

class WishlistCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const WishlistCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onRemove,
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
        horizontal: 15,
        vertical: 8,
      ),
      child: ListTile(
        onTap: onTap,

        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            product.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image),
              );
            },
          ),
        ),

        title: Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        subtitle: Text(
          rupiah.format(product.price),
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),

        trailing: IconButton(
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: onRemove,
        ),
      ),
    );
  }
}