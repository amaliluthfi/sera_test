// ignore_for_file: override_on_non_overriding_member

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

final class ProductAddtoCart extends HomeEvents {
  ProductAddtoCart({required this.product, required this.context});

  final Product product;
  final BuildContext context;
}

final class DeleteFromCart extends HomeEvents {
  DeleteFromCart({required this.id});

  final int id;
}
