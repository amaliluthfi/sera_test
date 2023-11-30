part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure, productLoading }

final class HomeState {
  const HomeState(
      {this.status = HomeStatus.initial,
      this.categories = const <Categories>[],
      this.product = const <Product>[],
      this.allFalse = false});

  final HomeStatus status;
  final List<Categories> categories;
  final List<Product> product;
  final bool allFalse;

  HomeState copyWith({
    HomeStatus? status,
    List<Categories>? categories,
    List<Product>? product,
    bool? allFalse,
  }) {
    return HomeState(
        status: status ?? this.status,
        categories: categories ?? this.categories,
        product: product ?? this.product,
        allFalse: allFalse ?? false);
  }

  @override
  List<Object> get props => [status, categories, product, allFalse];
}
