part of 'home_bloc.dart';

sealed class HomeEvents {
  @override
  List<Object> get props => [];
}

final class OnFetched extends HomeEvents {}

final class SelectCategory extends HomeEvents {
  SelectCategory({required this.index});

  final int index;
}

final class ProductFetched extends HomeEvents {}