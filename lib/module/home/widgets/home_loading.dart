import 'package:flutter/material.dart';
import 'package:sera_test/common/widgets/loading_bar.dart';
import 'package:sera_test/common/widgets/spacer.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoadingBar(
            width: 200,
          ),
          const SpaceH8(),
          const LoadingBar(
            width: 300,
          ),
          const SpaceH8(),
          const LoadingBar(
            width: 400,
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LoadingBar(
                      width: 60,
                    ),
                  );
                }),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LoadingBar(
                      width: 60,
                      height: 60,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
