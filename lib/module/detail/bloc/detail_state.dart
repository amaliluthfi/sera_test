// ignore_for_file: override_on_non_overriding_member

part of 'detail_bloc.dart';

enum DetailStatus { initial, success, failure }

final class DetailState {
  const DetailState({
    this.status = DetailStatus.initial,
    this.product = const <Product>[],
  });

  final DetailStatus status;
  final List<Product> product;

  DetailState copyWith({
    DetailStatus? status,
    List<Product>? product,
  }) {
    return DetailState(
      status: status ?? this.status,
      product: product ?? this.product,
    );
  }

  @override
  List<Object> get props => [status, product];
}
