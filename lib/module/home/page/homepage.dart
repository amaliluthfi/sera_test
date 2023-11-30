import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/common/widgets/loading_bar.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/core/route/route_const.dart';
import 'package:sera_test/core/session/bloc/session/session_bloc.dart';
import 'package:sera_test/module/home/bloc/home_bloc.dart';
import 'package:sera_test/module/home/data/models/category_model.dart';

import '../widgets/home_loading.dart';
import '../widgets/product_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SessionBloc sessionBloc = getIt<SessionBloc>();
  HomeBloc homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    homeBloc.add(OnFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Image.network(
                    sessionBloc.profile?.avatar ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("ShopIT"),
              actions: [
                IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(RouteConst.searchRoute),
                    icon: const Icon(Icons.search_rounded)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined))
              ],
            ),
            body: state.status == HomeStatus.initial
                ? const HomeLoading()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 16),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "hi, ${sessionBloc.profile?.name}",
                            ),
                            Text(
                              "What are you looking for today?",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              Categories item = state.categories[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InputChip(
                                  selected: item.selected,
                                  selectedColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  label: Text(item.name ?? ""),
                                  onSelected: (val) {
                                    homeBloc.add(SelectCategory(index: index));
                                  },
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          2, // number of items in each row
                                      mainAxisSpacing:
                                          30, // spacing between rows
                                      crossAxisSpacing:
                                          20, // spacing between columns
                                      childAspectRatio: 1 / 1.5),
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  state.status == HomeStatus.productLoading
                                      ? 10
                                      : state.product.length,
                              itemBuilder: (context, index) {
                                if (state.status == HomeStatus.productLoading) {
                                  return const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: LoadingBar(
                                        width: 60,
                                        height: 60,
                                      ));
                                } else {
                                  Product item = state.product[index];
                                  return ProductCard(item: item);
                                }
                              }),
                        )
                      ],
                    ),
                  ),
          );
        });
  }
}
