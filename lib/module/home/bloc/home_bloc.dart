import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/module/cart/bloc/cart_bloc.dart';
import 'package:sera_test/module/home/data/models/category_model.dart';
import 'package:sera_test/module/home/repo/home_repo.dart';

part 'home_state.dart';
part 'home_events.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<OnFetched>(_onFetched);
    on<SelectCategory>(_selectCategory);
    on<ProductAddtoCart>(_onProductAddtoCart);
    on<DeleteFromCart>(_onDeleteFromCart);
  }
  final _homeRepo = HomeRepo();

  List<Categories> categories = [];

  Future<void> _onFetched(OnFetched event, Emitter<HomeState> emit) async {
    try {
      debugPrint("category fetching...");
      emit(state.copyWith(status: HomeStatus.initial));
      var resCat = await _homeRepo.getAllCatgeoryRepo();
      var resProd = await _homeRepo.getAllProductRepo();

      emit(state.copyWith(
          status: HomeStatus.success, categories: resCat, product: resProd));

      debugPrint("fetching sucess ${state.status}");
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  _selectCategory(SelectCategory event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.productLoading));

      state.categories[event.index].selected =
          !state.categories[event.index].selected;
      for (var element in state.categories) {
        if (element.id != state.categories[event.index].id) {
          element.selected = false;
        }
      }

      List<Product> res;

      if (state.categories[event.index].selected == false) {
        debugPrint("masuk sini");
        res = await _homeRepo.getAllProductRepo();
      } else {
        debugPrint("masuk sini 2");
        res = await _homeRepo.getAllProductRepo(
            cateryId: state.categories[event.index].id);
      }

      emit(state.copyWith(
        categories: state.categories,
        product: res,
        status: HomeStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  _onProductAddtoCart(ProductAddtoCart event, Emitter<HomeState> emit) {
    if (event.product.addedToCart == false) {
      for (var element in state.product) {
        if (element.id == event.product.id) {
          element.addedToCart = true;
        }
      }

      getIt<CartBloc>().add(AddCart(data: event.product));
      emit(state.copyWith(product: state.product));

      showDialog(
          context: event.context,
          builder: (context) {
            return const AlertDialog(
              icon: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 50,
              ),
              title: Text("Success"),
              content: Text(
                "add to cart sucess",
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  _onDeleteFromCart(DeleteFromCart event, Emitter<HomeState> emit) {
    for (var element in state.product) {
      if (element.id == event.id) {
        element.quantity = 0;
        element.addedToCart = false;
      }
    }

    emit(state.copyWith(product: state.product));
  }
}
