import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/common/widgets/spacer.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/module/cart/bloc/cart_bloc.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.item,
  });

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.images?[0] == null
                    ? const Icon(Icons.image_not_supported_rounded)
                    : Image.network(
                        item.images?[0] ?? "",
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported_rounded,
                              size: 100,
                            ),
                          );
                        },
                        width: 100,
                      ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 3,
                    child: Text(
                      item.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    NumberFormat.compactCurrency().format(item.price ?? 0),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SpaceH16(),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder()),
                        onPressed: () {
                          getIt<CartBloc>().add(MinusCart(id: item.id ?? 999));
                        },
                        child: Text(
                          "-",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Text(
                        "${item.quantity}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder()),
                        onPressed: () {
                          getIt<CartBloc>().add(PlusCart(id: item.id ?? 999));
                        },
                        child: Text(
                          "+",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                getIt<CartBloc>().add(DeleteCart(id: item.id ?? 999));
              },
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
