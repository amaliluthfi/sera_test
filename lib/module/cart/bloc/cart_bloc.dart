import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/module/cart/repo/cart_repo.dart';
import 'package:sera_test/module/home/bloc/home_bloc.dart';

part 'cart_events.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvents, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddCart>(_onAddCart);
    on<CartFetched>(_onCartFetched);
    on<PlusCart>(_onPlusCart);
    on<MinusCart>(_onMinusCart);
    on<DeleteCart>(_onDeleteCart);
  }

  final CartRepo _cartRepo = CartRepo();

  _onCartFetched(CartFetched event, Emitter<CartState> emit) {
    emit(state.copyWith(
        status: CartStatus.success, cart: _cartRepo.getCartRepo()));
  }

  _onAddCart(AddCart event, Emitter<CartState> emit) {
    if (!state.cart.any((element) => element.id == event.data.id)) {
      event.data.quantity = 1;
      _cartRepo.addCartRepo(data: event.data);
      emit(state.copyWith(cart: state.cart));
    }
  }

  _onPlusCart(PlusCart event, Emitter<CartState> emit) {
    for (var i = 0; i < state.cart.length; i++) {
      if (event.id == state.cart[i].id) {
        state.cart[i].quantity++;
        _cartRepo.updateCartRepo(data: state.cart[i], id: i);
      }
    }

    emit(state.copyWith(cart: state.cart));
  }

  _onMinusCart(MinusCart event, Emitter<CartState> emit) {
    for (var i = 0; i < state.cart.length; i++) {
      if (event.id == state.cart[i].id && state.cart[i].quantity > 1) {
        state.cart[i].quantity--;
        _cartRepo.updateCartRepo(data: state.cart[i], id: i);
      }
    }

    emit(state.copyWith(cart: state.cart));
  }

  _onDeleteCart(DeleteCart event, Emitter<CartState> emit) {
    for (var i = 0; i < state.cart.length; i++) {
      if (state.cart[i].id == event.id) {
        _cartRepo.deleteCart(id: i);
        state.cart.removeAt(i);
      }
    }

    emit(state.copyWith(cart: state.cart));
    getIt<HomeBloc>().add(DeleteFromCart(id: event.id));
  }

  int addAllPrice() {
    int total = 0;
    for (var i = 0; i < state.cart.length; i++) {
      total += (state.cart[i].quantity * (state.cart[i].price ?? 0));
    }

    return total;
  }
}
