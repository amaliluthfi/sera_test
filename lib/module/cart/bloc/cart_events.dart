// ignore_for_file: override_on_non_overriding_member

part of 'cart_bloc.dart';

sealed class CartEvents {
  @override
  List<Object> get props => [];
}

final class CartFetched extends CartEvents {}

final class AddCart extends CartEvents {
  AddCart({required this.data});

  final Product data;
}

final class DeleteCart extends CartEvents {
  DeleteCart({required this.id});

  final int id;
}

final class PlusCart extends CartEvents {
  PlusCart({required this.id});

  final int id;
}

final class MinusCart extends CartEvents {
  MinusCart({required this.id});

  final int id;
}
