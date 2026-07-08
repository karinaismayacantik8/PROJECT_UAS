import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product_model.dart';

class AdminProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AdminProductCard({
    super.key,
    required this.product,
    required this.onEdit,
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
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10),
              child: Image.network(
                product.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) {
                  return Container(
                    width: 90,
                    height: 90,
                    color:
                        Colors.grey.shade300,
                    child: const Icon(
                      Icons.image,
                      size: 40,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    product.name,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    rupiah.format(
                        product.price),
                    style:
                        const TextStyle(
                      color: Colors.red,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(
                        Icons.inventory_2,
                        size: 18,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        "Stok : ${product.stock}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  if (product.category != null)

                    Row(
                      children: [

                        const Icon(
                          Icons.category,
                          size: 18,
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(
                            product
                                .category!
                                .name,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      Chip(
                        label: Text(
                          product.isActive
                              ? "Aktif"
                              : "Nonaktif",
                        ),
                        backgroundColor:
                            product.isActive
                                ? Colors.green
                                    .shade100
                                : Colors.red
                                    .shade100,
                      ),

                      const Spacer(),

                      IconButton(
                        tooltip:
                            "Edit Produk",
                        onPressed: onEdit,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),

                      IconButton(
                        tooltip:
                            "Hapus Produk",
                        onPressed:
                            onDelete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}