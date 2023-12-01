import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/core/session/bloc/session/session_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sera_test/module/cart/bloc/cart_bloc.dart';
import 'package:sera_test/module/detail/bloc/detail_bloc.dart';
import 'package:sera_test/module/home/bloc/home_bloc.dart';
import 'package:sera_test/module/search/bloc/search_bloc.dart';

final GetIt getIt = GetIt.instance;

class DISetup {
  static Future<void> init() async {
    await hiveInit();

    getIt.registerLazySingleton<SessionBloc>(() => SessionBloc());
    getIt.registerLazySingleton<HomeBloc>(() => HomeBloc());
    getIt.registerLazySingleton<SearchBloc>(() => SearchBloc());
    getIt.registerLazySingleton<DetailBloc>(() => DetailBloc());
    getIt.registerLazySingleton<CartBloc>(() => CartBloc());
  }

  static hiveInit() async {
    debugPrint("init hive...");
    var dir = await path_provider.getApplicationCacheDirectory();

    Hive.init(dir.path);
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(CategoryAdapter());
    await Hive.openBox("session");
    await Hive.openBox<Product>("cart");
  }
}
