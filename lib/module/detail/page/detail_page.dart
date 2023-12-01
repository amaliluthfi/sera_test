import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/common/widgets/spacer.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.id, this.data});

  final int? id;
  final Product? data;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    Product item = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title ?? "sads"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  aspectRatio: 1 / 1,
                  viewportFraction: 1,
                ),
                items: List.generate(item.images?.length ?? 0, (index) {
                  return Image.network(
                    item.images?[index] ?? "",
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          size: 100,
                        ),
                      );
                    },
                  );
                }),
              ),
              const SpaceH8(),
              Text(
                item.title ?? "",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                NumberFormat.compactCurrency().format(item.price ?? 0),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SpaceH16(),
              Text(
                item.description ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
