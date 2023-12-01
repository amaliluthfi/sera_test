import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/common/widgets/loading_bar.dart';
import 'package:sera_test/common/widgets/spacer.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/module/cart/bloc/cart_bloc.dart';

import '../widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    getIt<CartBloc>().add(CartFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {},
          bloc: getIt<CartBloc>(),
          builder: (context, state) {
            return ListView.builder(
                padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                    bottom: MediaQuery.sizeOf(context).height / 5),
                itemCount: state.cart.length,
                itemBuilder: (context, index) {
                  if (state.status != CartStatus.success) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: LoadingBar(
                        height: 150,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                    );
                  } else {
                    Product item = state.cart[index];
                    return CartCard(item: item);
                  }
                });
          }),
      bottomSheet: BlocBuilder<CartBloc, CartState>(
          bloc: getIt<CartBloc>(),
          builder: (context, state) {
            return Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 5.0, color: Colors.grey),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("total ${state.cart.length} items"),
                        Text(
                          NumberFormat.compactCurrency()
                              .format(getIt<CartBloc>().addAllPrice()),
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),
                    const SpaceH16(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.sizeOf(context).width, 54)),
                      child: const Text(
                        "Checkout",
                      ),
                      onPressed: () {},
                    ),
                  ],
                ));
          }),
    );
  }
}
