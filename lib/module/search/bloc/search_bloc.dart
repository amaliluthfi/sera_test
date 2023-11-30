import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/module/search/repo/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvents, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchProduct>(_onSearchProduct);
    on<ProductLoaded>(_onProductLoaded);
    on<ClearProduct>(_onClearProduct);
  }

  final _searchRepo = SearchRepo();
  Timer? _debounce;

  Future<void> _onSearchProduct(
      SearchProduct event, Emitter<SearchState> emit) async {
    try {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(seconds: 1), () async {
        add(ProductLoaded(params: event.params));
      });

      debugPrint("ini status ${state.status} ${state.product}");
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure));
      rethrow;
    }
  }

  Future<void> _onProductLoaded(
      ProductLoaded event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(status: SearchStatus.productLoading));
      var res = await _searchRepo.searchProductRepo(params: event.params);
      emit(state.copyWith(status: SearchStatus.success, product: res));

      debugPrint("ini status ${state.status} ${state.product}");
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure));
      rethrow;
    }
  }

  Future<void> _onClearProduct(
      ClearProduct event, Emitter<SearchState> emit) async {
    state.product.clear();
    emit(state.copyWith(product: state.product));
  }
}
