// ignore_for_file: override_on_non_overriding_member

part of 'cart_bloc.dart';

enum CartStatus { initial, success, failure, productLoading }

final class CartState {
  const CartState({
    this.status = CartStatus.initial,
    this.cart = const <Product>[],
  });

  final CartStatus status;
  final List<Product> cart;

  CartState copyWith({
    CartStatus? status,
    List<Product>? cart,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object> get props => [status, cart];
}
