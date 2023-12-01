// ignore_for_file: override_on_non_overriding_member

part of 'detail_bloc.dart';

sealed class DetailEvents {
  @override
  List<Object> get props => [];
}

final class DetailFetched extends DetailEvents {
  DetailFetched({required this.params});

  final String params;
}
