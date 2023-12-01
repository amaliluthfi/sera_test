// ignore_for_file: override_on_non_overriding_member

part of 'search_bloc.dart';

sealed class SearchEvents {
  @override
  List<Object> get props => [];
}

final class SearchProduct extends SearchEvents {
  SearchProduct({required this.params});

  final String params;
}

final class ProductLoaded extends SearchEvents {
  ProductLoaded({required this.params});

  final String params;
}

final class ClearProduct extends SearchEvents {}
