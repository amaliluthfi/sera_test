part of 'search_bloc.dart';

enum SearchStatus { initial, success, failure, productLoading }

final class SearchState {
  const SearchState({
    this.status = SearchStatus.initial,
    this.product = const <Product>[],
  });

  final SearchStatus status;
  final List<Product> product;

  SearchState copyWith({
    SearchStatus? status,
    List<Product>? product,
  }) {
    return SearchState(
      status: status ?? this.status,
      product: product ?? this.product,
    );
  }

  @override
  List<Object> get props => [status, product];
}
