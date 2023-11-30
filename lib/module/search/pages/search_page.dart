import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/common/widgets/loading_bar.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/module/search/bloc/search_bloc.dart';

import '../widgets/search_product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void dispose() {
    getIt<SearchBloc>().add(ClearProduct());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
          bloc: getIt<SearchBloc>(),
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 60,
                    child: TextField(
                      onChanged: (value) {
                        getIt<SearchBloc>().add(SearchProduct(params: value));
                      },
                      decoration: InputDecoration(
                          label: const Text("search"),
                          contentPadding: const EdgeInsets.all(8),
                          suffix: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: state.product.length,
                      itemBuilder: (context, index) {
                        if (state.status == SearchStatus.success) {
                          Product item = state.product[index];
                          return SearchProductCard(item: item);
                        } else {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: LoadingBar(
                              height: 150,
                              width: MediaQuery.sizeOf(context).width,
                            ),
                          );
                        }
                      }),
                ),
              ],
            );
          }),
    );
  }
}
